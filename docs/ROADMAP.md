# Roadmap — Souzas Desk

Planejamento da evolução do **Souzas Desk**, desde o MVP até versões com diagnósticos ampliados e interface gráfica.

O roadmap apresenta intenções de desenvolvimento, não prazos ou entregas garantidas.

## Visão por versão

| Versão | Foco | Situação |
|---|---|---|
| v0.1.0 | Diagnósticos básicos e arquitetura modular | Implementada |
| v0.1.1 | Estabilidade, tratamento de erros e testes | Planejada |
| v0.2 | Diagnósticos ampliados | Planejada |
| v0.3 | Assistentes de reparo controlados | Planejada |
| v0.4 | Interface gráfica para Windows | Planejada |
| v0.5 | Integrações opcionais Microsoft | Planejada |

> A v0.1.0 possui funcionalidades implementadas, mas ainda requer registro de validação funcional completa no Windows.

---

## v0.1.0 — MVP

- [x] Menu interativo.
- [x] Informações do Windows.
- [x] Diagnóstico básico de rede.
- [x] Teste ICMP.
- [x] Relatórios JSON.
- [x] Logs CSV.
- [x] Documentação técnica.
- [x] Smoke test implementado.
- [ ] Registrar validação funcional completa no Windows.

## v0.1.1 — Qualidade e estabilidade

- [ ] Separar erros de diagnóstico e auditoria.
- [ ] Melhorar mensagens de falha.
- [ ] Criar testes de unidade com mocks.
- [ ] Adicionar validação de entradas.
- [ ] Melhorar gerenciamento de logs.
- [ ] Configurar execução automatizada de testes.
- [ ] Centralizar informações de versão.

## v0.2 — Diagnósticos ampliados

- [ ] Diagnóstico de conectividade em etapas.
- [ ] Testes de resolução DNS.
- [ ] Consulta de serviços Windows.
- [ ] Diagnóstico de impressoras.
- [ ] Inventário de drivers.
- [ ] Informações de armazenamento.
- [ ] Consulta de eventos relevantes do sistema.

Inicialmente, as novas rotinas deverão operar em modo de leitura.

## v0.3 — Manutenção controlada

- [ ] Avaliar integração de SFC.
- [ ] Avaliar integração de DISM.
- [ ] Criar modo de simulação.
- [ ] Verificar privilégios necessários.
- [ ] Exigir confirmação antes de mudanças.
- [ ] Registrar resultados e falhas.
- [ ] Documentar riscos e procedimentos de recuperação.

## v0.4 — Interface gráfica

- [ ] Avaliar WPF e alternativas.
- [ ] Definir identidade visual do aplicativo.
- [ ] Criar painel de navegação.
- [ ] Integrar funções PowerShell existentes.
- [ ] Exibir resultados visualmente.
- [ ] Facilitar exportação de relatórios.

## v0.5 — Integrações

- [ ] Estudar integração com Microsoft 365.
- [ ] Avaliar Microsoft Entra ID.
- [ ] Avaliar Microsoft Intune.
- [ ] Definir autenticação e autorização.
- [ ] Implementar controles de privacidade.

As integrações dependerão dos requisitos técnicos, permissões e licenças dos serviços envolvidos.

---

## Critérios para concluir uma versão

Uma entrega deve considerar:

1. Código implementado.
2. Documentação atualizada.
3. Testes executados e resultados registrados.
4. Verificação de segurança.
5. Revisão das alterações Git.
6. Atualização do changelog.

## Acompanhamento

O progresso técnico pode ser acompanhado no [diário de desenvolvimento](DEVLOG.md) e no [histórico de versões](../CHANGELOG.md).