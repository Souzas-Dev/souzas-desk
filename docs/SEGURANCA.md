# Segurança e privacidade — Souzas Desk

Política técnica de segurança aplicável ao **Souzas Desk v0.1.0**.

## 1. Princípios

O projeto segue os princípios de:

- Privilégios mínimos.
- Diagnóstico antes de intervenção.
- Execução local e transparente.
- Proteção de informações técnicas.
- Registro controlado das operações.
- Consentimento antes de futuras ações que modifiquem o sistema.

## 2. Escopo da versão atual

A v0.1.0 realiza consultas e diagnósticos.

Não executa automaticamente:

- SFC ou DISM.
- Reparos em disco.
- Alterações de DNS ou rede.
- Instalação de programas e drivers.
- Reinicialização de serviços.
- Modificações no registro do Windows.
- Execução remota de comandos.

As operações atuais não exigem privilégios administrativos.

## 3. Coleta de informações

### Informações consultadas

O programa pode consultar:

- Versão e build do Windows.
- Processador e memória.
- Tempo de atividade.
- Interfaces de rede.
- IPv4, gateway e DNS.

As informações de rede podem aparecer diretamente no terminal.

### Relatórios JSON

Os relatórios omitem IP, gateway, DNS, hostname, usuário, MAC e nome de interface.

Entretanto, ainda contêm características técnicas do computador e não devem ser considerados completamente anônimos.

## 4. Auditoria local

O arquivo:

```text
data/logs/acoes.csv
```

Registra apenas:

- Data e horário.
- Código da operação.
- Status da operação.

O registro não inclui nomes de usuário, IPs ou destino do ping.

## 5. Armazenamento

Os arquivos de saída são criados dentro de:

```text
data/
|-- reports/
`-- logs/
```

O `.gitignore` exclui essa pasta do versionamento normal.

Isso não equivale a criptografia ou controle de acesso.

Quem possuir acesso autorizado aos arquivos locais poderá visualizar seu conteúdo.

## 6. Operações de rede

O teste de conectividade envia pacotes ICMP ao destino informado pelo usuário.

O código realiza uma validação básica do texto recebido, mas não oferece garantia completa de validade de nomes ou endereços.

O teste não implementa varredura de rede.

Uma falha de ping pode ocorrer por filtros de firewall, indisponibilidade de ICMP ou problemas de conectividade.

## 7. Execução de scripts

Revise o conteúdo dos scripts antes de executá-los.

Consulte a política do PowerShell:

```powershell
Get-ExecutionPolicy -List
```

Não contorne políticas de execução definidas por empresas, escolas ou administradores de TI.

A política de execução não substitui auditoria do código.

## 8. Uso corporativo

Antes de executar a ferramenta em dispositivos gerenciados:

1. Solicite autorização da equipe responsável.
2. Verifique as políticas de segurança locais.
3. Evite expor informações internas.
4. Revise relatórios antes de compartilhar.
5. Não publique dados de clientes, pacientes ou funcionários.

## 9. Limitações conhecidas

- Não há criptografia específica para os arquivos gerados.
- Não existe gerenciamento de permissões dentro do aplicativo.
- Não há sistema de retenção ou exclusão automática de logs.
- A validação do destino ICMP é básica.
- Os testes automatizados ainda precisam de maior cobertura.
- A validação funcional completa da aplicação no Windows ainda precisa ser registrada.

## 10. Controles para versões futuras

Antes de introduzir reparos, implementar:

- Verificação de privilégios.
- Confirmação explícita.
- Avaliação e comunicação de riscos.
- Simulação quando possível.
- Registro de operações.
- Tratamento de falhas.
- Procedimentos de recuperação.
- Testes automatizados apropriados.

## 11. Comunicação de problemas

Problemas gerais podem ser relatados nas Issues do repositório:

https://github.com/Souzas-Dev/souzas-desk/issues

Não inclua senhas, tokens, dados pessoais ou informações de ambientes de terceiros em Issues públicas.

---

**Aviso:** o Souzas Desk é um projeto em desenvolvimento. A documentação descreve o comportamento previsto da versão atual, não representa certificação de segurança nem homologação em todos os ambientes Windows.