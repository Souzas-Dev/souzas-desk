# Guia de iniciantes - aprendendo com o Souzas Desk

Este guia foi pensado para quem está comecando a **ler, entender e revisar** código PowerShell. Não precisa decorar tudo.

## 1. Antes de executar

Abra **Windows PowerShell** (não precisa ser administrador) e verifique:

```powershell
$PSVersionTable.PSVersion
Get-ExecutionPolicy -List
Get-Command Get-CimInstance, Get-NetIPConfiguration, Test-Connection
```

O projeto foi planejado para Windows 10/11 com Windows PowerShell 5.1.

Execute a partir da pasta do projeto:

```powershell
.\Start-SouzasDesk.ps1
```

**Se houver bloqueio de política de execucao:** não altere políticas de empresa ou escola. Em computador pessoal e depois de ler o código, voce pode verificar as políticas com `Get-ExecutionPolicy -List`; se permitido, para a sessão atual, use:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

Isso não remove políticas de grupo e não muda a configuração permanente. A política de execucao não substitui a verificacao de segurança do código.

## 2. Como o script funciona

### Linha `#Requires -Version 5.1`

Impede executar o script com versoes antigas do PowerShell.

### Variaveis: `$ProjectRoot`, `$DataFolder`

O sinal `$` indica uma variavel. Ela guarda um valor que será reutilizado no código. `Join-Path` monta um caminho de pasta sem precisar digitar o caminho completo em cada linha.

### `Import-Module`

Carrega as funções de outro arquivo (`.psm1`) para o menu principal. E como separar um projeto em ferramentas menores, cada uma cuidando de um assunto.

### `function Get-SDSystemInfo { ... }`

Cria uma função reutilizavel. Aqui o nome comeca com `Get`, pois a função consulta informações. Não tenta corrigir o sistema.

### `Get-CimInstance`

Consulta dados do Windows por classes do sistema, como `Win32_OperatingSystem`. Não e necessario consultar o registro do Windows diretamente para essas informações.

### `[pscustomobject]`

Cria uma estrutura com propriedades (`Sistema`, `Versao`, `MemoriaGB`). E mais facil exportar e testar do que texto solto usando `Write-Host`.

### `switch ($Option)`

Escolhe qual ação executar com base no numero informado pelo usuário. E o seletor do menu.

### `try { ... } catch { ... }`

Permite tratar erros sem fechar o programa abruptamente. O módulo de auditoria salva somente um código de ação e se ela terminou com `OK` ou `ERRO`.

### `Export-ModuleMember`

Declara quais funções ficam acessiveis quando o módulo e importado. Ajuda a manter uma interface clara.

## 3. Como examinar o código pelo terminal

```powershell
Get-Content .\Start-SouzasDesk.ps1 -TotalCount 35
Get-Content .\src\Modules\SystemInfo.psm1
Get-Command -Module SystemInfo
Get-Help Get-CimInstance -Examples
```

Se `Get-Command -Module SystemInfo` não mostrar resultados, importe o módulo antes: `Import-Module .\src\Modules\SystemInfo.psm1`.

## 4. Seu primeiro exercicio

1. Abra `src/Modules/SystemInfo.psm1`.
2. Identifique de onde vem o nome do Windows.
3. Localize a conta de memória e observe a divisao por `1GB`.
4. Procure onde `Get-SDSystemInfo` e chamada no menu principal.
5. Execute a opcao `1` e compare a saida com as propriedades do código.

## 5. Como salvar progresso no Git

```powershell
git status
git add .
git diff --cached
git commit -m "docs: explica funcionamento do modulo de sistema"
```

**Dica:** `git diff --cached` mostra o que será incluido no commit. Leia antes de salvar.
