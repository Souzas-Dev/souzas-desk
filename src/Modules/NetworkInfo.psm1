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

function Test-SDValidTarget {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Target
    )

    if ([string]::IsNullOrWhiteSpace($Target) -or $Target.Length -gt 253) {
        return $false
    }

    $Address = $null

    if ($Target.Contains(':')) {
        if ($Target -notmatch '^[0-9A-Fa-f:.]+$') {
            return $false
        }

        if (-not [System.Net.IPAddress]::TryParse($Target, [ref]$Address)) {
            return $false
        }

        return ($Address.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetworkV6)
    }

    if ($Target -match '^[0-9.]+$') {
        if ($Target -notmatch '^([0-9]{1,3}\.){3}[0-9]{1,3}$') {
            return $false
        }

        if (-not [System.Net.IPAddress]::TryParse($Target, [ref]$Address)) {
            return $false
        }

        return ($Address.AddressFamily -eq [System.Net.Sockets.AddressFamily]::InterNetwork)
    }

    if ($Target -notmatch '^[A-Za-z0-9.-]+$') {
        return $false
    }

    foreach ($Label in $Target.Split('.')) {
        if ($Label.Length -gt 63 -or
            $Label -notmatch '^[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?$') {
            return $false
        }
    }

    return $true
}

function Test-SDConnectivity {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Target
    )

    if (-not (Test-SDValidTarget -Target $Target)) {
        throw 'Destino invalido. Informe um IPv4, IPv6 ou hostname valido.'
    }

    $Responded = [bool](
        Test-Connection -ComputerName $Target -Count 2 -Quiet -ErrorAction SilentlyContinue
    )

    [pscustomobject][ordered]@{
        Destino          = $Target
        RespondeuAoPing = $Responded
        Observacao      = if ($Responded) {
            'O destino respondeu.'
        }
        else {
            'Sem resposta ICMP; isso nao prova falta de rede.'
        }
    }
}

Export-ModuleMember -Function Get-SDNetworkInfo, Test-SDConnectivity, Test-SDValidTarget
