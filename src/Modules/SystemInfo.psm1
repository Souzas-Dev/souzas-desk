<#
.SYNOPSIS
    Coleta dados basicos do Windows sem modificar nada.
#>
function Get-SDSystemInfo {
    [CmdletBinding()]
    param()

    $OS = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
    $Computer = Get-CimInstance -ClassName Win32_ComputerSystem -ErrorAction Stop
    $CPU = Get-CimInstance -ClassName Win32_Processor -ErrorAction Stop | Select-Object -First 1
    $Uptime = (Get-Date) - $OS.LastBootUpTime

    [pscustomobject][ordered]@{
        Sistema             = $OS.Caption.Trim()
        Versao              = $OS.Version
        Build               = $OS.BuildNumber
        Arquitetura         = $OS.OSArchitecture
        Processador         = $CPU.Name.Trim()
        MemoriaGB           = [math]::Round([double]$Computer.TotalPhysicalMemory / 1GB, 2)
        HorasLigado         = [math]::Round($Uptime.TotalHours, 1)
    }
}

Export-ModuleMember -Function Get-SDSystemInfo
