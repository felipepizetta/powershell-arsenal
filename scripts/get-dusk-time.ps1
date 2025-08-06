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

# Bloco principal do script para obter e exibir informações sobre o crepúsculo
try {
    # Define a cultura do thread atual como en-US para consistência na formatação de datas
    [System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]"en-US"

    # Faz uma requisição web ao wttr.in para obter a hora do crepúsculo (formato HH:MM:SS)
    $response = Invoke-WebRequest -Uri "http://wttr.in/?format=%d" -UserAgent "curl" -UseBasicParsing -ErrorAction Stop
    # Obtém o conteúdo da resposta (esperado no formato HH:MM:SS)
    $string = $response.Content

    # Verifica se a resposta contém um formato válido de hora
    if ($string -notmatch '^\d{2}:\d{2}:\d{2}$') {
        Write-Error "⚠️ Invalid time format received from wttr.in: $string"
        exit 1
    }

    # Divide a string de hora em horas, minutos e segundos
    $hour, $minute, $second = $string -split ':'
    # Valida se os valores são numéricos
    if (-not [int]::TryParse($hour, [ref]$null) -or
        -not [int]::TryParse($minute, [ref]$null) -or
        -not [int]::TryParse($second, [ref]$null)) {
        Write-Error "⚠️ Invalid numeric values for time: $string"
        exit 1
    }

    # Cria um objeto DateTime para a hora do crepúsculo no dia atual
    $dusk = Get-Date -Hour $hour -Minute $minute -Second $second -ErrorAction Stop
    # Obtém a data e hora atuais
    $now = [DateTime]::Now

    # Determina se o crepúsculo está no futuro ou no passado
    if ($now -lt $dusk) {
        # Calcula o intervalo até o crepúsculo
        $timeSpan = Convert-TimeSpanToString ($dusk - $now)
        # Monta a mensagem para crepúsculo futuro
        $reply = "Dusk is in $timeSpan at $($dusk.ToShortTimeString())."
    }
    else {
        # Calcula o intervalo desde o crepúsculo
        $timeSpan = Convert-TimeSpanToString ($now - $dusk)
        # Monta a mensagem para crepúsculo passado
        $reply = "Dusk was $timeSpan ago at $($dusk.ToShortTimeString())."
    }

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