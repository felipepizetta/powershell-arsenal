# validate-mac-address.ps1

## Descrição
Este script valida um endereço MAC fornecido como parâmetro ou via entrada do usuário, usando uma expressão regular para verificar o formato (seis pares de dígitos hexadecimais separados por dois-pontos, hífens ou sem separadores). Exibe uma mensagem indicando se o endereço é válido ou inválido. Suporta sistemas Windows e Linux.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, especificando o endereço MAC (opcional):
```powershell
.\validate-mac-address.ps1 -MAC "00:1A:2B:3C:4D:5E"
```

Se o endereço não for fornecido, o script solicita ao usuário:
```powershell
.\validate-mac-address.ps1
```

### Exemplo de Saída
- Endereço válido:
  ```
  ✅ MAC address 00:1A:2B:3C:4D:5E is valid
  ```
- Endereço inválido:
  ```
  ⚠️ Invalid MAC address: 00:1A:2B:3C:4D:GG
  ```
- Entrada vazia:
  ```
  ⚠️ No MAC address provided.
  ```

## Parâmetros
- `-MAC`: Endereço MAC a validar (ex.: 00:1A:2B:3C:4D:5E, 00-1A-2B-3C-4D-5E ou 001A2B3C4D5E). Padrão: solicita entrada do usuário.

## Notas
- O script usa uma expressão regular para validar o formato de endereços MAC (seis pares hexadecimais separados por `:` ou `-`, ou sem separadores).
- Espaços em branco no endereço são removidos automaticamente.
- Endereços inválidos ou entradas vazias resultam em saída com código de erro 1.
- O script é compatível com Windows e Linux, pois não depende de comandos específicos do sistema.