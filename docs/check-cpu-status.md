# check-cpu-status.ps1

Este script coleta e exibe informações sobre a CPU do sistema, incluindo nome, arquitetura, número de núcleos, temperatura, ID do dispositivo, velocidade e tipo de soquete. Funciona em sistemas Windows e Linux, com suporte para temperaturas em sistemas compatíveis.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com suporte a `/sys/class/thermal/thermal_zone0/temp`.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Em Windows, pode requerer privilégios administrativos para acessar algumas informações via WMI.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\check-cpu-status.ps1
```

### Exemplo de Saída
- Em Windows:
  ```
  ✅ Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz (AMD64, 8 cores, 45.2°C, CPU0, 3600MHz, LGA1151 socket)
  ```
- Em Linux:
  ```
  ✅ x64 CPU (8 cores, 42.5°C)
  ```
- Em caso de temperatura alta:
  ```
  ⚠️ Intel(R) Core(TM) i7-9700K CPU @ 3.60GHz (AMD64, 8 cores, 85.0°C TOO HOT, CPU0, 3600MHz, LGA1151 socket)
  ```

## Notas
- A temperatura pode não ser suportada em todos os sistemas (exibe vazio se não disponível).
- Em Linux, o script depende do arquivo `/sys/class/thermal/thermal_zone0/temp`.
- Em Windows, usa WMI para coletar informações, o que pode exigir privilégios elevados.