# Script para listar usuários locais e suas permissões administrativas
# Requer execução com privilégios administrativos para acessar informações completas

# Bloco principal do script
try {
    # Obtém o nome do computador a partir da variável de ambiente
    $computerName = $env:COMPUTERNAME
    # Cria uma lista vazia para armazenar os resultados
    $results = @()

    # Verifica se o script está sendo executado com privilégios administrativos
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal $user
    if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
        Write-Error "⚠️ This script requires administrative privileges. Run as Administrator."
        exit 1
    }

    # Obtém todos os usuários locais usando Get-LocalUser
    $localUsers = Get-LocalUser -ErrorAction Stop
    # Obtém os membros do grupo "Administradores" (em português, no Windows em PT-BR)
    $adminGroup = Get-LocalGroupMember -Group "Administradores" -ErrorAction SilentlyContinue

    # Itera sobre cada usuário local
    foreach ($user in $localUsers) {
        # Inicializa a variável para verificar se o usuário é administrador
        $isAdmin = $false
        # Se o grupo de administradores foi obtido com sucesso
        if ($adminGroup) {
            # Verifica se o usuário está no grupo de administradores
            $isAdmin = $adminGroup.Name -contains "$computerName\$($user.Name)"
        }

        # Cria um objeto personalizado com as informações do usuário
        $userInfo = [PSCustomObject]@{
            ComputerName = $computerName
            UserName     = $user.Name
            IsAdmin      = $isAdmin
        }

        # Adiciona o objeto à lista de resultados
        $results += $userInfo
    }

    # Define o diretório de saída (C:\Temp)
    $outputDir = "C:\Temp"
    # Verifica se o diretório existe; se não, cria-o
    if (-not (Test-Path $outputDir -PathType Container)) {
        New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
    }
    # Define o caminho completo do arquivo CSV usando o nome do computador
    $outputPath = Join-Path $outputDir "$computerName.csv"

    # Exporta os resultados para um arquivo CSV com codificação UTF-8
    $results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8 -ErrorAction Stop

    # Exibe os resultados no console em formato de tabela
    $results | Format-Table -AutoSize

    # Exibe mensagem de conclusão com o caminho do arquivo salvo
    Write-Host "✅ Report saved to: $outputPath"
    # Sai com código de sucesso
    exit 0
}
catch {
    # Exibe mensagem de erro com número da linha e detalhes
    Write-Error "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($_.Exception.Message)"
    # Sai com código de erro
    exit 1
}