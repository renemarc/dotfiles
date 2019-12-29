#
# PowerShell profile: aliases
#

# Easier navigation: .., ..., ...., ....., ~ and -
function ~ { Set-Location ~ }
function .. { Set-Location ".." }
function ... { Set-Location "../.." }
function .... { Set-Location "../../.." }
function ..... { Set-Location "../../../.." }
function -- { Set-Location "-" }

# Directory browsing
if (Get-Command ls -errorAction Ignore) {
    function ll { ls }
}
else {
    function ll { Get-ChildItem . -Force }
}

# Host-level *nix equivalents
Set-Alias -Name which -Value "Get-Command"

# Git
Set-Alias -Name g -Value "$Env:Programfiles\Git\cmd\git.exe"

# Docker
Set-Alias -Name d -Value "$Env:Programfiles\Docker\Docker\resources\bin\docker.exe"
Set-Alias -Name dokcer -Value "$Env:Programfiles\Docker\Docker\resources\bin\docker.exe"
Set-Alias -Name dcomp -Value "$Env:Programfiles\Docker\Docker\resources\bin\docker-compose.exe"

# Text editors
Set-Alias -Name subl -Value "$Env:Programfiles\Sublime Text 3\subl.exe"

# Paths
function archives { Set-Location "~\Archives" }
function docs { Set-Location "~\Documents" }
function dl { Set-Location "~\Downloads" }
function dt { Set-Location "~\Desktop" }
function repos { Set-Location "~\Code" }
