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

# Applications
Set-Alias -Name subl -Value "$Env:Programfiles\Sublime Text 3\subl.exe"
function ss {
    Invoke-Expression (&starship init powershell)
}

# Paths: generic
function docs { Set-Location "~\Documents" }
function dl { Set-Location "~\Downloads" }
function dt { Set-Location "~\Desktop" }

# Paths: custom
function archives { Set-Location "~\Archives" }
function chezmoiconf { Set-Location "~\.local\share\chezmoi"}
function repos { Set-Location "~\Code" }
function sublimeconf { Set-Location "~\AppData\Roaming\Sublime Text 3\Packages\User"}
