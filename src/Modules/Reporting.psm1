<#
.SYNOPSIS
    Exporta relatorios JSON locais com informacoes reduzidas.
#>
function Export-SDReport {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)][psobject] $SystemInfo,
        [object[]] $NetworkInfo = @(),
        [Parameter(Mandatory = $true)][string] $DataFolder
    )

    $ReportsFolder = Join-Path $DataFolder 'reports'
    if (-not (Test-Path -LiteralPath $ReportsFolder -PathType Container)) {
        New-Item -Path $ReportsFolder -ItemType Directory -Force -ErrorAction Stop | Out-Null
    }

    # Nao inclui IP, gateway, DNS, username, hostname nem nome de interface.
    $Report = [pscustomobject][ordered]@{
        Projeto                 = 'Souzas Desk'
        Versao                  = '0.1.0'
        GeradoEm                = (Get-Date).ToString('o')
        Sistema                 = $SystemInfo.Sistema
        VersaoWindows           = $SystemInfo.Versao
        BuildWindows            = $SystemInfo.Build
        Arquitetura             = $SystemInfo.Arquitetura
        Processador             = $SystemInfo.Processador
        MemoriaGB               = $SystemInfo.MemoriaGB
        HorasLigado             = $SystemInfo.HorasLigado
        InterfacesIPv4Ativas    = @($NetworkInfo).Count
        Aviso                   = 'Dados tecnicos locais; revisar antes de compartilhar.'
    }

    $FileName = 'relatorio-{0}.json' -f (Get-Date -Format 'yyyyMMdd-HHmmss-fff')
    $Path = Join-Path $ReportsFolder $FileName
    $Report | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $Path -Encoding UTF8 -ErrorAction Stop

    return $Path
}

Export-ModuleMember -Function Export-SDReport
