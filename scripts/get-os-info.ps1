# Bloco principal do script para obter informações do sistema operacional
try {
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Obtém o nome do sistema operacional a partir do PSVersionTable
        $name = $PSVersionTable.OS
        # Determina a arquitetura do sistema (64-bit ou 32-bit)
        if ([System.Environment]::Is64BitOperatingSystem) {
            $arch = "64-bit"
        }
        else {
            $arch = "32-bit"
        }
        # Exibe informações formatadas
        Write-Host "✅ $name (Linux $arch)"
    }
    else {
        # No Windows, obtém informações básicas do sistema operacional usando Get-CimInstance
        $os = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction Stop
        # Extrai o nome, removendo "Microsoft Windows" para simplificar
        $name = $os.Caption -replace "Microsoft Windows", "Windows"
        # Obtém a arquitetura e versão
        $arch = $os.OSArchitecture
        $version = $os.Version

        # Define a cultura para en-US para formatação consistente de datas
        [System.Threading.Thread]::CurrentThread.CurrentCulture = [System.Globalization.CultureInfo]"en-US"

        # Obtém detalhes adicionais
        $buildNo = $os.BuildNumber
        $serial = if ($os.SerialNumber) { $os.SerialNumber } else { "N/A" }
        $installDate = [System.Management.ManagementDateTimeConverter]::ToDateTime($os.InstallDate)

        # Tenta obter a chave de produto do Registro (pode falhar em algumas configurações)
        $productKey = "N/A"
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform"
        if (Test-Path $regPath) {
            $key = Get-ItemProperty -Path $regPath -Name BackupProductKeyDefault -ErrorAction SilentlyContinue
            if ($key.BackupProductKeyDefault) {
                $productKey = $key.BackupProductKeyDefault
            }
        }

        # Exibe informações formatadas
        Write-Host "✅ $name $arch since $($installDate.ToShortDateString()) (v$version, Build $buildNo, S/N $serial, P/K $productKey)"
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