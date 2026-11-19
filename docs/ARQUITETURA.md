# Arquitetura da v0.1

## Objetivo

Criar um painel de diagnóstico local em PowerShell sem executar alteracoes no Windows.

## Fluxo

```text
Usuario (terminal)
        |
        v
Start-SouzasDesk.ps1 (menu)
        |
        +-- SystemInfo.psm1 ----> consulta CIM (Windows)
        |
        +-- NetworkInfo.psm1 ---> consulta IP e teste ICMP
        |
        +-- Reporting.psm1 -----> data/reports/*.json
        |
        `-- Audit.psm1 ---------> data/logs/acoes.csv
```

`Start-SouzasDesk.ps1` coordena as funções e trata as opcoes digitadas. Cada `.psm1` concentra uma responsabilidade. `tests/Smoke.Tests.ps1` verifica sintaxe e o comportamento básico.

## Contrato das funções

- `Get-SDSystemInfo`: retorna objeto PowerShell com sistema, versao, build, arquitetura, processador, RAM e horas ligado.
- `Get-SDNetworkInfo`: retorna zero ou mais objetos com interface, IPv4, gateway e DNS da interface ativa.
- `Test-SDConnectivity -Target <host>`: testa ICMP, sem alterar rede; falha de ping não comprova falha de internet.
- `Export-SDReport -SystemInfo ... -NetworkInfo ... -DataFolder ...`: gera JSON resumido e omite identificadores de rede e usuário.
- `Write-SDAuditEvent -Action ... -Status ... -DataFolder ...`: escreve um evento em CSV sem dados de identificacao.

## Convencoes

- Funcoes com prefixo `SD` para reduzir conflito de nomes.
- Verbos PowerShell claros (`Get`, `Test`, `Export`, `Write`).
- Mensagens curtas no menu e módulos que **retornam objetos**, em vez de formatar a saida internamente.
- Erros tratados no ponto de entrada e sem esconder a causa principal na interface.

## Limitacoes conhecidas

- Os módulos `NetTCPIP` e `CimCmdlets` precisam estar disponiveis no Windows.
- Não existe suporte a execucao remota ou via Intune nesta versao.
- Os testes de integração devem ser executados no Windows, em uma conta comum.
