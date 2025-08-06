# get-gpu-info.ps1

Este script coleta informações detalhadas sobre os controladores de vídeo (GPUs) do sistema, incluindo modelo, tamanho da RAM, resolução, profundidade de cor, taxa de atualização, versão do driver e status. No Windows, usa `Get-CimInstance Win32_VideoController`. No Linux, usa `lspci` para identificar dispositivos VGA (suporte limitado). Exibe as informações formatadas no console.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**:
  - No Linux: O comando `lspci` deve estar instalado (ex.: `sudo apt install pciutils` no Ubuntu/Debian).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\get-gpu-info.ps1
```

### Exemplo de Saída
- No Windows:
  ```
  ✅ NVIDIA GeForce RTX 3080 GPU (10.00GB RAM, 1920x1080 pixels, 32-bit, 60 Hz, driver 31.0.15.1740) - status OK
  ```
- No Linux:
  ```
  ✅ NVIDIA Corporation GM204 [GeForce GTX 970] GPU (N/A RAM, N/AxN/A pixels, N/A-bit, N/A Hz, driver N/A) - status N/A
  ```
- Erro no Linux (sem `lspci`):
  ```
  ⚠️ Error in line 28: 'lspci' command not found on this Linux system.
  ```
- Erro no Windows (sem GPUs detectadas):
  ```
  ⚠️ Error in line 45: No GPU information found on this Windows system.
  ```

## Notas
- No Windows, o script usa `Get-CimInstance Win32_VideoController` para obter informações completas da GPU.
- No Linux, o suporte é limitado ao comando `lspci`, que fornece apenas o modelo da GPU. Outros detalhes (RAM, resolução, etc.) não estão disponíveis e são exibidos como "N/A".
- O tamanho da RAM é formatado em KB, MB, GB ou TB com duas casas decimais para maior legibilidade.
- O script não modifica configurações do sistema, apenas exibe informações.