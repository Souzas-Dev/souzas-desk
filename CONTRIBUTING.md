# Guia de contribuição

Obrigado pelo interesse em contribuir com o Souzas Desk.

## Fluxo de desenvolvimento

1. Consulte as Issues existentes.
2. Crie uma branch para a alteração.
3. Mantenha o código modular e documentado.
4. Execute os testes disponíveis.
5. Revise o diff antes de publicar.
6. Abra um Pull Request para a branch main.

## Padrão de commits

Utilizamos mensagens descritivas:

- feat: nova funcionalidade
- fix: correção de problema
- docs: documentação
- refactor: reorganização de código
- test: testes
- chore: manutenção do projeto

## Testes

Execute no Windows PowerShell 5.1:

    .\tests\Smoke.Tests.ps1

Não declare testes aprovados sem executá-los.

## Segurança

Não inclua credenciais, dados pessoais ou relatórios
de computadores de terceiros em commits ou Issues.

Consulte SECURITY.md para problemas de segurança.

## Revisão

Pull Requests devem informar objetivo, mudanças,
testes realizados, riscos e limitações conhecidas.

O merge deve ocorrer após revisão e verificações
aplicáveis.
