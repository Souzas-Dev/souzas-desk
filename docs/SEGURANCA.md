# Segurança e privacidade

## Politica da v0.1

1. **Sem privilegios administrativos.** Execute em terminal de usuário comum.
2. **Sem mudancas no Windows.** Nenhuma rotina de reparo e habilitada nesta versao.
3. **Sem execucao de código externo.** Não ha download de scripts, `Invoke-Expression` ou comandos montados por concatenacao.
4. **Ping somente sob escolha do usuário.** O teste da opcao 3 envia ICMP para um alvo digitado; não realiza varredura de rede.
5. **Coleta local.** Informações de rede aparecem no terminal, não sao enviadas para servidor, API ou telemetria.
6. **Relatórios reduzidos.** Os JSONs não contém IP, gateway, DNS, hostname, usuário, nome de interface ou MAC. Ainda podem incluir caracteristicas da máquina (Windows, CPU, memória): revise antes de compartilhar.
7. **Auditoria mínima.** `data/logs/acoes.csv` contém apenas horário, ação e status (sem mensagens de erro, host ou usuário).
8. **Dados ignorados pelo Git.** O caminho `data/` está no `.gitignore`. Antes do push, verifique `git status` e `git diff --cached`.

## Uso em ambiente de trabalho

Peca autorização para executar software no computador gerenciado, respeite políticas de TI e nunca inclua dados de clientes em um repo publico. **Não** contorne políticas corporativas de execucao.

## Ameacas e melhorias futuras

A validação do destino de ping reduz entradas inesperadas, mas não substitui controles de rede. Dados locais podem ser lidos por quem tiver permissao sobre a pasta do usuário. Em futuras versoes, implementar sanitizacao adicional, testes com mocks, consentimento detalhado e controles de permissao para rotinas de reparo.

## Reparos futuros

SFC, DISM, reinicio do spooler, reset de DNS e outras operacoes mutaveis **não** fazem parte da v0.1. Antes de implementa-las: criar simulacao, indicador de riscos, confirmacao explicita, backup quando aplicavel e logs controlados.
