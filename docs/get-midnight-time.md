# get-midnight-time.ps1

Este script calcula o intervalo de tempo desde a meia-noite passada (se antes das 12h) ou até a próxima meia-noite (se depois das 12h) e anuncia o resultado usando o script `speak-english.ps1`. Também exibe a mensagem no console. Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**: O script `speak-english.ps1` deve estar no mesmo diretório que `get-midnight-time.ps1`.
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\get-midnight-time.ps1
```

### Exemplo de Saída
- Antes das 12h (ex.: 9:30 AM):
  ```
  ✅ Midnight was 9 hours and 30 minutes ago.
  ```
  (O script `speak-english.ps1` também fala: "Midnight was 9 hours and 30 minutes ago.")
- Depois das 12h (ex.: 2:45 PM):
  ```
  ✅ Midnight is in 9 hours and 15 minutes.
  ```
  (O script `speak-english.ps1` também fala: "Midnight is in 9 hours and 15 minutes.")
- Erro (script `speak-english.ps1` não encontrado):
  ```
  ⚠️ Error in line 12: The script 'speak-english.ps1' was not found in the same directory (C:\path\to\script).
  ```

## Notas
- O script usa a hora atual do sistema para calcular o intervalo de tempo.
- A meia-noite passada é definida como 00:00:00 do dia atual; a meia-noite futura é definida como 00:00:00 do dia seguinte.
- Requer o script `speak-english.ps1` no mesmo diretório, que deve implementar funcionalidade de síntese de voz.
- A mensagem é anunciada via `speak-english.ps1` e exibida no console para maior acessibilidade.