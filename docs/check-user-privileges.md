# check-user-privileges.ps1

Este script verifica se o usuário atual no Windows possui privilégios administrativos, de convidado ou de usuário padrão, exibindo uma mensagem correspondente. Suporta apenas sistemas Windows.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Versão 5.1 ou superior.
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\check-user-privileges.ps1
```

### Exemplo de Saída
- Usuário administrador:
  ```
  ✅ Yes, DOMAIN\user has admin rights.
  ```
- Usuário convidado:
  ```
  ⚠️ No, DOMAIN\guest has guest rights only.
  ```
- Usuário padrão:
  ```
  ⚠️ No, DOMAIN\user has normal user rights only.
  ```

## Notas
- O script não é compatível com sistemas Linux (retorna uma mensagem de erro).