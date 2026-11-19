# Git e GitHub — Guia do projeto

Procedimentos de versionamento e publicação do **Souzas Desk**.

Repositório oficial:

https://github.com/Souzas-Dev/souzas-desk

## 1. Ferramentas

O projeto utiliza Git para controle de versões e GitHub para hospedagem do código.

Verifique a instalação:

```powershell
git --version
```

O GitHub CLI é opcional:

```powershell
gh --version
```

## 2. Clonar o projeto

Para obter uma cópia do repositório:

```powershell
git clone https://github.com/Souzas-Dev/souzas-desk.git
cd souzas-desk
```

O repositório já existe. Não é necessário executar `git init` ou criar outro repositório.

## 3. Consultar o estado do projeto

```powershell
git status
git branch --show-current
git remote -v
git log -5 --oneline
```

Esses comandos permitem verificar alterações locais, branch, repositório remoto e commits recentes.

## 4. Fluxo recomendado de atualização

### Verificar alterações

```powershell
git status
git diff
git diff --check
```

### Selecionar arquivos

Exemplo para uma alteração de documentação:

```powershell
git add README.md
```

Prefira selecionar arquivos explicitamente para evitar incluir dados locais.

### Conferir o que será publicado

```powershell
git diff --cached
git diff --cached --name-only
```

### Criar um commit

```powershell
git commit -m "docs: melhora documentacao"
```

### Enviar ao GitHub

```powershell
git push origin main
```

## 5. Padrão de mensagens

| Prefixo | Utilização |
|---|---|
| `feat:` | Nova funcionalidade |
| `fix:` | Correção de problema |
| `docs:` | Documentação |
| `refactor:` | Reorganização sem mudar comportamento esperado |
| `test:` | Inclusão ou melhoria de testes |
| `chore:` | Manutenção e organização |

Exemplos:

```text
feat: adiciona diagnostico de rede
fix: corrige tratamento de erros
docs: atualiza guia de iniciantes
test: adiciona verificacao de relatorios
```

## 6. Trabalhar com branches

Para uma alteração futura mais complexa:

```powershell
git switch -c docs/melhoria-documentacao
```

Após realizar alterações, revisar e criar o commit:

```powershell
git push -u origin docs/melhoria-documentacao
```

A branch poderá ser utilizada para abrir um Pull Request no GitHub.

## 7. Segurança antes do push

Confira os arquivos selecionados:

```powershell
git diff --cached --name-only
git status --short
```

Verifique uma regra do `.gitignore`:

```powershell
git check-ignore data/logs/acoes.csv
```

Nunca publique credenciais, tokens, dados de clientes ou relatórios privados.

O `.gitignore` impede a inclusão normal de determinados arquivos, mas não remove arquivos já versionados.

## 8. Recuperação e histórico

Visualizar alterações de um arquivo:

```powershell
git log --oneline -- README.md
```

Visualizar o conteúdo de uma versão:

```powershell
git show HEAD:README.md
```

Antes de desfazer alterações, confira o estado do repositório para não perder trabalho.

## Referências oficiais

- [Git](https://git-scm.com/docs)
- [GitHub Docs](https://docs.github.com/)
- [GitHub CLI](https://cli.github.com/)