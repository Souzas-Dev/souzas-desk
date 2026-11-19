# Diario de desenvolvimento

## 2026-11-19 - escopo da versao 0.1

### Objetivo

Criar o primeiro toolkit Windows Support Toolkit da Souzas Dev, com arquitetura modular e interfaces de terminal claras, sem modificar configurações do Windows.

### Decisoes técnicas

- **PowerShell 5.1:** presente nas instalações usuais do Windows 10/11, adequado para comecar sem dependencias.
- **Arquivos `.psm1`:** organizacao por responsabilidade.
- **Objetos PowerShell:** resultados estruturados e testaveis.
- **Sem elevacao:** não solicitar administrador para consultas.
- **Logs sem identificadores:** salvar apenas data, ação e status.
- **JSON anonimizado parcialmente:** omitir IP, usuário e hostname; caracteristicas técnicas permanecem.

### Entregas

- Menu de sistema, rede, ping e relatórios.
- Modulos de sistema, rede, relatórios e auditoria.
- Teste básico automatizado.
- README e documentação de aprendizado, arquitetura e segurança.

### Como registrar uma sessão real

Apos rodar `tests/Smoke.Tests.ps1` no Windows, atualize aqui com a **data do teste**, **versao do Windows/PowerShell**, **PASSOU/FALHOU** e **resumo do erro sem dados pessoais**. Não registre enderecos IP nem dados privados em capturas de tela.

### Status de validação

- Arquivos gerados e pacote ZIP conferido.
- **Execucao no Windows pendente:** o ambiente de preparacao do pacote não possui Windows PowerShell.
