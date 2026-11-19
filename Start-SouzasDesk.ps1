#Requires -Version 5.1
<#
.SYNOPSIS
    Souzas Desk v0.1 - menu de diagnosticos para Windows.
.DESCRIPTION
    Ponto de entrada. Importa os modulos e exibe opcoes de leitura/diagnostico.
    Nao requer elevacao e nao modifica configuracoes do Windows.
#>

$ErrorActionPreference = 'Stop'

if ($env:OS -ne 'Windows_NT') {
    throw 'O Souzas Desk v0.1 requer Windows 10/11.'
}

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ModulesFolder = Join-Path $ProjectRoot 'src\Modules'
$DataFolder = Join-Path $ProjectRoot 'data'

foreach ($ModuleName in @('SystemInfo.psm1', 'NetworkInfo.psm1', 'Reporting.psm1', 'Audit.psm1')) {
    $ModulePath = Join-Path $ModulesFolder $ModuleName
    Import-Module -Name $ModulePath -Force -ErrorAction Stop
}

function Show-SDMenu {
    Clear-Host
    Write-Host '================================================' -ForegroundColor Cyan
    Write-Host '            SOUZAS DESK | v0.1.0              ' -ForegroundColor Cyan
    Write-Host '          Windows Support Toolkit             ' -ForegroundColor Cyan
    Write-Host '================================================' -ForegroundColor Cyan
    Write-Host '  [1] Informacoes do sistema'
    Write-Host '  [2] Configuracao de rede'
    Write-Host '  [3] Teste de conectividade (ping)'
    Write-Host '  [4] Exportar relatorio JSON (sem IP/usuario)'
    Write-Host '  [0] Sair'
    Write-Host '------------------------------------------------'
    Write-Host 'Modo: diagnostico (sem alteracoes no Windows)' -ForegroundColor Green
    Write-Host ''
}

function Invoke-SDMenuAction {
    param(
        [Parameter(Mandatory = $true)][string] $ActionCode,
        [Parameter(Mandatory = $true)][scriptblock] $Action
    )

    try {
        & $Action
        Write-SDAuditEvent -Action $ActionCode -Status 'OK' -DataFolder $DataFolder
    }
    catch {
        Write-Warning ('Falha ao executar {0}: {1}' -f $ActionCode, $_.Exception.Message)
        try {
            Write-SDAuditEvent -Action $ActionCode -Status 'ERRO' -DataFolder $DataFolder
        }
        catch {
            Write-Warning 'Nao foi possivel salvar o registro local.'
        }
    }
    [void] (Read-Host 'Pressione Enter para voltar ao menu')
}

while ($true) {
    Show-SDMenu
    $Option = (Read-Host 'Escolha uma opcao').Trim()

    switch ($Option) {
        '1' {
            Invoke-SDMenuAction -ActionCode 'SISTEMA' -Action {
                Get-SDSystemInfo | Format-List | Out-Host
            }
        }
        '2' {
            Invoke-SDMenuAction -ActionCode 'REDE' -Action {
                $Connections = @(Get-SDNetworkInfo)
                if ($Connections.Count -eq 0) {
                    Write-Host 'Nenhuma interface ativa com IPv4 foi encontrada.'
                }
                else {
                    $Connections | Format-Table -AutoSize | Out-Host
                }
            }
        }
        '3' {
            Invoke-SDMenuAction -ActionCode 'PING' -Action {
                Write-Host 'Este teste envia pacotes ICMP para o destino digitado.'
                $Target = (Read-Host 'Host/IP (padrao: 127.0.0.1)').Trim()
                if ([string]::IsNullOrWhiteSpace($Target)) {
                    $Target = '127.0.0.1'
                }
                Test-SDConnectivity -Target $Target | Format-List | Out-Host
            }
        }
        '4' {
            Invoke-SDMenuAction -ActionCode 'RELATORIO' -Action {
                $Info = Get-SDSystemInfo
                $Connections = @(Get-SDNetworkInfo)
                $ReportPath = Export-SDReport -SystemInfo $Info -NetworkInfo $Connections -DataFolder $DataFolder
                Write-Host ('Relatorio criado em: {0}' -f $ReportPath) -ForegroundColor Green
                Write-Host 'O relatorio omite IP, nome do PC e usuario.'
            }
        }
        '0' {
            Write-Host 'Encerrando Souzas Desk. Ate mais!'
            return
        }
        default {
            Write-Warning 'Opcao invalida.'
            [void] (Read-Host 'Pressione Enter para tentar novamente')
        }
    }
}
