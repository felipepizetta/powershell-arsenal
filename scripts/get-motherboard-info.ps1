# Bloco principal do script para obter informações da placa-mãe
try {
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o comando 'dmidecode' está disponível
        if (-not (Get-Command "dmidecode" -ErrorAction SilentlyContinue)) {
            Write-Error "⚠️ 'dmidecode' command not found on this Linux system. Install it (e.g., 'sudo apt install dmidecode')."
            exit 1
        }
        # Verifica se o usuário tem permissões de root para executar dmidecode
        if (-not (whoami | Select-String "root")) {
            Write-Error "⚠️ 'dmidecode' requires root privileges. Run with sudo or as root."
            exit 1
        }
        # Executa dmidecode para obter informações da placa-mãe
        $dmiInfo = dmidecode -t baseboard 2>$null
        # Extrai fabricante e modelo usando expressões regulares
        $manufacturer = if ($dmiInfo -match "Manufacturer: (.+)$") { $Matches[1] } else { "Unknown" }
        $product = if ($dmiInfo -match "Product Name: (.+)$") { $Matches[1] } else { "Unknown" }
        # Exibe informações formatadas
        Write-Host "✅ Motherboard $product by $manufacturer"
    }
    else {
        # No Windows, obtém informações da placa-mãe usando Get-CimInstance (mais moderno que Get-WmiObject)
        $details = Get-CimInstance -ClassName Win32_BaseBoard -ErrorAction Stop
        # Verifica se informações foram encontradas
        if (-not $details) {
            Write-Error "⚠️ No motherboard information found on this Windows system."
            exit 1
        }
        # Obtém fabricante e modelo, tratando valores nulos
        $manufacturer = if ($details.Manufacturer) { $details.Manufacturer } else { "Unknown" }
        $product = if ($details.Product) { $details.Product } else { "Unknown" }
        # Exibe informações formatadas
        Write-Host "✅ Motherboard $product by $manufacturer"
    }

    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}