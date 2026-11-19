<#
.SYNOPSIS
    Registra somente o codigo da acao, status e horario (sem dados de usuario/rede).
#>
function Write-SDAuditEvent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][ValidateSet('SISTEMA', 'REDE', 'PING', 'RELATORIO', 'TESTE')][string] $Action,
        [Parameter(Mandatory = $true)][ValidateSet('OK', 'ERRO')][string] $Status,
        [Parameter(Mandatory = $true)][string] $DataFolder
    )

    $LogFolder = Join-Path $DataFolder 'logs'
    if (-not (Test-Path -LiteralPath $LogFolder -PathType Container)) {
        New-Item -Path $LogFolder -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }

    $File = Join-Path $LogFolder 'acoes.csv'
    if (-not (Test-Path -LiteralPath $File -PathType Leaf)) {
        Set-Content -LiteralPath $File -Value 'DataHora,Acao,Status' -Encoding UTF8 -ErrorAction Stop
    }

    $Timestamp = (Get-Date).ToString('o')
    Add-Content -LiteralPath $File -Value ('{0},{1},{2}' -f $Timestamp, $Action, $Status) -Encoding UTF8 -ErrorAction Stop
}

Export-ModuleMember -Function Write-SDAuditEvent
