# Define parâmetro para o endereço IPv6 a ser validado
param(
    # Endereço IPv6 a validar (ex.: 2001:db8::1); vazio solicita entrada do usuário
    [string]$Address = ""
)

# Função para validar um endereço IPv6 usando expressão regular
function Test-IPv6Address {
    param(
        # Endereço IPv6 a ser validado
        [string]$IP
    )
    # Expressão regular para IPv4 (usada em endereços IPv6 mistos)
    $IPv4Regex = '((25[0-5]|2[0-4][0-9]|[01]?[0-9]{1,2})\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9]{1,2})'
    # Padrão para grupos hexadecimais de 1 a 4 caracteres
    $G = '[a-fA-F0-9]{1,4}'
    # Possíveis padrões para a parte final do endereço IPv6
    $tail = @(
        ":",
        "(:($G)?|$IPv4Regex)",
        ":($IPv4Regex|$G(:$G)?|)",
        "(:$IPv4Regex|:$G(:$IPv4Regex|(:$G){0,2})|:)",
        "((:$G){0,2}(:$IPv4Regex|(:$G){1,2})|:)",
        "((:$G){0,3}(:$IPv4Regex|(:$G){1,2})|:)",
        "((:$G){0,4}(:$IPv4Regex|(:$G){1,2})|:)"
    )
    # Constrói a expressão regular para IPv6
    [string]$IPv6RegexString = $G
    foreach ($part in $tail) {
        $IPv6RegexString = "${G}:(?:$IPv6RegexString|$part)"
    }
    $IPv6RegexString = ":(:$G){0,5}(?:(:$G){1,2}|:$IPv4Regex)|$IPv6RegexString"
    # Torna todos os grupos não capturantes
    $IPv6RegexString = $IPv6RegexString -replace '\(', '(?:'
    # Compila a expressão regular
    [regex]$IPv6Regex = "^$IPv6RegexString$"
    # Retorna $true se o endereço corresponde ao formato, $false caso contrário
    return $IP -imatch $IPv6Regex
}

# Bloco principal do script para validar o endereço IPv6
try {
    # Se o endereço não foi fornecido, solicita ao usuário
    if ([string]::IsNullOrEmpty($Address)) {
        $Address = Read-Host "Enter IPv6 address to validate"
    }

    # Remove espaços em branco do endereço
    $Address = $Address.Trim()

    # Verifica se o endereço está vazio após o trim
    if ([string]::IsNullOrEmpty($Address)) {
        Write-Error "⚠️ No IPv6 address provided."
        exit 1
    }

    # Valida o endereço IPv6 usando a função Test-IPv6Address
    if (Test-IPv6Address -IP $Address) {
        Write-Host "✅ IPv6 $Address is valid"
        # Sai com código de sucesso
        exit 0
    }
    else {
        Write-Host "⚠️ Invalid IPv6 address: $Address"
        # Sai com código de erro
        exit 1
    }
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}