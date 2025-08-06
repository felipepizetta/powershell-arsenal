# Bloco principal do script para obter e "falar" o dia da semana em inglês
try {
    # Define a cultura do thread atual como en-US para garantir que o dia da semana seja retornado em inglês
    [System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]"en-US"

    # Obtém o dia da semana atual no formato de nome completo (ex.: Monday)
    $weekday = Get-Date -Format "dddd"

    # Define o caminho do script speak-english.ps1, assumindo que está no mesmo diretório
    $speakScript = Join-Path $PSScriptRoot "speak-english.ps1"

    # Verifica se o script speak-english.ps1 existe
    if (-not (Test-Path $speakScript -PathType Leaf)) {
        Write-Error "⚠️ The script 'speak-english.ps1' was not found in the same directory ($PSScriptRoot)."
        exit 1
    }

    # Executa o script speak-english.ps1 com o argumento "It's $weekday."
    & $speakScript "It's $weekday."

    # Exibe mensagem de sucesso no console
    Write-Host "✅ Successfully spoke: It's $weekday."
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}