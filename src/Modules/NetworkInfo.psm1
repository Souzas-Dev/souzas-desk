<#
.SYNOPSIS
    Consulta dados das interfaces de rede e testa ping opcional.
#>
function Get-SDNetworkInfo {
    [CmdletBinding()]
    param()

    $Configurations = @(Get-NetIPConfiguration -ErrorAction Stop |
        Where-Object { $null -ne $_.IPv4Address -and $null -ne $_.NetAdapter -and $_.NetAdapter.Status -eq 'Up' })

    foreach ($Config in $Configurations) {
        $IPv4 = @($Config.IPv4Address | ForEach-Object { $_.IPAddress }) -join ', '
        $Gateway = @($Config.IPv4DefaultGateway | ForEach-Object { $_.NextHop }) -join ', '
        $DNS = @($Config.DNSServer.ServerAddresses | Where-Object { $_ }) -join ', '

        [pscustomobject][ordered]@{
            Interface = $Config.InterfaceAlias
            IPv4      = $IPv4
            Gateway   = $Gateway
            DNS       = $DNS
        }
    }
}

function Test-SDConnectivity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][string] $Target
    )

    # Permite apenas IPs/nomes de host comuns; nao constroi comandos dinamicos.
    if ($Target.Length -gt 253 -or $Target -notmatch '^[A-Za-z0-9][A-Za-z0-9.\-:]*$') {
        throw 'Destino invalido. Informe um IP ou nome de host sem espacos.'
    }

    # Ping pode ser bloqueado por firewall, mesmo com a rede funcionando.
    $Responded = [bool](Test-Connection -ComputerName $Target -Count 2 -Quiet -ErrorAction SilentlyContinue)

    [pscustomobject][ordered]@{
        Destino           = $Target
        RespondeuAoPing  = $Responded
        Observacao       = if ($Responded) { 'O destino respondeu.' } else { 'Sem resposta ICMP; isso nao prova falta de rede.' }
    }
}

Export-ModuleMember -Function Get-SDNetworkInfo, Test-SDConnectivity
