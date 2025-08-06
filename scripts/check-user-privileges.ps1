# Bloco principal do script para verificar privilégios do usuário
try {
    # Verifica se o sistema é Linux (não suportado neste script)
    if ($IsLinux) {
        # Exibe mensagem de erro para sistemas Linux
        Write-Error "⚠️ This script is not supported on Linux systems."
        # Sai com código de erro
        exit 1
    }
    else {
        # Obtém a identidade do usuário atual
        $user = [Security.Principal.WindowsIdentity]::GetCurrent()
        # Cria um objeto WindowsPrincipal para verificar os papéis do usuário
        $principal = New-Object Security.Principal.WindowsPrincipal $user
        # Obtém o nome de usuário para exibição
        $username = $user.Name
        # Verifica se o usuário tem privilégios administrativos
        if ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
            # Exibe mensagem confirmando privilégios administrativos
            Write-Host "✅ Yes, $username has admin rights."
        }
        # Verifica se o usuário tem privilégios de convidado
        elseif ($principal.IsInRole([Security.Principal.WindowsBuiltinRole]::Guest)) {
            # Exibe mensagem indicando privilégios de convidado
            Write-Host "⚠️ No, $username has guest rights only."
        }
        # Caso não seja administrador nem convidado, assume usuário padrão
        else {
            # Exibe mensagem indicando privilégios de usuário padrão
            Write-Host "⚠️ No, $username has normal user rights only."
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