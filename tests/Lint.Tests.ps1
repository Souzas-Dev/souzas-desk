#Requires -Version 5.1
$ErrorActionPreference = 'Stop'

Import-Module PSScriptAnalyzer -RequiredVersion 1.25.0 -ErrorAction Stop

$Root = Split-Path -Parent $PSScriptRoot
$Menu = Join-Path $Root 'Start-SouzasDesk.ps1'
$TestsDir = Join-Path $Root 'tests'

$Files = @(
    Get-Item -LiteralPath $Menu
    Get-ChildItem -Path (Join-Path $Root 'src') -Recurse -File |
        Where-Object { $_.Extension -in @('.ps1', '.psm1') }
    Get-ChildItem -Path $TestsDir -Recurse -File |
        Where-Object { $_.Extension -in @('.ps1', '.psm1') }
)

$Issues = @(
    foreach ($File in $Files) {
        $Params = @{
            Path = $File.FullName
            Severity = @('Error', 'Warning', 'ParseError')
        }

        # Write-Host e permitido na interface e nos testes.
        # Modulos de aplicacao seguem sem essa excecao.
        if ($File.FullName -eq $Menu -or
            $File.FullName.StartsWith(
                ($TestsDir + '\'),
                [StringComparison]::OrdinalIgnoreCase
            )) {
            $Params.ExcludeRule = @('PSAvoidUsingWriteHost')
        }

        Invoke-ScriptAnalyzer @Params
    }
)

if ($Issues.Count -gt 0) {
    $Issues |
        Select-Object ScriptName, Line, Severity, RuleName |
        Format-Table -AutoSize

    throw "Analise estatica encontrou $($Issues.Count) apontamento(s)."
}

Write-Host 'PASSOU: analise estatica do PowerShell.' -ForegroundColor Green
