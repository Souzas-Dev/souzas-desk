#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot

Import-Module (
    Join-Path $Root 'src\Modules\MenuAction.psm1'
) -Force -ErrorAction Stop

function Assert-SD {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw "TESTE FALHOU: $Message"
    }
}

$Events = New-Object System.Collections.ArrayList

$AuditOK = {
    param($Code, $Status, $Folder)
    [void]$Events.Add("$Code|$Status")
}.GetNewClosure()

Write-Host '[1/3] Diagnostico bem-sucedido...'

Invoke-SDAction -ActionCode 'TESTE' `
    -Action { $null = 1 + 1 } `
    -DataFolder $env:TEMP `
    -AuditWriter $AuditOK

Assert-SD ($Events.Count -eq 1) 'Quantidade de registros'
Assert-SD ($Events[0] -eq 'TESTE|OK') 'Status esperado: OK'

Write-Host '[2/3] Erro de diagnostico...'

$Events.Clear()

Invoke-SDAction -ActionCode 'TESTE' `
    -Action { throw 'Falha simulada' } `
    -DataFolder $env:TEMP `
    -AuditWriter $AuditOK

Assert-SD ($Events.Count -eq 1) 'Registro unico'
Assert-SD ($Events[0] -eq 'TESTE|ERRO') 'Status esperado: ERRO'

Write-Host '[3/3] Erro somente na auditoria...'

$State = @{ Executed = $false }

$ActionOK = {
    $State.Executed = $true
}.GetNewClosure()

$Warnings = @()

Invoke-SDAction -ActionCode 'TESTE' `
    -Action $ActionOK `
    -DataFolder $env:TEMP `
    -AuditWriter { throw 'Log indisponivel' } `
    -WarningVariable Warnings

Assert-SD $State.Executed 'Diagnostico deve executar'
Assert-SD ($Warnings.Count -eq 1) 'Somente aviso de auditoria'
Assert-SD (
    $Warnings[0].ToString() -match 'registro local'
) 'Mensagem correta de auditoria'

Write-Host 'PASSOU: testes de execucao e auditoria.' -ForegroundColor Green
