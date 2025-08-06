# get-bios-info.ps1

Este script coleta e exibe informações do BIOS do sistema, incluindo modelo, versão, data de lançamento, número de série e fabricante. Suporta sistemas Windows e Linux (com `dmidecode` instalado).

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com `dmidecode` instalado.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**:
  - Windows: Não requer privilégios administrativos.
  - Linux: Requer privilégios de `sudo` para executar comandos `dmidecode`.
- **Dependências no Linux**: O pacote `dmidecode` deve estar instalado (`sudo apt install dmidecode` no Ubuntu/Debian, por exemplo).
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\get-bios-info.ps1
```

### Exemplo de Saída
- Em Windows:
  ```
  ✅ BIOS model 1.0, version 5.17 of 04/15/2023, S/N 123456789 by American Megatrends Inc.
  ```
- Em Linux:
  ```
  ✅ BIOS model Latitude 7490, version 1.2.3 of 03/10/2022, S/N N/A by Dell Inc.
  ```
- Sem informações disponíveis (Linux):
  ```
  ⚠️ No BIOS information available.
  ```

## Notas
- Em Linux, o script depende do comando `dmidecode` e requer privilégios de `sudo`.
- Alguns sistemas podem retornar valores genéricos como "To be filled by O.E.M.", que são substituídos por "N/A" para clareza.
- O número de série não é obtido em sistemas Linux neste script.
