# Script para listar usuários locais e suas permissões administrativas
# Requer execução com privilégios administrativos

# Obtém o nome do computador
$computerName = $env:COMPUTERNAME

# Cria uma lista para armazenar os resultados
$results = @()

# Obtém todos os usuários locais
$localUsers = Get-LocalUser

# Obtém os membros do grupo Administradores
$adminGroup = Get-LocalGroupMember -Group "Administradores" -ErrorAction SilentlyContinue

foreach ($user in $localUsers) {
    $isAdmin = $false
    if ($adminGroup) {
        $isAdmin = $adminGroup.Name -contains "$computerName\$($user.Name)"
    }
    
    # Cria um objeto com as informações do usuário
    $userInfo = [PSCustomObject]@{
        ComputerName = $computerName
        UserName     = $user.Name
        IsAdmin      = $isAdmin
    }
    
    $results += $userInfo
}

# Define o caminho para salvar o relatório usando apenas o nome do computador
$outputPath = "C:\Temp\$computerName.csv"
$results | Export-Csv -Path $outputPath -NoTypeInformation -Encoding UTF8

# Exibe os resultados no console
$results | Format-Table -AutoSize

# Mensagem de conclusão
Write-Host "Relatório salvo em: $outputPath"R