#
# PowerShell Core: CurrentUserAllHosts
#

# Aliases: Basic
Set-Alias -Name c -Value "Clear-Host"
function .. { Set-Location ".." }
function ll { ls }

# Aliases: *nix
Set-Alias -Name which -Value "Get-Command"

# WSL Interop
# https://github.com/mikebattista/PowerShell-WSL-Interop
Import-WslCommand "chmod", "grep", "head", "less", "ls", "man", "ssh", "tail", "touch"
$WslDefaultParameterValues = @{}
$WslDefaultParameterValues["grep"] = "-E"
$WslDefaultParameterValues["less"] = "-i"
$WslDefaultParameterValues["ls"] = "-AFhl --color=auto"

# Pretty development-centered prompt
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox-Tweak
$ThemeSettings.Colors.PromptBackgroundColor = 'Blue'
$DefaultUser = "$Env:username"
