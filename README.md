<div align="center">

# 🖥️ Souzas Desk

### Windows Support Toolkit

**Diagnóstico, automação e suporte técnico para ambientes Windows com PowerShell.**

![Version](https://img.shields.io/badge/Version-0.1.1-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-10%20%7C%2011-0078D4?logo=windows)
![Status](https://img.shields.io/badge/Status-MVP-orange)

**By Souzas Dev**

[Documentação](docs/INICIANTES.md) •
[Arquitetura](docs/ARQUITETURA.md) •
[Segurança](docs/SEGURANCA.md) •
[Roadmap](docs/ROADMAP.md)

</div>

---

## 📌 Sobre o projeto

O **Souzas Desk** é uma ferramenta modular de suporte técnico desenvolvida em PowerShell para facilitar o diagnóstico de computadores Windows.

O projeto busca reunir rotinas de análise, diagnóstico e, futuramente, manutenção em uma interface de terminal organizada, acessível e documentada.

Seu desenvolvimento também tem caráter educacional, permitindo estudar PowerShell, sistemas operacionais, redes, automação e boas práticas de engenharia de software.

### Objetivos

- Facilitar diagnósticos técnicos em Windows.
- Automatizar consultas repetitivas.
- Padronizar a coleta de informações.
- Gerar relatórios técnicos estruturados.
- Manter registros locais das operações.
- Evoluir para uma plataforma modular de suporte.

> **Versão em preparação:** a v0.1.1 é um MVP de diagnóstico. Não executa reparos nem altera configurações do Windows.

---

## ⚙️ Funcionalidades

| Módulo | Descrição | Disponibilidade |
|---|---|---|
| Sistema | Informações do Windows, CPU, RAM e uptime | ✅ v0.1 |
| Rede | Interfaces IPv4, gateway e DNS | ✅ v0.1 |
| Conectividade | Testes ICMP (ping) | ✅ v0.1 |
| Relatórios | Exportação local em JSON | ✅ v0.1 |
| Auditoria | Registro de operações em CSV | ✅ v0.1 |
| Impressoras | Diagnósticos de impressão | 🔜 Planejado |
| Drivers | Inventário e análise de drivers | 🔜 Planejado |
| Manutenção | Assistentes de reparo controlados | 🔜 Planejado |
| Interface gráfica | Aplicativo desktop para Windows | 🔜 Planejado |

---

## 💻 Tecnologias

- **PowerShell 5.1:** linguagem principal.
- **Windows Management Instrumentation (CIM):** consultas de hardware e sistema.
- **NetTCPIP:** informações de rede.
- **JSON:** exportação de relatórios.
- **CSV:** histórico de ações.
- **Git e GitHub:** versionamento e documentação.

---

## 🚀 Instalação e execução

### Pré-requisitos

- Windows 10 ou Windows 11.
- Windows PowerShell 5.1.
- Git para clonar o repositório.
- Conta de usuário comum, sem necessidade de administrador.

### 1. Clonar o projeto

```powershell
git clone https://github.com/Souzas-Dev/souzas-desk.git
cd souzas-desk
```

### 2. Conferir o PowerShell

```powershell
$PSVersionTable.PSVersion
Get-ExecutionPolicy -List
```

### 3. Iniciar a ferramenta

```powershell
.\Start-SouzasDesk.ps1
```

Se a política de execução impedir o script, consulte o [guia de iniciantes](docs/INICIANTES.md). Não contorne políticas de segurança de computadores gerenciados.

---

## 🧭 Interface de terminal

```text
================================================
            SOUZAS DESK | v0.1.1
          Windows Support Toolkit
                By Souzas Dev
================================================

  [1] Informacoes do sistema
  [2] Configuracao de rede
  [3] Teste de conectividade (ping)
  [4] Exportar relatorio JSON (sem IP/usuario)
  [0] Sair

------------------------------------------------
Modo: diagnostico (sem alteracoes no Windows)

Escolha uma opcao:
```

O menu centraliza as consultas e permite retornar à tela principal após cada diagnóstico.

---

## 🏗️ Arquitetura

O projeto utiliza uma arquitetura modular, separando interface, consultas, relatórios e auditoria.

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
|       |-- Audit.psm1
|       `-- MenuAction.psm1
|
|-- tests/
|   |-- Smoke.Tests.ps1
|   |-- Action.Tests.ps1
|   |-- Audit.Integration.Tests.ps1
|   |-- Resilience.Tests.ps1
|   `-- Lint.Tests.ps1
|
|-- docs/
|   |-- INICIANTES.md
|   |-- ARQUITETURA.md
|   |-- SEGURANCA.md
|   |-- ROADMAP.md
|   |-- DEVLOG.md
|   `-- GIT-GITHUB.md
|
|-- CHANGELOG.md
|-- .gitignore
`-- README.md
```

Cada módulo possui uma responsabilidade específica, facilitando manutenção, testes e expansão da ferramenta.

---

## 🧪 Testes

O Souzas Desk possui testes automatizados para Windows PowerShell 5.1.

```powershell
.\tests\Action.Tests.ps1
.\tests\Audit.Integration.Tests.ps1
.\tests\Resilience.Tests.ps1
.\tests\Smoke.Tests.ps1
.\tests\Lint.Tests.ps1
```

O teste de lint requer PSScriptAnalyzer 1.25.0.

Os testes verificam a execucao das acoes, auditoria CSV real,
validacao de entradas, falhas de armazenamento, sintaxe e
qualidade estatica do PowerShell.

**Validacao manual:** as opcoes 1 a 4 do menu foram executadas
com sucesso em Windows 10 Pro, build 19045, em 2026-11-19.
O JSON e os registros CSV foram conferidos.

Essa validacao representa uma configuracao de Windows.
Testes em outros computadores ainda sao recomendados.

---

## 🔒 Segurança e privacidade

A versão atual foi projetada para operar sem privilégios administrativos e sem alterações de configurações do sistema.

- Não executa reparos automáticos.
- Não instala drivers ou programas.
- Não executa comandos remotos.
- Não envia telemetria para servidores externos.
- Realiza ping apenas para um destino informado pelo usuário.
- Armazena os logs localmente.
- Omite IP, hostname e usuário dos relatórios JSON.

Os arquivos gerados ficam no diretório `data/`, excluído do versionamento pelo `.gitignore`.

> Os relatórios ainda podem conter características técnicas do computador. Revise os dados antes de compartilhar. Em ambientes corporativos, obtenha autorização antes de executar a ferramenta.

Consulte a [política de segurança](docs/SEGURANCA.md).

---

## 🗺️ Roadmap

| Versão | Objetivo | Status |
|---|---|---|
| v0.1 | Estrutura modular, diagnóstico básico e documentação | Implementada |
| v0.1.1 | Melhorias de estabilidade, erros e testes | Em preparação |
| v0.2 | Diagnósticos ampliados de rede, drivers e impressoras | Planejada |
| v0.3 | Assistentes de reparo com confirmação e segurança | Planejada |
| v0.4 | Interface gráfica para Windows | Planejada |
| v0.5 | Integrações opcionais com serviços Microsoft | Planejada |

Acompanhe as próximas entregas no [roadmap técnico](docs/ROADMAP.md).

---

## 📚 Documentação

| Documento | Conteúdo |
|---|---|
| [Guia de iniciantes](docs/INICIANTES.md) | Fundamentos de PowerShell e primeiros passos |
| [Arquitetura](docs/ARQUITETURA.md) | Organização e responsabilidades dos módulos |
| [Segurança](docs/SEGURANCA.md) | Privacidade e controles de segurança |
| [Roadmap](docs/ROADMAP.md) | Planejamento das próximas versões |
| [Diário de desenvolvimento](docs/DEVLOG.md) | Decisões e evolução técnica |
| [Git e GitHub](docs/GIT-GITHUB.md) | Comandos de versionamento |

---

## 🤝 Contribuições

Sugestões, relatórios de problemas e propostas de melhoria são bem-vindos por meio das Issues do GitHub.

Antes de contribuir, consulte a documentação e evite incluir dados sensíveis, credenciais ou informações de computadores de terceiros.

---

## 📄 Licença

O aplicativo exibe o crédito de autoria **`By Souzas Dev`** no menu principal. Consulte o arquivo [NOTICE](NOTICE) para a atribuição do projeto original.

**Licenciamento em definição:** ainda não há um arquivo `LICENSE`. O `NOTICE` informa a autoria, mas não concede direitos de uso, modificação ou redistribuição por si só. A condição de preservação do crédito visível em versões distribuídas por terceiros dependerá da licença escolhida e de revisão jurídica.

---

<div align="center">

### Desenvolvido por Souzas Dev

**Tecnologia • Automação • Infraestrutura • Cloud**

[GitHub](https://github.com/Souzas-Dev) |
[Repositório](https://github.com/Souzas-Dev/souzas-desk)

**Souzas Desk — Windows Support Toolkit**

</div>
