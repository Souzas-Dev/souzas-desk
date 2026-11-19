#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot

Import-Module (Join-Path $Root 'src\Modules\Audit.psm1') -Global -Force -ErrorAction Stop
Import-Module (Join-Path $Root 'src\Modules\MenuAction.psm1') -Global -Force -ErrorAction Stop

$TempDir = Join-Path $env:TEMP (
    'SouzasDesk-Audit-' + [guid]::NewGuid().ToString('N')
)

try {
    New-Item -Path $TempDir -ItemType Directory -Force | Out-Null

    Write-Host '[1/3] Testando auditoria de sucesso...'

    $AvisosOK = @()

    Invoke-SDAction -ActionCode 'TESTE' `
        -Action { $null = 1 + 1 } `
        -DataFolder $TempDir `
        -WarningVariable AvisosOK

    if ($AvisosOK.Count -ne 0) {
        throw 'Diagnostico bem-sucedido gerou avisos.'
    }

    Write-Host '[2/3] Testando auditoria de falha...'

    $AvisosErro = @()

    Invoke-SDAction -ActionCode 'TESTE' `
        -Action { throw 'Falha simulada' } `
        -DataFolder $TempDir `
        -WarningAction SilentlyContinue `
        -WarningVariable AvisosErro

    if ($AvisosErro.Count -ne 1) {
        throw 'Era esperado um aviso de diagnostico.'
    }

    Write-Host '[3/3] Conferindo arquivo CSV...'

    $Log = Join-Path $TempDir 'logs\acoes.csv'

    if (-not (Test-Path -LiteralPath $Log)) {
        throw 'Arquivo CSV nao encontrado.'
    }

    $Rows = @(Import-Csv -LiteralPath $Log)

    if ($Rows.Count -ne 2) {
        throw 'Quantidade incorreta de registros.'
    }

    if ($Rows[0].Acao -ne 'TESTE' -or $Rows[0].Status -ne 'OK') {
        throw 'Registro de sucesso incorreto.'
    }

    if ($Rows[1].Acao -ne 'TESTE' -or $Rows[1].Status -ne 'ERRO') {
        throw 'Registro de erro incorreto.'
    }

    $Campos = @($Rows[0].PSObject.Properties.Name)

    if ($Campos.Count -ne 3 -or
        @($Campos | Where-Object { $_ -notin @('DataHora','Acao','Status') }).Count -gt 0) {
        throw 'Estrutura CSV inesperada.'
    }

    Write-Host 'PASSOU: auditoria CSV real validada.' -ForegroundColor Green
}
finally {
    Remove-Item -LiteralPath $TempDir -Recurse -Force -ErrorAction SilentlyContinue
}
