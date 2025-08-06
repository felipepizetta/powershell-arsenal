# Define parâmetro para o endereço IPv4 a ser validado
param(
    # Endereço IPv4 a validar (ex.: 192.168.1.1); vazio solicita entrada do usuário
    [string]$Address = ""
)

# Função para validar um endereço IPv4 usando expressão regular
function Test-IPv4Address {
    param(
        # Endereço IPv4 a ser validado
        [string]$IP
    )
    # Expressão regular para validar formato de IPv4 (quatro octetos de 0 a 255, separados por pontos)
    $regex = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
    # Retorna $true se o endereço corresponde ao formato, $false caso contrário
    return $IP -match $regex
}

# Bloco principal do script para validar o endereço IPv4
try {
    # Se o endereço não foi fornecido, solicita ao usuário
    if ([string]::IsNullOrEmpty($Address)) {
        $Address = Read-Host "Enter IPv4 address to validate"
    }

    # Remove espaços em branco do endereço
    $Address = $Address.Trim()

    # Verifica se o endereço está vazio após o trim
    if ([string]::IsNullOrEmpty($Address)) {
        Write-Error "⚠️ No IPv4 address provided."
        exit 1
    }

    # Valida o endereço IPv4 usando a função Test-IPv4Address
    if (Test-IPv4Address -IP $Address) {
        Write-Host "✅ IPv4 $Address is valid"
        # Sai com código de sucesso
        exit 0
    }
    else {
        Write-Host "⚠️ Invalid IPv4 address: $Address"
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