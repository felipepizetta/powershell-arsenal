# Define parâmetro para o endereço MAC a ser validado
param(
    # Endereço MAC a validar (ex.: 00:1A:2B:3C:4D:5E); vazio solicita entrada do usuário
    [string]$MAC = ""
)

# Função para validar um endereço MAC usando expressão regular
function Test-MACAddress {
    param(
        # Endereço MAC a ser validado
        [string]$MAC
    )
    # Expressão regular para validar formato de MAC (seis pares hexadecimais separados por : ou -, ou sem separadores)
    $regex = "^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$|^([0-9A-Fa-f]{2}){6}$"
    # Retorna $true se o endereço corresponde ao formato, $false caso contrário
    return $MAC -match $regex
}

# Bloco principal do script para validar o endereço MAC
try {
    # Se o endereço não foi fornecido, solicita ao usuário
    if ([string]::IsNullOrEmpty($MAC)) {
        $MAC = Read-Host "Enter MAC address to validate"
    }

    # Remove espaços em branco do endereço
    $MAC = $MAC.Trim()

    # Verifica se o endereço está vazio após o trim
    if ([string]::IsNullOrEmpty($MAC)) {
        Write-Error "⚠️ No MAC address provided."
        exit 1
    }

    # Valida o endereço MAC usando a função Test-MACAddress
    if (Test-MACAddress -MAC $MAC) {
        Write-Host "✅ MAC address $MAC is valid"
        # Sai com código de sucesso
        exit 0
    }
    else {
        Write-Host "⚠️ Invalid MAC address: $MAC"
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