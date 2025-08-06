# Requer privilégios administrativos para executar Repair-Volume
#Requires -RunAsAdministrator

# Define parâmetro para a letra da unidade a ser verificada
param(
    # Letra da unidade a verificar (ex.: C); vazio solicita entrada do usuário
    [string]$Drive = ""
)

# Bloco principal do script para verificar a integridade do sistema de arquivos
try {
    # Se a letra da unidade não foi fornecida, solicita ao usuário
    if ([string]::IsNullOrEmpty($Drive)) {
        $Drive = Read-Host "Enter drive (letter) to check"
    }

    # Valida se a letra da unidade é um único caractere alfabético
    if ($Drive -notmatch '^[A-Za-z]$') {
        Write-Error "⚠️ Invalid drive letter: $Drive. Please provide a single letter (ex.: C)."
        exit 1
    }

    # Converte a letra da unidade para maiúscula para consistência
    $Drive = $Drive.ToUpper()

    # Verifica se a unidade existe usando Get-PSDrive
    if (-not (Get-PSDrive -Name $Drive -ErrorAction SilentlyContinue)) {
        Write-Error "⚠️ Drive $Drive does not exist."
        exit 1
    }

    # Define o caminho do script speak-english.ps1, assumindo que está no mesmo diretório
    $speakScript = Join-Path $PSScriptRoot "speak-english.ps1"

    # Verifica se o script speak-english.ps1 existe
    if (-not (Test-Path $speakScript -PathType Leaf)) {
        Write-Error "⚠️ The script 'speak-english.ps1' was not found in the same directory ($PSScriptRoot)."
        exit 1
    }

    # Executa a verificação do sistema de arquivos na unidade especificada
    $result = Repair-Volume -DriveLetter $Drive -Scan -ErrorAction Stop

    # Verifica se a verificação encontrou erros
    if ($result -ne "NoErrorsFound") {
        throw "The file system check on drive $Drive failed with result: $result"
    }

    # Executa o script speak-english.ps1 para anunciar que o sistema de arquivos está limpo
    & $speakScript "File system on drive $Drive is clean."

    # Exibe mensagem de sucesso no console
    Write-Host "✅ File system on drive $Drive is clean."
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}