# Histórico de versões

Registro das alterações do **Souzas Desk**, seguindo uma organização por versões.

As alterações são classificadas como adicionadas, modificadas, corrigidas ou removidas, conforme aplicável.

> Este arquivo registra entregas implementadas. Funcionalidades planejadas ficam documentadas em [ROADMAP.md](docs/ROADMAP.md).

---

## [0.1.0] - 2026-11-19

### Adicionado

- Menu interativo para Windows PowerShell 5.1.
- Módulo de diagnóstico do sistema operacional.
- Consulta de processador, memória, versão do Windows e tempo de atividade.
- Consulta de interfaces IPv4, gateway e DNS.
- Teste de conectividade ICMP para destino informado.
- Exportação de relatórios técnicos em JSON.
- Registro local simplificado das operações em CSV.
- Teste básico de integração e sintaxe.
- Documentação inicial de arquitetura, segurança e utilização.

### Segurança

- Execução sem necessidade de privilégios administrativos.
- Diagnósticos sem alterações nas configurações do Windows.
- Exclusão da pasta `data/` do versionamento Git.
- Relatórios com omissão de identificadores diretos de rede e usuário.
- Ausência de telemetria ou envio automático de relatórios.

### Limitações

- Não executa reparos, manutenção corretiva ou mudanças no sistema.
- Não possui execução remota.
- Não possui integração com Intune ou serviços de nuvem.
- A validação funcional completa no Windows ainda precisa ser documentada.

---

## Controle de versões

O histórico de desenvolvimento pode ser consultado em:

- [Diário de desenvolvimento](docs/DEVLOG.md)
- [Roadmap](docs/ROADMAP.md)
- [Histórico de commits](https://github.com/Souzas-Dev/souzas-desk/commits/main)

> As próximas versões serão registradas aqui após a implementação das respectivas alterações.