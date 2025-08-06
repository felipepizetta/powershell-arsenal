# check-disk-space.ps1

Este script verifica o espaço em disco de uma unidade específica (ex.: C para Windows, / para Linux), exibindo informações sobre o espaço total, usado e livre. Alerta se a unidade está cheia ou com espaço livre abaixo de um limite mínimo (padrão: 10 GB). Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, especificando a unidade (opcional) e o limite mínimo de espaço livre (opcional):
```powershell
.\check-disk-space.ps1 -DriveName "C" -MinLevel (10 * 1000 * 1000 * 1000)
```

Se o nome da unidade não for fornecido, o script solicita ao usuário:
```powershell
.\check-disk-space.ps1
```

### Exemplo de Saída
- Unidade com espaço suficiente:
  ```
  ✅ Drive C: uses 63% of 237.56GB: 87.24GB free
  ```
- Unidade quase cheia:
  ```
  ⚠️ Drive D: with 476.81GB is nearly full, 5.45GB free
  ```
- Unidade cheia:
  ```
  ⚠️ Drive E: with 100.00GB is full
  ```
- Unidade vazia:
  ```
  ✅ Drive F: is empty
  ```

## Parâmetros
- `-DriveName`: Nome da unidade a verificar (ex.: C para Windows, / para Linux). Padrão: solicita entrada do usuário.
- `-MinLevel`: Limite mínimo de espaço livre em bytes (padrão: 10 GB = 10,000,000,000 bytes).

## Notas
- Em Windows, o nome da unidade deve ser apenas a letra (ex.: C), e o script adiciona ":" automaticamente.
- Em Linux, use o ponto de montagem (ex.: /).
- O script usa `Get-PSDrive` para obter informações da unidade, que pode não funcionar para unidades de rede em algumas configurações.
- Os tamanhos são exibidos em formato legível (ex.: KB, MB, GB, TB, PB) com duas casas decimais.