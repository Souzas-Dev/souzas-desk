#Requires -Version 5.1
<#
.SYNOPSIS
    Teste basico sem Pester: sintaxe, comandos, consultas e relatorio.
#>
$ErrorActionPreference = 'Stop'
if ($env:OS -ne 'Windows_NT') {
    throw 'Execute este teste no Windows PowerShell 5.1.'
}

$Root = Split-Path -Parent $PSScriptRoot
$ModulesDir = Join-Path $Root 'src\Modules'

Write-Host '[1/5] Checando sintaxe PowerShell...'
foreach ($File in @(Get-ChildItem -Path $Root -Recurse -File | Where-Object { $_.Extension -in @('.ps1', '.psm1') })) {
    $Tokens = $null
    $ParserErrors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($File.FullName, [ref] $Tokens, [ref] $ParserErrors)
    if ($ParserErrors.Count -gt 0) {
        throw ('Erro de sintaxe em {0}: {1}' -f $File.Name, $ParserErrors[0].Message)
    }
}

Write-Host '[2/5] Carregando modulos...'
foreach ($ModuleName in @('SystemInfo.psm1', 'NetworkInfo.psm1', 'Reporting.psm1', 'Audit.psm1')) {
    Import-Module -Name (Join-Path $ModulesDir $ModuleName) -Force -ErrorAction Stop
}

Write-Host '[3/5] Consultando o Windows e a rede...'
$System = Get-SDSystemInfo
if ([string]::IsNullOrWhiteSpace($System.Sistema)) {
    throw 'A consulta de sistema nao retornou o nome do Windows.'
}
$Network = @(Get-SDNetworkInfo)

Write-Host '[4/5] Criando relatorio local e conferindo campos...'
$DataDir = Join-Path $Root 'data'
$Path = Export-SDReport -SystemInfo $System -NetworkInfo $Network -DataFolder $DataDir
if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
    throw 'O arquivo JSON nao foi criado.'
}
$Json = Get-Content -LiteralPath $Path -Raw -Encoding UTF8 | ConvertFrom-Json
$PrivateFields = @('IPv4', 'Gateway', 'DNS', 'Usuario', 'Hostname', 'MAC', 'Interface')
foreach ($Field in $PrivateFields) {
    if ($Json.PSObject.Properties.Name -contains $Field) {
        throw ('O relatorio contem o campo privado: {0}' -f $Field)
    }
}
if (-not $Json.Projeto) {
    throw 'O relatorio esta incompleto.'
}

Write-Host '[5/5] Criando um registro local...'
Write-SDAuditEvent -Action 'TESTE' -Status 'OK' -DataFolder $DataDir
$Log = Join-Path (Join-Path $DataDir 'logs') 'acoes.csv'
if (-not (Test-Path -LiteralPath $Log -PathType Leaf)) {
    throw 'O registro CSV nao foi criado.'
}

Write-Host 'PASSOU: verificacoes basicas concluidas.' -ForegroundColor Green
Write-Host ('Relatorio de teste: {0}' -f $Path)
