# Souzas Desk

**Windows Support Toolkit | v0.1.0 (MVP)**

Toolkit de suporte técnico para **Windows 10/11**, executado no terminal do **Windows PowerShell 5.1**, com um menu de rotinas de diagnóstico. Desenvolvido como projeto educacional/portfolio da Souzas Dev.

> **Segurança:** a v0.1 usa apenas consultas e diagnósticos. Não executa SFC, DISM, reparos em disco, instalação de drivers, alteracoes de rede ou comandos remotos. Não precisa ser executada como Administrador.

## Recursos

| Menu | Funcao | Impacto |
| --- | --- | --- |
| 1 | Sistema operacional, CPU, memória e uptime | Somente leitura |
| 2 | Interfaces IPv4, gateway e DNS | Somente leitura |
| 3 | Testar ICMP (ping) para host informado | Envia pacotes ICMP ao destino |
| 4 | Exportar relatório JSON de diagnóstico | Cria arquivo local, sem IP, hostname ou usuário |
| 0 | Sair | Encerra o menu |

Registro local de ações guarda apenas **data/hora, código da ação e status**. Os dados locais ficam em `data/`, ignorada pelo Git.

## Requisitos

- Windows 10 ou Windows 11;
- Windows PowerShell 5.1 (nativo no Windows); 
- Conta de usuário comum, sem privilegios administrativos;
- Conexao com a rede apenas para testar destinos de rede (opcao 3).

## Como usar

Abra o **Windows PowerShell**, navegue ate a pasta do projeto e execute:

```powershell
$PSVersionTable.PSVersion
Get-ExecutionPolicy -List
.\Start-SouzasDesk.ps1
```

Se a política local impedir a execucao, consulte `docs/INICIANTES.md` antes de mudar qualquer configuração. Politicas corporativas devem ser respeitadas.

## Teste do projeto

```powershell
.\tests\Smoke.Tests.ps1
```

Os testes verificam o parser e os módulos e criam um relatório de teste **somente no seu computador**.

## Estrutura

```text
souzas-desk/
|-- Start-SouzasDesk.ps1        # menu principal
|-- src/Modules/
|   |-- SystemInfo.psm1         # consulta ao sistema
|   |-- NetworkInfo.psm1        # consultas de rede e ping
|   |-- Reporting.psm1          # relatorios JSON
|   `-- Audit.psm1              # auditoria local sem dados sensiveis
|-- docs/
|   |-- INICIANTES.md           # aprendizado passo a passo
|   |-- ARQUITETURA.md          # divisao de responsabilidades
|   |-- SEGURANCA.md            # limites e controles
|   `-- ROADMAP.md              # proximas versoes
|-- tests/Smoke.Tests.ps1       # teste sem dependencias extras
|-- .gitignore
|-- CHANGELOG.md
`-- README.md
```

## Documentação

Comece pelo [guia de iniciantes](docs/INICIANTES.md). Depois consulte [arquitetura](docs/ARQUITETURA.md), [segurança](docs/SEGURANCA.md), [Git e GitHub](docs/GIT-GITHUB.md), [diário de desenvolvimento](docs/DEVLOG.md) e [roadmap](docs/ROADMAP.md).

## Publicacao no GitHub

Revise o conteudo antes de publicar. O `.gitignore` já exclui `data/` do controle de versao. Para iniciar o repositório local:

```powershell
git init
git branch -M main
git add .
git status
git commit -m "feat: cria Souzas Desk v0.1 com diagnosticos seguros"
```

Para publicar usando GitHub CLI, com `gh` instalado e autenticado:

```powershell
gh auth status
gh repo create Souzas-Dev/souzas-desk --public --source . --remote origin --push
```

Se já houver um repositório com esse nome, escolha outro nome ou configure o remote manualmente; não force push de arquivos preexistentes.

**Licença:** ainda não definida. Escolha uma licença antes de permitir reutilizacao sob termos explicitos.
