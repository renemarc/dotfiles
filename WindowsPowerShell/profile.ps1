#
# PowerShell: CurrentUserAllHosts
#

# Aliases: Basic
Set-Alias -Name c -Value "Clear-Host"
function .. { set-location ".." }
function ll { Get-ChildItem . -Force }

# Aliases: *nix
Set-Alias -Name which -Value "Get-Command"
function touch {
    $file = $args[0]
    if ($file -eq $null) {
        throw "usage: touch file"
    }

    if (Test-Path $file) {
        (Get-ChildItem $file).LastWriteTime = Get-Date
    }
    else {
        New-Item -ItemType file $file
    }
}
