# verify-user-credentials.ps1

Este script verifica as credenciais fornecidas pelo usuário (nome de usuário e senha) em relação a um arquivo de credenciais seguro (padrão: `$HOME\my.credentials`). Exibe uma mensagem indicando se as credenciais estão corretas. Suporta apenas sistemas Windows.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Versão 5.1 ou superior.
- **Permissões**: Não requer privilégios administrativos.
- **Arquivo de Credenciais**: Um arquivo de credenciais seguro deve existir no caminho especificado (padrão: `$HOME\my.credentials`). Para criar o arquivo:
  ```powershell
  $credential = Get-Credential
  $credential.Password | ConvertFrom-SecureString | Out-File "$HOME\my.credentials"
  ```
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, opcionalmente especificando o caminho do arquivo de credenciais:
```powershell
.\verify-user-credentials.ps1 -TargetFile "$HOME\my.credentials"
```

### Exemplo de Saída
- Credenciais corretas:
  ```
  Enter username and password, please.
  ✅ Your credentials are correct.
  ```
- Nome de usuário incorreto:
  ```
  Enter username and password, please.
  ⚠️ Error in line 17: Sorry, your username is wrong.
  ```
- Senha incorreta:
  ```
  Enter username and password, please.
  ⚠️ Error in line 21: Sorry, your password is wrong.
  ```

## Notas
- O script solicita credenciais via uma interface gráfica segura (`Get-Credential`).
- O arquivo de credenciais deve conter uma senha convertida para `SecureString`, gerada com `ConvertFrom-SecureString`.
- A comparação de senhas é case-sensitive.
- O script não é compatível com sistemas Linux.
- Por segurança, as senhas são limpas da memória após a comparação.