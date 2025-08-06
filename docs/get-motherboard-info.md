# get-motherboard-info.ps1

Este script coleta informações sobre a placa-mãe do sistema, incluindo modelo e fabricante. No Windows, usa `Get-CimInstance Win32_BaseBoard`. No Linux, usa `dmidecode -t baseboard` (requer privilégios de root). Exibe as informações formatadas no console.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**:
  - No Linux: O comando `dmidecode` deve estar instalado (ex.: `sudo apt install dmidecode` no Ubuntu/Debian).
- **Permissões**:
  - Windows: Não requer privilégios administrativos.
  - Linux: Requer privilégios de root para executar `dmidecode`.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell (com privilégios de root no Linux):
```powershell
.\get-motherboard-info.ps1
```

No Linux, execute com sudo:
```bash
sudo pwsh ./get-motherboard-info.ps1
```

### Exemplo de Saída
- No Windows:
  ```
  ✅ Motherboard X570 AORUS ELITE by Gigabyte Technology Co., Ltd.
  ```
- No Linux:
  ```
  ✅ Motherboard B450M DS3H by Gigabyte Technology Co., Ltd.
  ```
- Erro no Linux (sem `dmidecode`):
  ```
  ⚠️ Error in line 10: 'dmidecode' command not found on this Linux system. Install it (e.g., 'sudo apt install dmidecode').
  ```
- Erro no Windows (sem informações):
  ```
  ⚠️ Error in line 20: No motherboard information found on this Windows system.
  ```

## Notas
- No Windows, o script usa `Get-CimInstance Win32_BaseBoard` para obter informações detalhadas da placa-mãe.
- No Linux, o script usa `dmidecode -t baseboard`, que requer privilégios de root e a instalação do pacote `dmidecode`.
- Valores desconhecidos ou ausentes são exibidos como "Unknown".
- O script não modifica configurações do sistema, apenas exibe informações.