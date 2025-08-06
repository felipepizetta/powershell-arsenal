# get-os-info.ps1

Este script coleta informações detalhadas sobre o sistema operacional, incluindo nome, arquitetura (32-bit ou 64-bit), versão, data de instalação, número de série e chave de produto (no Windows). No Linux, fornece informações básicas como nome e arquitetura. Exibe os detalhes formatados no console.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Não requer privilégios administrativos (no Windows); no Linux, informações adicionais podem exigir root.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\get-os-info.ps1
```

### Exemplo de Saída
- No Windows:
  ```
  ✅ Windows 10 64-bit since 01/15/2023 (v10.0.19044, Build 19044, S/N 12345-67890-ABCDE-FGHIJ, P/K XXXXX-XXXXX-XXXXX-XXXXX-XXXXX)
  ```
- No Linux:
  ```
  ✅ Unix 12.3.0.0 (Linux 64-bit)
  ```
- Erro (sem acesso a informações):
  ```
  ⚠️ Error in line 10: No motherboard information found on this Windows system.
  ```

## Notas
- No Windows, o script usa `Get-CimInstance Win32_OperatingSystem` para obter informações detalhadas, incluindo data de instalação e chave de produto (se disponível).
- No Linux, o script usa `$PSVersionTable.OS` para informações básicas; informações mais detalhadas (ex.: distribuição) podem ser adicionadas com ferramentas como `cat /etc/os-release` (requer root).
- A chave de produto pode ser "N/A" em sistemas corporativos ou com licenciamento KMS.
- A data de instalação é formatada em en-US para consistência.