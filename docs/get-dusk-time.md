# get-dusk-time.ps1

Este script obtém a hora do crepúsculo (pôr do sol) do site `wttr.in`, calcula o intervalo de tempo em relação ao momento atual e exibe uma mensagem indicando se o crepúsculo ocorrerá em breve ou já passou, com o tempo formatado em horas e minutos. Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**: Conexão com a internet para acessar o serviço `wttr.in`.
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\get-dusk-time.ps1
```

### Exemplo de Saída
- Crepúsculo no futuro:
  ```
  ✅ Dusk is in 2 hours and 15 minutes at 6:45 PM.
  ```
- Crepúsculo no passado:
  ```
  ✅ Dusk was 1 hour and 30 minutes ago at 6:45 PM.
  ```
- Erro (sem conexão com a internet):
  ```
  ⚠️ Error in line 20: The remote server returned an error: (503) Service Unavailable.
  ```

## Notas
- O script usa o serviço `wttr.in` para obter a hora do crepúsculo, que pode variar com base na localização do IP do usuário.
- A cultura do sistema é definida como `en-US` para garantir formatação consistente de datas e horas.
- O formato da hora retornada por `wttr.in` deve ser `HH:MM:SS`. Formatos inválidos causam erro.
- O script não aceita parâmetros; a localização é inferida automaticamente pelo `wttr.in`.