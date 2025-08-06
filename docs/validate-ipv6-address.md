# validate-ipv6-address.ps1

Este script valida um endereço IPv6 fornecido como parâmetro ou via entrada do usuário, usando uma expressão regular para verificar o formato (incluindo endereços completos, abreviados com `::` e mistos com IPv4). Exibe uma mensagem indicando se o endereço é válido ou inválido. Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, especificando o endereço IPv6 (opcional):
```powershell
.\validate-ipv6-address.ps1 -Address "2001:db8::1"
```

Se o endereço não for fornecido, o script solicita ao usuário:
```powershell
.\validate-ipv6-address.ps1
```

### Exemplo de Saída
- Endereço válido:
  ```
  ✅ IPv6 2001:db8::1 is valid
  ```
- Endereço inválido:
  ```
  ⚠️ Invalid IPv6 address: 2001:db8::g
  ```
- Entrada vazia:
  ```
  ⚠️ No IPv6 address provided.
  ```

## Parâmetros
- `-Address`: Endereço IPv6 a validar (ex.: 2001:db8::1). Padrão: solicita entrada do usuário.

## Notas
- O script usa uma expressão regular para validar o formato de endereços IPv6, incluindo formatos completos (ex.: `2001:0db8:0000:0000:0000:0000:0000:0001`), abreviados (ex.: `2001:db8::1`) e mistos com IPv4 (ex.: `::ffff:192.168.1.1`).
- Espaços em branco no endereço são removidos automaticamente.
- Endereços inválidos ou entradas vazias resultam em saída com código de erro 1.
- O script é compatível com Windows e Linux, pois não depende de comandos específicos do sistema.