# Bloco principal do script para testar a velocidade de resolução DNS
try {
    # Define o caminho do arquivo CSV com a lista de domínios
    $csvPath = Join-Path $PSScriptRoot "../data/popular-domains.csv"

    # Verifica se o arquivo CSV existe
    if (-not (Test-Path $csvPath -PathType Leaf)) {
        Write-Error "⚠️ CSV file not found at: $csvPath"
        exit 1
    }

    # Importa o arquivo CSV contendo os domínios
    $table = Import-Csv -Path $csvPath -ErrorAction Stop

    # Verifica se o CSV contém a coluna 'Domain'
    if (-not ($table | Get-Member -Name "Domain" -MemberType NoteProperty)) {
        Write-Error "⚠️ CSV file must contain a 'Domain' column."
        exit 1
    }

    # Verifica se o CSV contém pelo menos um domínio
    if ($table.Length -eq 0) {
        Write-Error "⚠️ CSV file is empty."
        exit 1
    }

    # Inicia um cronômetro para medir o tempo de execução
    $stopWatch = [System.Diagnostics.Stopwatch]::StartNew()

    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o comando 'dig' está disponível
        if (-not (Get-Command "dig" -ErrorAction SilentlyContinue)) {
            Write-Error "⚠️ 'dig' command not found on this Linux system."
            exit 1
        }
        # Itera sobre cada linha do CSV e executa consulta DNS com 'dig'
        foreach ($row in $table) {
            # Executa 'dig' com +short para obter apenas o resultado da consulta
            $null = dig $row.Domain +short
        }
    }
    else {
        # No Windows, limpa o cache DNS para garantir resultados precisos
        Clear-DnsClientCache -ErrorAction Stop
        # Itera sobre cada linha do CSV e executa consulta DNS com Resolve-DnsName
        foreach ($row in $table) {
            # Executa a resolução DNS para o domínio
            $null = Resolve-DnsName -Name $row.Domain -ErrorAction Stop
        }
    }

    # Para o cronômetro e calcula o tempo total em milissegundos
    $stopWatch.Stop()
    [float]$elapsed = $stopWatch.Elapsed.TotalSeconds * 1000.0

    # Calcula o tempo médio de resolução por domínio (em milissegundos)
    $speed = [math]::Round($elapsed / $table.Length, 1)

    # Determina a mensagem com base na velocidade média
    if ($speed -lt 10.0) {
        Write-Host "✅ Internet DNS: $($speed)ms excellent lookup time"
    }
    elseif ($speed -lt 100.0) {
        Write-Host "✅ Internet DNS: $($speed)ms lookup time"
    }
    else {
        Write-Host "⚠️ Internet DNS: $($speed)ms slow lookup time"
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