# Bloco principal do script para verificar o status do firewall
try {
    # Verifica se o sistema é Linux
    if ($IsLinux) {
        # Verifica se o comando 'ufw' está disponível
        if (-not (Get-Command "ufw" -ErrorAction SilentlyContinue)) {
            Write-Error "⚠️ 'ufw' command not found on this Linux system."
            exit 1
        }
        # Exibe mensagem inicial indicando verificação do firewall
        Write-Host "✅ Firewall status:" -NoNewline
        # Executa o comando 'ufw status' com sudo para obter detalhes do firewall
        & sudo ufw status
    }
    else {
        # Verifica se o script tem privilégios administrativos (necessário para acessar o Registro)
        $user = [Security.Principal.WindowsIdentity]::GetCurrent()
        $principal = New-Object Security.Principal.WindowsPrincipal $user
        if (-not $principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
            Write-Error "⚠️ This script requires administrative privileges on Windows."
            exit 1
        }

        # Consulta o Registro para verificar o status do firewall no perfil de domínio
        $firewallKey = 'HKLM:\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile'
        $enabled = (Get-ItemProperty -Path $firewallKey -Name 'EnableFirewall' -ErrorAction Stop).EnableFirewall

        # Exibe mensagem com base no estado do firewall
        if ($enabled) {
            Write-Host "✅ Firewall enabled"
        }
        else {
            Write-Host "⚠️ Firewall disabled"
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