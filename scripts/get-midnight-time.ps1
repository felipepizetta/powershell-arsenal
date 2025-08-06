# Função para formatar um TimeSpan em uma string legível (horas e minutos)
function Convert-TimeSpanToString {
    param(
        # Intervalo de tempo a ser formatado
        [TimeSpan]$Delta
    )
    # Inicializa a string de resultado
    $result = ""
    # Adiciona horas à string, se houver
    if ($Delta.Hours -eq 1) {
        $result += "1 hour and "
    }
    elseif ($Delta.Hours -gt 1) {
        $result += "$($Delta.Hours) hours and "
    }
    # Adiciona minutos à string
    if ($Delta.Minutes -eq 1) {
        $result += "1 minute"
    }
    else {
        $result += "$($Delta.Minutes) minutes"
    }
    # Retorna a string formatada
    return $result
}

# Bloco principal do script para calcular e anunciar o tempo em relação à meia-noite
try {
    # Define o caminho do script speak-english.ps1, assumindo que está no mesmo diretório
    $speakScript = Join-Path $PSScriptRoot "speak-english.ps1"

    # Verifica se o script speak-english.ps1 existe
    if (-not (Test-Path $speakScript -PathType Leaf)) {
        Write-Error "⚠️ The script 'speak-english.ps1' was not found in the same directory ($PSScriptRoot)."
        exit 1
    }

    # Obtém a data e hora atuais
    $now = [DateTime]::Now

    # Determina se é antes ou depois do meio-dia
    if ($now.Hour -lt 12) {
        # Define a meia-noite do dia atual (00:00:00)
        $midnight = Get-Date -Hour 0 -Minute 0 -Second 0 -ErrorAction Stop
        # Calcula o intervalo desde a meia-noite
        $timeSpan = Convert-TimeSpanToString ($now - $midnight)
        # Monta a mensagem para meia-noite passada
        $reply = "Midnight was $timeSpan ago."
    }
    else {
        # Define a meia-noite do dia seguinte (23:59:59 do dia atual)
        $midnight = (Get-Date -Hour 23 -Minute 59 -Second 59 -ErrorAction Stop).AddDays(1)
        # Calcula o intervalo até a próxima meia-noite
        $timeSpan = Convert-TimeSpanToString ($midnight - $now)
        # Monta a mensagem para meia-noite futura
        $reply = "Midnight is in $timeSpan."
    }

    # Executa o script speak-english.ps1 para anunciar a mensagem
    & $speakScript $reply

    # Exibe a mensagem no console
    Write-Host "✅ $reply"
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}