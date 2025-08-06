# PowerShell Arsenal

Uma coleção de scripts PowerShell independentes para administração e automação de sistemas Windows. Ideal para administradores de TI, entusiastas de automação e iniciantes em PowerShell. Os scripts são úteis no prompt de comando (CLI), para automação via Agendador de Tarefas ou integração com ferramentas como Microsoft Intune. Todos os scripts estão na pasta 📂 scripts e suportam Unicode. Recomenda-se usar o Windows Terminal para uma melhor experiência.

| Script                                              | Descrição                                                                                 |
| --------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| [check-cpu-status.ps1](scripts/check-cpu-status.ps1) | Verifica o uso atual da CPU e exibe o status no console. [Read more »](docs/check-cpu-status.md) |
| [get-bios-info.ps1](scripts/get-bios-info.ps1)      | Obtém informações detalhadas sobre o BIOS do sistema. [Read more »](docs/get-bios-info.md)   |
| [list-local-users.ps1](scripts/list-local-users.ps1) | Lista todos os usuários locais do sistema. [Read more »](docs/list-local-users.md)          |
| [verify-user-credentials.ps1](scripts/verify-user-credentials.ps1) | Valida as credenciais de um usuário local. [Read more »](docs/verify-user-credentials.md)   |
| [speak-weekday.ps1](scripts/speak-weekday.ps1)      | Anuncia o dia da semana atual usando síntese de voz. [Read more »](docs/speak-weekday.md)   |
| [check-disk-space.ps1](scripts/check-disk-space.ps1) | Verifica o espaço disponível em disco e exibe o status. [Read more »](docs/check-disk-space.md) |
| [test-dns-speed.ps1](scripts/test-dns-speed.ps1)    | Testa a velocidade de resolução DNS para uma lista de domínios. [Read more »](docs/test-dns-speed.md) |
| [get-dusk-time.ps1](scripts/get-dusk-time.ps1)      | Calcula e anuncia o tempo até o crepúsculo ou desde o crepúsculo passado. [Read more »](docs/get-dusk-time.md) |
| [check-filesystem.ps1](scripts/check-filesystem.ps1) | Verifica a integridade do sistema de arquivos de uma unidade. [Read more »](docs/check-filesystem.md) |
| [check-firewall-status.ps1](scripts/check-firewall-status.ps1) | Verifica o status do firewall no sistema. [Read more »](docs/check-firewall-status.md)       |
| [get-gpu-info.ps1](scripts/get-gpu-info.ps1)        | Coleta informações detalhadas sobre as GPUs do sistema. [Read more »](docs/get-gpu-info.md)  |
| [validate-ipv4-address.ps1](scripts/validate-ipv4-address.ps1) | Valida um endereço IPv4 fornecido. [Read more »](docs/validate-ipv4-address.md)             |
| [validate-ipv6-address.ps1](scripts/validate-ipv6-address.ps1) | Valida um endereço IPv6 fornecido. [Read more »](docs/validate-ipv6-address.md)             |
| [get-midnight-time.ps1](scripts/get-midnight-time.ps1) | Calcula e anuncia o tempo desde ou até a meia-noite. [Read more »](docs/get-midnight-time.md) |
| [validate-mac-address.ps1](scripts/validate-mac-address.ps1) | Valida um endereço MAC fornecido. [Read more »](docs/validate-mac-address.md)               |
| [get-motherboard-info.ps1](scripts/get-motherboard-info.ps1) | Obtém informações sobre a placa-mãe do sistema. [Read more »](docs/get-motherboard-info.md)  |
| [get-os-info.ps1](scripts/get-os-info.ps1)          | Coleta informações detalhadas sobre o sistema operacional. [Read more »](docs/get-os-info.md) |
| [speak-english.ps1](scripts/speak-english.ps1)      | Implementa funcionalidade de síntese de voz para anunciar mensagens (assumido). [Read more »](docs/speak-english.md) |

## Pré-requisitos

- **Sistema Operacional**: Windows 10 ou superior
- **PowerShell**: Versão 5.1 ou superior (incluso no Windows por padrão)
- **Permissões**: Alguns scripts requerem privilégios administrativos. Execute com `Run as Administrator` quando necessário.
- **Política de Execução**: Certifique-se de que a política de execução do PowerShell permite rodar scripts:
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

## Estrutura do Repositório

- `/scripts`: Contém todos os scripts PowerShell
- `/docs`: Documentação detalhada para cada script (a ser criada conforme necessário)
- `README.md`: Documentação principal do projeto