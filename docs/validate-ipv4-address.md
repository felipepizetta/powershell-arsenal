# validate-ipv4-address.ps1

Este script valida um endereço IPv4 fornecido como parâmetro ou via entrada do usuário, usando uma expressão regular para verificar o formato (quatro octetos de 0 a 255, separados por pontos). Exibe uma mensagem indicando se o endereço é válido ou inválido. Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, especificando o endereço IPv4 (opcional):
```powershell
.\validate-ipv4-address.ps1 -Address "192.168.1.1"
```

Se o endereço não for fornecido, o script solicita ao usuário:
```powershell
.\validate-ipv4-address.ps1
```

### Exemplo de Saída
- Endereço válido:
  ```
  ✅ IPv4 192.168.1.1 is valid
  ```
- Endereço inválido:
  ```
  ⚠️ Invalid IPv4 address: 256.168.1.1
  ```
- Entrada vazia:
  ```
  ⚠️ No IPv4 address provided.
  ```

## Parâmetros
- `-Address`: Endereço IPv4 a validar (ex.: 192.168.1.1). Padrão: solicita entrada do usuário.

## Notas
- O script usa uma expressão regular para validar o formato de endereços IPv4 (quatro octetos de 0 a 255, separados por pontos).
- Espaços em branco no endereço são removidos automaticamente.
- Endereços inválidos ou entradas vazias resultam em saída com código de erro 1.
- O script é compatível com Windows e Linux, pois não depende de comandos específicos do sistema.