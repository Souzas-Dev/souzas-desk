# Git e GitHub: do terminal ao repositório

> Todos os comandos abaixo sao executados **dentro da pasta `souzas-desk`**. O primeiro push só deve ser feito depois de conferir `git status` e `git diff --cached`.

## 1. Confira as ferramentas

```powershell
git --version
gh --version
```

Se um comando não existir, instale a ferramenta pelo fornecedor oficial: https://git-scm.com/downloads e https://cli.github.com/.

## 2. Crie um repositório local

```powershell
git init
git branch -M main
git add .
git status
git diff --cached --stat
git commit -m "feat: souzas desk v0.1 - diagnostico e documentacao"
```

`git init` cria o histórico local. `git add .` seleciona arquivos para commit; `git status` permite revisar o que será incluido. `git commit` grava uma versao local.

## 3. Publique no GitHub (opcional)

```powershell
gh auth login
gh auth status
gh repo create Souzas-Dev/souzas-desk --public --source . --remote origin --push
```

- O comando `gh auth login` solicita login no navegador/terminal se necessario.
- `gh repo create` cria um repo novo. Não execute se já existir outro repo com esse nome, para evitar confusao.
- `--public` torna os **arquivos versionados** publicos; `--push` envia o commit local.

## 4. Atualizacoes futuras

```powershell
git status
git add .
git diff --cached
git commit -m "docs: melhora guia de iniciantes"
git push
```

## 5. Segurança antes de publicar

```powershell
git status --short
git check-ignore data/logs/acoes.csv
git diff --cached --name-only
```

`git check-ignore` exibe o arquivo ignorado quando a regra do `.gitignore` está funcionando. Se algum arquivo privado aparecer no staging, use `git restore --staged <arquivo>` (substitua pelo caminho correto) e revise o `.gitignore`. Nunca publique senhas, tokens, nomes de pacientes ou arquivos de atendimento.
