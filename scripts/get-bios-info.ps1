# Bloco principal do script para coletar informações do BIOS
try {
    # Inicializa variáveis para armazenar informações do BIOS
    $model = ""
    $version = ""
    $releaseDate = ""
    $serial = ""
    $manufacturer = ""

    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o comando dmidecode está disponível
        if (-not (Get-Command "dmidecode" -ErrorAction SilentlyContinue)) {
            Write-Error "⚠️ dmidecode not found on this Linux system."
            exit 1
        }
        # Exibe barra de progresso para indicar que o script está coletando dados
        Write-Progress -Activity "Querying BIOS details..." -Status "In progress"
        # Obtém o modelo do sistema usando dmidecode (requer sudo)
        $model = sudo dmidecode -s system-product-name
        # Se o modelo estiver vazio, sai do script sem erro
        if ([string]::IsNullOrEmpty($model)) {
            Write-Host "⚠️ No BIOS information available."
            exit 0
        }
        # Obtém a versão do BIOS
        $version = sudo dmidecode -s bios-version
        # Obtém a data de lançamento do BIOS
        $releaseDate = sudo dmidecode -s bios-release-date
        # Obtém o fabricante do sistema
        $manufacturer = sudo dmidecode -s system-manufacturer
        # Completa a barra de progresso
        Write-Progress -Activity "Querying BIOS details..." -Completed
        # Define número de série como "N/A" (não disponível via dmidecode neste caso)
        $serial = "N/A"
    }
    else {
        # Para Windows, obtém detalhes do BIOS usando Get-CimInstance
        $details = Get-CimInstance -ClassName Win32_BIOS -ErrorAction Stop
        # Obtém o modelo do BIOS e remove espaços extras
        $model = $details.Name.Trim()
        # Obtém a versão do BIOS e remove espaços extras
        $version = $details.Version.Trim()
        # Obtém o número de série e remove espaços extras
        $serial = $details.SerialNumber.Trim()
        # Obtém o fabricante e remove espaços extras
        $manufacturer = $details.Manufacturer.Trim()
        # Obtém a data de lançamento do BIOS (se disponível)
        $releaseDate = if ($details.ReleaseDate) { $details.ReleaseDate.ToString("MM/dd/yyyy") } else { "" }
    }

    # Substitui valores genéricos "To be filled by O.E.M." por "N/A" para clareza
    if ($model -eq "To be filled by O.E.M.") { $model = "N/A" }
    if ($version -eq "To be filled by O.E.M.") { $version = "N/A" }
    if ($serial -eq "To be filled by O.E.M.") { $serial = "N/A" }
    # Formata a data de lançamento, se disponível
    if (-not [string]::IsNullOrEmpty($releaseDate)) { $releaseDate = " of $releaseDate" }
    # Se o número de série estiver vazio, define como "N/A"
    if ([string]::IsNullOrEmpty($serial)) { $serial = "N/A" }

    # Exibe as informações do BIOS em uma linha formatada
    Write-Host "✅ BIOS model $model, version $version$releaseDate, S/N $serial by $manufacturer"
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}