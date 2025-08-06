# check-firewall-status.ps1

Este script verifica o status do firewall do sistema. No Linux, usa o comando `ufw status` para exibir detalhes do firewall. No Windows, consulta o Registro para verificar se o firewall está ativado no perfil de domínio. Requer privilégios administrativos no Windows.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**:
  - No Linux: O comando `ufw` deve estar instalado (ex.: `sudo apt install ufw` no Ubuntu/Debian).
- **Permissões**:
  - Windows: Requer privilégios administrativos para acessar o Registro.
  - Linux: Requer privilégios de `sudo` para executar `ufw status`.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell (com privilégios administrativos no Windows):
```powershell
.\check-firewall-status.ps1
```

### Exemplo de Saída
- No Windows (firewall ativado):
  ```
  ✅ Firewall enabled
  ```
- No Windows (firewall desativado):
  ```
  ⚠️ Firewall disabled
  ```
- No Linux (exemplo de saída do `ufw`):
  ```
  ✅ Firewall status: active
  To                         Action      From
  --                         ------      ----
  22/tcp                     ALLOW       Anywhere
  ```
- Erro no Linux (ufw não instalado):
  ```
  ⚠️ Error in line 10: 'ufw' command not found on this Linux system.
  ```
- Erro no Windows (sem privilégios administrativos):
  ```
  ⚠️ Error in line 15: This script requires administrative privileges on Windows.
  ```

## Notas
- No Linux, o script executa `sudo ufw status`, que pode exigir a senha do usuário.
- No Windows, verifica apenas o perfil de domínio (`DomainProfile`) no Registro. Outros perfis (ex.: Public, Private) não são verificados.
- A saída no Linux depende da configuração do `ufw` e pode variar.
- O script não modifica configurações do firewall, apenas exibe o status.