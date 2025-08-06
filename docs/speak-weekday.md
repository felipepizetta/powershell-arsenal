# speak-weekday.ps1

Este script obtém o dia da semana atual em inglês (ex.: Monday) e usa o script `speak-english.ps1` para sintetizar a fala do texto "It's [weekday].". Funciona em sistemas Windows e Linux, desde que o script `speak-english.ps1` esteja presente no mesmo diretório.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**: O script `speak-english.ps1` deve estar no mesmo diretório que `speak-weekday.ps1`.
- **Permissões**: Não requer privilégios administrativos.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\speak-weekday.ps1
```

### Exemplo de Saída
No console:
```
✅ Successfully spoke: It's Monday.
```
O script também faz com que `speak-english.ps1` fale: "It's Monday."

### Exemplo de Erro
Se o `speak-english.ps1` não for encontrado:
```
⚠️ Error in line 12: The script 'speak-english.ps1' was not found in the same directory (C:\path\to\script).
```

## Notas
- O script define a cultura do sistema como `en-US` para garantir que o dia da semana seja retornado em inglês.
- Requer o script `speak-english.ps1` no mesmo diretório, que deve implementar funcionalidade de síntese de voz.
- A funcionalidade de fala depende da implementação do `speak-english.ps1` e do suporte do sistema operacional (ex.: System.Speech.Synthesis no Windows ou ferramentas como `espeak` no Linux).