# Função para obter a arquitetura da CPU
function Get-CPUArchitecture {
    # Verifica se a variável de ambiente PROCESSOR_ARCHITECTURE está definida (usada em Windows)
    if ($env:PROCESSOR_ARCHITECTURE -ne "") {
        # Retorna a arquitetura da CPU diretamente da variável de ambiente
        return $env:PROCESSOR_ARCHITECTURE
    }
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Obtém o nome do sistema operacional
        $osName = $PSVersionTable.OS
        # Verifica se o sistema é um kernel genérico do Linux
        if ($osName -like "*-generic *") {
            # Retorna x64 ou x86 com base na arquitetura do sistema operacional
            if ([System.Environment]::Is64BitOperatingSystem) { return "x64" } else { return "x86" }
        }
        # Verifica se o sistema é um Raspberry Pi
        elseif ($osName -like "*-raspi *") {
            # Retorna ARM64 ou ARM32 com base na arquitetura do sistema
            if ([System.Environment]::Is64BitOperatingSystem) { return "ARM64" } else { return "ARM32" }
        }
        # Para outros sistemas Linux, retorna 64-bit ou 32-bit
        elseif ([System.Environment]::Is64BitOperatingSystem) { return "64-bit" } else { return "32-bit" }
    }
    # Retorna "Unknown" se não for possível determinar a arquitetura
    return "Unknown"
}

# Função para obter a temperatura da CPU
function Get-CPUTemperature {
    # Define um valor padrão para temperatura (99999.9 indica "não suportado")
    $temp = 99999.9
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o arquivo de temperatura da CPU existe (comum em sistemas Linux)
        if (Test-Path "/sys/class/thermal/thermal_zone0/temp" -PathType Leaf) {
            # Lê a temperatura em miligrados Celsius
            [int]$intTemp = Get-Content "/sys/class/thermal/thermal_zone0/temp"
            # Converte para graus Celsius com uma casa decimal
            $temp = [math]::Round($intTemp / 1000.0, 1)
        }
    }
    else {
        # Para Windows, usa WMI para consultar informações de temperatura
        $objects = Get-WmiObject -Query "SELECT * FROM Win32_PerfFormattedData_Counters_ThermalZoneInformation" -Namespace "root/CIMV2" -ErrorAction SilentlyContinue
        # Itera sobre os objetos retornados (se houver)
        foreach ($object in $objects) {
            # Obtém a temperatura em alta precisão
            $highPrec = $object.HighPrecisionTemperature
            # Converte para graus Celsius com uma casa decimal
            $temp = [math]::Round($highPrec / 100.0, 1)
        }
    }
    # Retorna a temperatura (ou 99999.9 se não suportado)
    return $temp
}

# Bloco principal do script
try {
    # Exibe uma barra de progresso para indicar que o script está coletando dados
    Write-Progress -Activity "Querying CPU status..." -Status "In progress"

    # Define o status inicial como "OK" (emoji ✅)
    $status = "✅"
    # Obtém a arquitetura da CPU
    $arch = Get-CPUArchitecture

    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Define um nome genérico para a CPU no Linux
        $cpuName = "$arch CPU"
        # Define valores vazios para campos não suportados no Linux
        $archDisplay = ""
        $deviceID = ""
        $speed = ""
        $socket = ""
    }
    else {
        # Para Windows, obtém detalhes da CPU usando Get-WmiObject
        $details = Get-WmiObject -Class Win32_Processor -ErrorAction Stop
        # Obtém o nome da CPU e remove espaços extras
        $cpuName = $details.Name.Trim()
        # Formata a arquitetura para exibição
        $archDisplay = "$arch, "
        # Obtém o ID do dispositivo
        $deviceID = ", $($details.DeviceID)"
        # Obtém a velocidade máxima da CPU em MHz
        $speed = ", $($details.MaxClockSpeed)MHz"
        # Obtém o tipo de soquete da CPU
        $socket = ", $($details.SocketDesignation) socket"
    }

    # Obtém o número de núcleos da CPU
    $cores = [System.Environment]::ProcessorCount
    # Obtém a temperatura da CPU
    $celsius = Get-CPUTemperature

    # Determina a mensagem de temperatura com base no valor
    if ($celsius -eq 99999.9) {
        # Se a temperatura não for suportada, deixa em branco
        $temp = ""
    }
    elseif ($celsius -gt 80) {
        # Se a temperatura for muito alta (>80°C), marca como crítica
        $temp = ", $($celsius)°C TOO HOT"
        $status = "⚠️"
    }
    elseif ($celsius -gt 50) {
        # Se a temperatura for alta (>50°C), marca como alerta
        $temp = ", $($celsius)°C HOT"
        $status = "⚠️"
    }
    elseif ($celsius -lt 0) {
        # Se a temperatura for muito baixa (<0°C), marca como alerta
        $temp = ", $($celsius)°C TOO COLD"
        $status = "⚠️"
    }
    else {
        # Temperatura normal, exibe apenas o valor
        $temp = ", $($celsius)°C"
    }

    # Completa a barra de progresso
    Write-Progress -Activity "Querying CPU status..." -Completed
    # Exibe as informações da CPU em uma linha formatada
    Write-Host "$status $cpuName ($($archDisplay)$cores cores$($temp)$($deviceID)$($speed)$($socket))"
    # Sai do script com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai do script com código de erro
    exit 1
}