# Função para converter bytes em uma string legível (ex.: KB, MB, GB, TB)
function Convert-BytesToString {
    param(
        # Valor em bytes a ser convertido
        [int64]$Bytes
    )
    # Se menos de 1000 bytes, retorna como bytes
    if ($Bytes -lt 1000) { return "$Bytes bytes" }
    # Converte para KB
    $Bytes /= 1000
    if ($Bytes -lt 1000) { return "$([math]::Round($Bytes, 2))KB" }
    # Converte para MB
    $Bytes /= 1000
    if ($Bytes -lt 1000) { return "$([math]::Round($Bytes, 2))MB" }
    # Converte para GB
    $Bytes /= 1000
    if ($Bytes -lt 1000) { return "$([math]::Round($Bytes, 2))GB" }
    # Converte para TB
    $Bytes /= 1000
    return "$([math]::Round($Bytes, 2))TB"
}

# Bloco principal do script para obter informações das GPUs
try {
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o comando 'lspci' está disponível
        if (-not (Get-Command "lspci" -ErrorAction SilentlyContinue)) {
            Write-Error "⚠️ 'lspci' command not found on this Linux system."
            exit 1
        }
        # Executa lspci para obter informações sobre dispositivos VGA
        $gpuInfo = lspci | Where-Object { $_ -match "VGA" }
        if (-not $gpuInfo) {
            Write-Error "⚠️ No GPU information found on this Linux system."
            exit 1
        }
        # Itera sobre cada linha de saída do lspci
        foreach ($gpu in $gpuInfo) {
            # Extrai o modelo da GPU (parte após "VGA compatible controller:")
            $model = if ($gpu -match "VGA compatible controller: (.+)$") { $Matches[1] } else { "Unknown" }
            # Informações adicionais não disponíveis diretamente via lspci
            $ramSize = "N/A"
            $resWidth = "N/A"
            $resHeight = "N/A"
            $bitsPerPixel = "N/A"
            $refreshRate = "N/A"
            $driverVersion = "N/A"
            $status = "N/A"
            # Exibe informações formatadas
            Write-Host "✅ $model GPU ($ramSize RAM, $($resWidth)x$($resHeight) pixels, $bitsPerPixel-bit, $refreshRate Hz, driver $driverVersion) - status $status"
        }
    }
    else {
        # No Windows, obtém informações das GPUs usando Get-CimInstance (mais moderno que Get-WmiObject)
        $details = Get-CimInstance -ClassName Win32_VideoController -ErrorAction Stop
        # Verifica se foram encontradas GPUs
        if (-not $details) {
            Write-Error "⚠️ No GPU information found on this Windows system."
            exit 1
        }
        # Itera sobre cada controlador de vídeo
        foreach ($gpu in $details) {
            # Obtém detalhes da GPU, tratando valores nulos
            $model = if ($gpu.Caption) { $gpu.Caption } else { "Unknown" }
            $ramSize = if ($gpu.AdapterRAM) { $gpu.AdapterRAM } else { 0 }
            $resWidth = if ($gpu.CurrentHorizontalResolution) { $gpu.CurrentHorizontalResolution } else { "N/A" }
            $resHeight = if ($gpu.CurrentVerticalResolution) { $gpu.CurrentVerticalResolution } else { "N/A" }
            $bitsPerPixel = if ($gpu.CurrentBitsPerPixel) { $gpu.CurrentBitsPerPixel } else { "N/A" }
            $refreshRate = if ($gpu.CurrentRefreshRate) { $gpu.CurrentRefreshRate } else { "N/A" }
            $driverVersion = if ($gpu.DriverVersion) { $gpu.DriverVersion } else { "N/A" }
            $status = if ($gpu.Status) { $gpu.Status } else { "Unknown" }
            # Exibe informações formatadas
            Write-Host "✅ $model GPU ($(Convert-BytesToString $ramSize) RAM, $($resWidth)x$($resHeight) pixels, $bitsPerPixel-bit, $refreshRate Hz, driver $driverVersion) - status $status"
        }
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