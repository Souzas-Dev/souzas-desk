# Guia de iniciantes — PowerShell com Souzas Desk

Material introdutório para aprender a ler, interpretar e testar código PowerShell utilizando um projeto real.

**Objetivo:** compreender o que cada comando executa antes de tentar modificar ou ampliar a ferramenta.

---

## 1. Preparação

Utilize Windows 10 ou Windows 11 com Windows PowerShell 5.1.

Não é necessário abrir como administrador.

Verifique a versão:

```powershell
$PSVersionTable.PSVersion
```

Confira os comandos utilizados:

```powershell
Get-Command Get-CimInstance
Get-Command Get-NetIPConfiguration
Get-Command Test-Connection
```

## 2. Iniciando o Souzas Desk

Na pasta principal do projeto:

```powershell
.\Start-SouzasDesk.ps1
```

Caso a política de execução bloqueie o script, consulte:

```powershell
Get-ExecutionPolicy -List
```

Em computador pessoal, depois de revisar o código e se a política permitir, é possível utilizar uma configuração temporária da sessão:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned
```

Não altere políticas de computadores corporativos sem autorização.

## 3. Entendendo a estrutura

### O que é um arquivo `.ps1`?

É um arquivo de script PowerShell.

No projeto, `Start-SouzasDesk.ps1` contém o menu principal.

### O que é um arquivo `.psm1`?

É um módulo PowerShell que organiza funções reutilizáveis.

Exemplo:

```powershell
Import-Module .\src\Modules\SystemInfo.psm1
```

O comando importa funções de diagnóstico do sistema.

## 4. Conceitos fundamentais

### Variáveis

```powershell
$Nome = 'Souzas Desk'
```

Uma variável armazena um valor.

### Comandos

```powershell
Get-Date
```

Executa uma operação e retorna o resultado.

### Objetos

```powershell
$Sistema = Get-CimInstance Win32_OperatingSystem
$Sistema.Caption
```

A primeira linha consulta informações do Windows.

A segunda acessa a propriedade `Caption` do objeto retornado.

### Funções

```powershell
function Get-SDSaudacao {
    return 'Souzas Desk iniciado'
}

Get-SDSaudacao
```

Uma função reúne instruções que podem ser utilizadas novamente.

### Condições

```powershell
$Valor = 10

if ($Valor -gt 5) {
    Write-Host 'Valor maior que cinco'
}
```

O `if` executa um bloco quando a condição é verdadeira.

### Tratamento de erros

```powershell
try {
    Get-Item 'C:\Windows' -ErrorAction Stop
}
catch {
    Write-Warning $_.Exception.Message
}
```

O `try/catch` permite tratar erros ocorridos durante uma operação.

## 5. Lendo o código do projeto

Para visualizar o menu:

```powershell
Get-Content .\Start-SouzasDesk.ps1
```

Para visualizar o módulo de sistema:

```powershell
Get-Content .\src\Modules\SystemInfo.psm1
```

Para conhecer os parâmetros de um comando:

```powershell
Get-Help Get-CimInstance -Examples
```

## 6. Exercício prático

Abra `SystemInfo.psm1` e procure:

```powershell
$OS = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
```

Observe:

1. `$OS` é a variável que recebe os dados.
2. `Get-CimInstance` realiza a consulta.
3. `-ClassName` indica a classe consultada.
4. `-ErrorAction Stop` solicita um erro terminante quando a consulta falha.

Depois encontre a propriedade `Caption` utilizada no retorno do módulo.

## 7. Testando o projeto

Execute:

```powershell
.\tests\Smoke.Tests.ps1
```

O script verifica sintaxe, importação dos módulos, consultas básicas, geração de relatório e auditoria.

O resultado precisa ser observado no Windows; a existência do teste não significa que ele já foi aprovado.

## 8. Aprendendo Git

Consultar mudanças:

```powershell
git status
git diff
```

Consultar histórico:

```powershell
git log --oneline
```

Para aprender o fluxo completo, consulte o [guia Git e GitHub](GIT-GITHUB.md).

## 9. Próximos estudos

Os fundamentos importantes para evoluir o projeto são:

- Variáveis, objetos e pipelines.
- Funções e parâmetros.
- Condições e estruturas de repetição.
- Tratamento de exceções.
- Módulos PowerShell.
- Testes e depuração.
- Git e revisão de código.

> Priorize compreender entradas, processamento, saídas e efeitos de cada função. Não é necessário decorar a sintaxe para revisar um programa com responsabilidade.