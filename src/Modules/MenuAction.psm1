#Requires -Version 5.1

<#
.SYNOPSIS
    Executa uma acao e registra o resultado.

.DESCRIPTION
    Separa erros do diagnostico de erros de auditoria.
    Permite substituir o gravador de log em testes.
#>

function Invoke-SDAction {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateSet('SISTEMA', 'REDE', 'PING', 'RELATORIO', 'TESTE')]
        [string]$ActionCode,

        [Parameter(Mandatory)]
        [scriptblock]$Action,

        [Parameter(Mandatory)]
        [string]$DataFolder,

        [scriptblock]$AuditWriter = {
            param($Code, $Status, $Folder)

            Write-SDAuditEvent -Action $Code `
                -Status $Status `
                -DataFolder $Folder `
                -ErrorAction Stop
        }
    )

    $Status = 'OK'

    # Etapa 1: executar o diagnostico
    try {
        & $Action
    }
    catch {
        $Status = 'ERRO'

        Write-Warning (
            'Falha ao executar {0}: {1}' -f `
            $ActionCode, $_.Exception.Message
        )
    }

    # Etapa 2: registrar o resultado separadamente
    try {
        & $AuditWriter $ActionCode $Status $DataFolder
    }
    catch {
        Write-Warning 'Nao foi possivel salvar o registro local.'
    }
}

Export-ModuleMember -Function Invoke-SDAction
