# Requer PowerShell versão 5.1 ou superior para compatibilidade com COM
#Requires -Version 5.1

# Define parâmetro para o texto a ser falado
param(
    # Texto em inglês a ser falado; vazio solicita entrada do usuário
    [string]$text = ""
)

# Bloco principal do script para sintetizar e falar o texto
try {
    # Se o texto não foi fornecido, solicita ao usuário
    if ([string]::IsNullOrEmpty($text)) {
        $text = Read-Host "Enter the English text to speak"
    }

    # Remove espaços em branco do texto
    $text = $text.Trim()

    # Verifica se o texto está vazio após o trim
    if ([string]::IsNullOrEmpty($text)) {
        Write-Error "⚠️ No text provided to speak."
        exit 1
    }

    # Cria um objeto COM para controle de síntese de voz SAPI
    $tts = New-Object -ComObject SAPI.SPVoice -ErrorAction Stop

    # Verifica se o objeto COM foi criado com sucesso
    if (-not $tts) {
        Write-Error "⚠️ Failed to initialize SAPI.SPVoice COM object."
        exit 1
    }

    # Itera sobre as vozes disponíveis para selecionar uma em inglês
    foreach ($voice in $tts.GetVoices()) {
        if ($voice.GetDescription() -like "*- English*") {
            $tts.Voice = $voice
            break
        }
    }

    # Verifica se uma voz em inglês foi encontrada
    if (-not $tts.Voice) {
        Write-Error "⚠️ No English voice found. Please install an English voice pack."
        exit 1
    }

    # Faz o texto ser falado
    [void]$tts.Speak($text)

    # Exibe mensagem de sucesso no console
    Write-Host "✅ Text '$text' has been spoken."
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}