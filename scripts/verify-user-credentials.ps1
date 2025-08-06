# Define um parâmetro para especificar o caminho do arquivo de credenciais
param(
    # Caminho do arquivo de credenciais seguro, padrão é $HOME\my.credentials
    [string]$TargetFile = "$HOME\my.credentials"
)

# Bloco principal do script para verificar credenciais
try {
    # Verifica se o arquivo de credenciais existe
    if (-not (Test-Path $TargetFile -PathType Leaf)) {
        Write-Error "⚠️ Credential file not found at: $TargetFile"
        exit 1
    }

    # Exibe mensagem solicitando que o usuário insira nome de usuário e senha
    Write-Host "Enter username and password, please." -ForegroundColor Red
    # Solicita credenciais do usuário usando uma interface gráfica segura
    $credsFromUser = Get-Credential -Message "Enter your credentials" -ErrorAction Stop

    # Verifica se o usuário cancelou a entrada de credenciais
    if ($null -eq $credsFromUser) {
        Write-Error "⚠️ Credential input was cancelled."
        exit 1
    }

    # Lê o conteúdo do arquivo de credenciais e converte para uma SecureString
    $secureString = Get-Content $TargetFile -ErrorAction Stop | ConvertTo-SecureString -ErrorAction Stop
    # Cria um objeto PSCredential com o nome de usuário fornecido e a senha do arquivo
    $credsFromFile = New-Object System.Management.Automation.PSCredential($credsFromUser.UserName, $secureString)

    # Compara o nome de usuário fornecido com o do arquivo
    if ($credsFromUser.UserName -ne $credsFromFile.UserName) {
        throw "Sorry, your username is wrong."
    }

    # Converte a senha fornecida pelo usuário de SecureString para texto simples
    $pw1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromUser.Password))
    # Converte a senha do arquivo de credenciais de SecureString para texto simples
    $pw2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromFile.Password))
    # Compara as senhas (case-sensitive, usando -cne)
    if ($pw1 -cne $pw2) {
        throw "Sorry, your password is wrong."
    }

    # Limpa as variáveis de senha da memória por segurança
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromUser.Password))
    [Runtime.InteropServices.Marshal]::ZeroFreeBSTR([Runtime.InteropServices.Marshal]::SecureStringToBSTR($credsFromFile.Password))

    # Exibe mensagem de sucesso se as credenciais estiverem corretas
    Write-Host "✅ Your credentials are correct."
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}
finally {
    # Garante que as senhas sejam limpas da memória, mesmo em caso de erro
    if ($pw1) { $pw1 = $null }
    if ($pw2) { $pw2 = $null }
}