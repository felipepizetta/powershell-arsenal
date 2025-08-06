# list-local-users.ps1

Este script lista todos os usuários locais de um sistema Windows, verifica se cada um possui privilégios administrativos e salva os resultados em um arquivo CSV no diretório `C:\Temp`. Também exibe os resultados no console em formato de tabela.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Versão 5.1 ou superior.
- **Permissões**: Requer privilégios administrativos para acessar informações de usuários e grupos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell com privilégios administrativos:
```powershell
.\list-local-users.ps1
```

### Exemplo de Saída
No console:
```
ComputerName UserName IsAdmin
------------ -------- -------
PC01         Admin    True
PC01         User1    False
PC01         Guest    False
```
Mensagem:
```
✅ Report saved to: C:\Temp\PC01.csv
```

O arquivo CSV (`C:\Temp\PC01.csv`) conterá:
```csv
ComputerName,UserName,IsAdmin
PC01,Admin,True
PC01,User1,False
PC01,Guest,False
```

## Notas
- O script requer privilégios administrativos para acessar informações do grupo "Administradores".
- O diretório `C:\Temp` é criado automaticamente, se não existir.
- O arquivo CSV usa codificação UTF-8 para compatibilidade ampla.
- O script não é compatível com sistemas Linux.