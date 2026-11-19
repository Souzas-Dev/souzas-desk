# Arquitetura do Souzas Desk

Documentação técnica da arquitetura modular do **Souzas Desk v0.1.0**.

## 1. Visão geral

O Souzas Desk é uma aplicação de terminal desenvolvida em Windows PowerShell para executar diagnósticos locais em computadores Windows.

A arquitetura separa a interface, as consultas de sistema e rede, a geração de relatórios e o registro de auditoria.

**Princípio central:** cada módulo deve possuir uma responsabilidade bem definida.

## 2. Organização do projeto

```text
souzas-desk/
|
|-- Start-SouzasDesk.ps1
|
|-- src/
|   `-- Modules/
|       |-- SystemInfo.psm1
|       |-- NetworkInfo.psm1
|       |-- Reporting.psm1
|       `-- Audit.psm1
|
|-- tests/
|   `-- Smoke.Tests.ps1
|
|-- docs/
|   |-- ARQUITETURA.md
|   |-- DEVLOG.md
|   |-- GIT-GITHUB.md
|   |-- INICIANTES.md
|   |-- ROADMAP.md
|   `-- SEGURANCA.md
|
|-- CHANGELOG.md
|-- README.md
`-- .gitignore
```

## 3. Fluxo de execução

```text
             Usuário
                |
                v
     Start-SouzasDesk.ps1
                |
         Menu interativo
                |
        +-------+--------+
        |                |
        v                v
   SystemInfo        NetworkInfo
        |                |
        +-------+--------+
                |
                v
            Reporting
                |
                v
       Relatório JSON local

     Audit registra ações
       em arquivo CSV
```

O menu principal importa os módulos e coordena as operações.

## 4. Responsabilidades

| Componente | Responsabilidade |
|---|---|
| `Start-SouzasDesk.ps1` | Exibir menu e coordenar ações |
| `SystemInfo.psm1` | Consultar sistema, CPU e memória |
| `NetworkInfo.psm1` | Consultar rede e testar conectividade |
| `Reporting.psm1` | Produzir relatório JSON |
| `Audit.psm1` | Registrar eventos locais |
| `Smoke.Tests.ps1` | Verificar sintaxe e funcionamento básico |

## 5. Contratos das funções

### Get-SDSystemInfo

Retorna um objeto PowerShell contendo:

- Nome e versão do Windows.
- Número de build e arquitetura.
- Processador.
- Memória física em GB.
- Tempo de atividade em horas.

### Get-SDNetworkInfo

Consulta as interfaces de rede ativas com IPv4.

Retorna interface, IPv4, gateway e servidores DNS.

### Test-SDConnectivity

Recebe um destino e executa um teste ICMP.

A ausência de resposta ao ping não comprova, isoladamente, falta de conectividade.

### Export-SDReport

Recebe informações de sistema e rede e cria um relatório JSON resumido.

O relatório omite IP, gateway, DNS, hostname, usuário e identificadores de interface.

### Write-SDAuditEvent

Registra data/hora, código da ação e status em arquivo CSV.

## 6. Padrões de desenvolvimento

- Funções com verbos descritivos do PowerShell.
- Prefixo `SD` para identificar funções do projeto.
- Módulos separados por responsabilidade.
- Retorno de objetos estruturados com `PSCustomObject`.
- Formatação de resultados preferencialmente na interface.
- Tratamento de erros com `try/catch`.
- Operações de diagnóstico sem elevação de privilégios.

## 7. Persistência de dados

Arquivos gerados localmente:

```text
data/
|-- reports/
|   `-- relatorio-*.json
`-- logs/
    `-- acoes.csv
```

O diretório `data/` é ignorado pelo Git.

Esses arquivos não devem ser publicados sem revisão.

## 8. Limitações arquiteturais

- Os módulos dependem de recursos disponíveis no Windows.
- Ainda não existem testes de unidade isolados com mocks.
- Falhas na auditoria podem interferir no tratamento de erros da ação.
- Não existem interface gráfica ou execução remota.

## 9. Evolução prevista

As próximas etapas incluem testes mais robustos, melhorias de tratamento de erros, novos módulos de diagnóstico e uma possível interface gráfica.

Consulte o [roadmap](ROADMAP.md).