# speak-english.ps1

Este script utiliza a API SAPI (Speech Application Programming Interface) para sintetizar e falar um texto em inglês fornecido como parâmetro ou via entrada do usuário. Seleciona automaticamente uma voz em inglês entre as disponíveis no sistema e exibe uma mensagem de confirmação no console. Compatível apenas com Windows.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Versão 5.1 ou superior.
- **Dependências**: Requer uma voz em inglês instalada no sistema (ex.: voz padrão do Windows em inglês).
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell, especificando o texto (opcional):
```powershell
.\speak-english.ps1 -text "Hello, world!"
```

Se o texto não for fornecido, o script solicita ao usuário:
```powershell
.\speak-english.ps1
```

### Exemplo de Saída
- Texto válido:
  ```
  ✅ Text 'Hello, world!' has been spoken.
  ```
  (O texto "Hello, world!" será falado em voz inglesa.)
- Sem voz em inglês:
  ```
  ⚠️ Error in line 25: No English voice found. Please install an English voice pack.
  ```
- Entrada vazia:
  ```
  ⚠️ No text provided to speak.
  ```

## Parâmetros
- `-text`: Texto em inglês a ser falado (ex.: "Hello, world!"). Padrão: solicita entrada do usuário.

## Notas
- O script usa a API SAPI, disponível apenas no Windows, para síntese de voz.
- Requer que uma voz em inglês esteja instalada; caso contrário, falhará com um erro.
- Espaços em branco no texto são removidos automaticamente.
- Não suporta Linux devido à dependência de COM (SAPI).