#
# PowerShell profile
#

$ColorInfo = 'DarkYellow'
$ColorWarn = 'DarkRed'

# Load split configuration.
Push-Location (Split-Path -parent $profile)
"functions","aliases","exports","extra" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location

# Pretty development-centered prompt
Import-Module posh-git
Import-Module oh-my-posh
#Set-Theme Paradox-Tweak
Set-Theme Paradox
$ThemeSettings.Colors.PromptBackgroundColor = 'Blue'
$DefaultUser = $Env:username

if (Get-Module -ListAvailable -Name WslInterop) {
    Write-Host "Windows Subsystem for Linux (WSL) Interop enabled." -ForegroundColor ($ColorInfo,'Yellow')[!$ColorInfo]
    Write-Host "WSL commands available:" ($WslImportedCommands | sort) -ForegroundColor ($ColorInfo,'Yellow')[!$ColorInfo]
}
