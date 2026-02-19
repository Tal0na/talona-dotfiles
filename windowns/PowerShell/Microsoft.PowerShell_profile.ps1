# Função para verificar a conexão com a internet
function Test-InternetConnection {
    try {
        $url = "https://www.google.com"  
        $request = Invoke-WebRequest -Uri $url -Method Head -TimeoutSec 5
        return $true
    } catch {
        return $false
    }
}

# Exibindo mensagem indicando que está verificando as atualizações
Write-Host "Verificando updates..."

# Inicialize o Oh My Posh com o tema montys
if (Test-Path "C:\Users\talona\AppData\Local\Programs\oh-my-posh\themes\montys.omp.json") {
    Write-Host "Inicializando o Oh My Posh com o tema montys..."
    oh-my-posh init pwsh --config "C:\Users\talona\AppData\Local\Programs\oh-my-posh\themes\montys.omp.json" | Invoke-Expression
}

# Configuração do PSReadLine para melhorar a experiência de predição de comandos
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Defina um alias para o comando clear (evitar sobrescrever o existente)
Set-Alias clearScreen clear

# Importação do Chocolatey Profile para completar comandos do Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Configuração do Editor
# Verifique se o Visual Studio Code está instalado
if (Get-Command "code" -ErrorAction SilentlyContinue) {
    $env:EDITOR = "code"
    Write-Host "Visual Studio Code encontrado. Editor configurado como 'code'."
} elseif (Test-Path "C:\Program Files\Notepad++\notepad++.exe") {
    $env:EDITOR = "notepad++"
    Write-Host "Notepad++ encontrado. Editor configurado como 'notepad++'."
} else {
    Write-Host "Nenhum editor encontrado. Usando o padrão."
    $env:EDITOR = "notepad"
}

# Verify if have connection com a internet antes de tentar atualizar
if (Test-InternetConnection) {
    Write-Host "Conexão com a internet detectada. Iniciando os updates..."

    } else {
    Write-Host "Nenhuma conexão com a internet."
}

# Alias personalizados sem sobrescrever os existentes
Set-Alias showDir Get-ChildItem
Set-Alias copyItem Copy-Item
Set-Alias moveItem Move-Item
Set-Alias removeItem Remove-Item

# Configuração adicional de predição de comandos
Set-PSReadLineOption -HistorySaveStyle SaveAtExit

# Limpar a tela após carregar tudo
Write-Host "Concluído. Limpando a tela..."
clear

