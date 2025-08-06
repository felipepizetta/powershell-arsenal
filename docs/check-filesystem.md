# check-filesystem.ps1

Este script verifica a integridade do sistema de arquivos de uma unidade específica usando o cmdlet `Repair-Volume` com a opção `-Scan`. Se não forem encontrados erros, anuncia o resultado usando o script `speak-english.ps1` e exibe uma mensagem no console. Requer privilégios administrativos e suporta apenas sistemas Windows.

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior.
- **PowerShell**: Versão 5.1 ou superior.
- **Dependências**: O script `speak-english.ps1` deve estar no mesmo diretório que `check-filesystem.ps1`.
- **Permissões**: Requer privilégios administrativos (definido por `#Requires -RunAsAdministrator`).
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell com privilégios administrativos, especificando a letra da unidade (opcional):
```powershell
.\check-filesystem.ps1 -Drive "C"
```

Se a letra da unidade não for fornecida, o script solicita ao usuário:
```powershell
.\check-filesystem.ps1
```

### Exemplo de Saída
- Sistema de arquivos limpo:
  ```
  ✅ File system on drive C is clean.
  ```
  (O script `speak-english.ps1` também fala: "File system on drive C is clean.")
- Unidade inválida:
  ```
  ⚠️ Error in line 15: Drive X does not exist.
  ```
- Erro na verificação:
  ```
  ⚠️ Error in line 24: The file system check on drive C failed with result: ErrorsFound
  ```

## Parâmetros
- `-Drive`: Letra da unidade a verificar (ex.: C). Padrão: solicita entrada do usuário.

## Notas
- O script usa `Repair-Volume -Scan` para verificar a integridade do sistema de arquivos sem fazer alterações.
- Requer o script `speak-english.ps1` no mesmo diretório, que deve implementar funcionalidade de síntese de voz.
- Não suporta sistemas Linux, pois `Repair-Volume` é específico do Windows.
- A letra da unidade deve ser um único caractere alfabético (ex.: C, D).