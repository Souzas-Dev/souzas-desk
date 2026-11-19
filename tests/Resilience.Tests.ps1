#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
Import-Module (Join-Path $Root 'src\Modules\NetworkInfo.psm1') -Force
Import-Module (Join-Path $Root 'src\Modules\Reporting.psm1') -Force
Import-Module (Join-Path $Root 'src\Modules\Audit.psm1') -Force

$Falhas = @()

Write-Host '[1/3] Validacao de destinos...'

$Validador = Get-Command Test-SDValidTarget -ErrorAction SilentlyContinue

if (-not $Validador) {
    $Falhas += 'Funcao Test-SDValidTarget ainda nao implementada.'
}
else {
    foreach ($Target in @('localhost', 'example.com', '127.0.0.1', '::1')) {
        if (-not (Test-SDValidTarget -Target $Target)) {
            $Falhas += "Destino valido recusado: $Target"
        }
    }

    foreach ($Target in @('host..example', 'host-', '256.1.1.1', 'bad host')) {
        if (Test-SDValidTarget -Target $Target) {
            $Falhas += "Destino invalido aceito: $Target"
        }
    }
}

$Temp = Join-Path $env:TEMP ('SD-Resilience-' + [guid]::NewGuid().ToString('N'))

try {
    New-Item -ItemType Directory -Path $Temp -Force | Out-Null

    Write-Host '[2/3] Relatorio com dados incompletos...'

    $Invalido = Join-Path $Temp 'incompleto'
    $Rejeitou = $false

    try {
        $null = Export-SDReport -SystemInfo ([pscustomobject]@{
            Versao = '11'
        }) -DataFolder $Invalido
    }
    catch {
        $Rejeitou = $true
    }

    if (-not $Rejeitou) {
        $Falhas += 'Relatorio incompleto foi aceito.'
    }

    if (Test-Path (Join-Path $Invalido 'reports')) {
        $Falhas += 'Relatorio invalido criou arquivos ou diretorios.'
    }

    Write-Host '[3/3] Falhas de armazenamento...'

    $Bloqueado = Join-Path $Temp 'arquivo.txt'
    Set-Content -LiteralPath $Bloqueado -Value 'teste'

    $Sistema = [pscustomobject]@{ Sistema = 'Windows Teste' }

    $ErroRelatorio = $false
    try {
        $null = Export-SDReport -SystemInfo $Sistema -DataFolder $Bloqueado
    }
    catch {
        $ErroRelatorio = $true
    }

    if (-not $ErroRelatorio) {
        $Falhas += 'Falha de armazenamento do JSON nao foi propagada.'
    }

    $ErroAuditoria = $false
    try {
        Write-SDAuditEvent -Action TESTE -Status OK -DataFolder $Bloqueado
    }
    catch {
        $ErroAuditoria = $true
    }

    if (-not $ErroAuditoria) {
        $Falhas += 'Falha de armazenamento do CSV nao foi propagada.'
    }
}
finally {
    Remove-Item -LiteralPath $Temp -Recurse -Force -ErrorAction SilentlyContinue
}

if ($Falhas.Count -gt 0) {
    $Falhas | ForEach-Object { Write-Warning $_ }
    throw "FALHOU: $($Falhas.Count) verificacao(oes) de resiliencia."
}

Write-Host 'PASSOU: todos os testes de resiliencia.' -ForegroundColor Green
