# Diário de desenvolvimento

Registro técnico da evolução do projeto **Souzas Desk**.

Este documento apresenta decisões de implementação, limitações identificadas, testes e aprendizados.

---

## 2026-11-19 — Estrutura inicial da v0.1

### Objetivo

Desenvolver um toolkit modular para diagnóstico local de computadores Windows utilizando PowerShell 5.1.

### Decisões técnicas

| Decisão | Justificativa |
|---|---|
| PowerShell 5.1 | Disponível nos ambientes Windows previstos |
| Arquivos `.psm1` | Separação das responsabilidades |
| `PSCustomObject` | Dados estruturados e reutilizáveis |
| JSON | Relatórios legíveis por pessoas e aplicações |
| CSV | Histórico simplificado das operações |
| Sem administrador | Redução de privilégios desnecessários |

### Funcionalidades implementadas

- Menu interativo de diagnóstico.
- Coleta de informações do sistema.
- Consulta de configurações de rede.
- Teste ICMP.
- Exportação JSON.
- Auditoria local.
- Teste básico automatizado.

### Decisões de segurança

A versão inicial realiza consultas sem alterações de configuração.

Relatórios e logs são armazenados localmente.

A pasta `data/` não deve ser versionada.

### Validação

**Status: execução funcional completa no Windows ainda não comprovada neste registro.**

O teste `tests/Smoke.Tests.ps1` está implementado, mas seu resultado em ambiente Windows precisa ser registrado.

---

## 2026-11-19 — Revisão técnica

### Pontos identificados

- Necessidade de separar falhas de diagnóstico de falhas na gravação dos logs.
- Necessidade de ampliar os testes automatizados.
- O diagnóstico de rede pode evoluir para verificações em etapas.
- A configuração da versão poderá ser centralizada.
- A documentação pode ser padronizada e expandida.

### Próxima etapa proposta

Refatoração de estabilidade e testes na versão v0.1.1.

As melhorias citadas ainda não devem ser consideradas implementadas.

---

## Modelo para novas sessões

Copie esta estrutura sempre que registrar uma sessão real de desenvolvimento:

```text
Data:
Versão:
Objetivo:

Alterações realizadas:

Arquivos modificados:

Comandos executados:

Testes realizados:

Resultado: PASSOU / FALHOU / NÃO EXECUTADO

Problemas encontrados:

Próximos passos:
```

## Boas práticas de registro

- Documentar decisões relevantes.
- Registrar resultados reais de testes.
- Não inventar execuções ou resultados.
- Não incluir IPs privados, credenciais ou dados de terceiros.
- Associar mudanças importantes a commits Git.

Consulte também o [histórico de versões](../CHANGELOG.md).