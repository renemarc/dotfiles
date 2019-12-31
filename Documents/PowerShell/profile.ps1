#
# PowerShell profile
#

$ColorInfo = "DarkYellow"
$ColorWarn = "DarkRed"

# Load split configuration for easier maintenance
Push-Location (Split-Path -parent $profile)
"functions","aliases","exports","extras" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location

# Setup a pretty development-oriented PowerShell prompt
Import-Module posh-git
Import-Module oh-my-posh
#Set-Theme Paradox-Tweak
Set-Theme Paradox
$ThemeSettings.Colors.PromptBackgroundColor = "Blue"
$DefaultUser = $Env:username

# Display if/which WSL Interop commands are imported
if (Get-Module -ListAvailable -Name WslInterop) {
    Write-Host "Windows Subsystem for Linux (WSL) Interop enabled." -ForegroundColor $ColorInfo
    Write-Host "WSL commands available: $($WslImportedCommands | sort)" -ForegroundColor $ColorInfo
}
