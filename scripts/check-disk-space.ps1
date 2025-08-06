# Define parâmetros para o nome da unidade e o limite mínimo de espaço livre
param(
    # Nome da unidade a verificar (ex.: C para Windows, / para Linux); vazio solicita entrada do usuário
    [string]$DriveName = "",
    # Limite mínimo de espaço livre em bytes (padrão: 10 GB = 10 * 1000 * 1000 * 1000 bytes)
    [int64]$MinLevel = 10 * 1000 * 1000 * 1000
)

# Função para converter bytes em uma string legível (ex.: KB, MB, GB, TB, PB)
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
    if ($Bytes -lt 1000) { return "$([math]::Round($Bytes, 2))TB" }
    # Converte para PB
    $Bytes /= 1000
    return "$([math]::Round($Bytes, 2))PB"
}

# Bloco principal do script para verificar o espaço em disco
try {
    # Se o nome da unidade não foi fornecido, solicita ao usuário
    if ([string]::IsNullOrEmpty($DriveName)) {
        $DriveName = Read-Host "Enter the drive name to check"
    }

    # Valida se o nome da unidade contém caracteres inválidos
    if ($DriveName -match '[<>:"/\\|?*]') {
        Write-Error "⚠️ Invalid drive name: $DriveName"
        exit 1
    }

    # Obtém informações da unidade usando Get-PSDrive
    $details = Get-PSDrive -Name $DriveName -ErrorAction Stop
    # Adiciona dois pontos ao nome da unidade para Windows (ex.: C:)
    if (-not $IsLinux) { $DriveName = "$DriveName`:" }

    # Obtém o espaço livre, usado e total em bytes
    [int64]$free = $details.Free
    [int64]$used = $details.Used
    [int64]$total = $used + $free

    # Verifica diferentes condições do espaço em disco
    if ($total -eq 0) {
        # Se a unidade estiver vazia (sem capacidade detectada)
        Write-Host "✅ Drive $DriveName is empty"
    }
    elseif ($free -eq 0) {
        # Se a unidade estiver completamente cheia
        Write-Host "⚠️ Drive $DriveName with $(Convert-BytesToString $total) is full"
    }
    elseif ($free -lt $MinLevel) {
        # Se o espaço livre for menor que o limite mínimo
        Write-Host "⚠️ Drive $DriveName with $(Convert-BytesToString $total) is nearly full, $(Convert-BytesToString $free) free"
    }
    else {
        # Calcula a porcentagem de uso
        [int64]$percent = ($used * 100) / $total
        # Exibe informações normais de uso
        Write-Host "✅ Drive $DriveName uses $percent% of $(Convert-BytesToString $total): $(Convert-BytesToString $free) free"
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