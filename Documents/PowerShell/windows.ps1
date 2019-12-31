#
# PowerShell Windows configuration script
#

# Changing system properties requires to be running Powershell as an admin
#Requires -RunAsAdministrator

if (!$IsWindows) {
    Write-Host "This script is meant to be run on a Windows OS only." -ForegroundColor ($ColorWarn,"DarkRed")[!$ColorWarn]
    exit
}

if ((Get-Variable "ColorInfo" -ErrorAction "Ignore") -eq $null) {
    Set-Variable -Name ColorInfo -Value "DarkYellow"
}
Set-Variable -Name count -Value 0 -Scope Script

# Terminates the script and counts the actions taken
function eos {
    if ($count) {
        Write-Host "Done! $count modification(s) applied." -ForegroundColor $ColorInfo
    }
    else {
        Write-Host "No modifications performed." -ForegroundColor $ColorInfo
    }
    Remove-Variable -Name count -Scope Script
}

# Are you sure?
Write-Host "This script will perform the following non-destructive adjustements to the system (if required):" -ForegroundColor $ColorInfo
Write-Host "    - Install package provider NuGet" -ForegroundColor $ColorInfo
Write-Host "    - Install/update module WSL Interop (on PowerShell Core only)" -ForegroundColor $ColorInfo
Write-Host "    - Install/update module PSReadLine (on PowerShell Core only)" -ForegroundColor $ColorInfo
Write-Host "    - Install/update module posh-git" -ForegroundColor $ColorInfo
Write-Host "    - Install/update module oh-my-posh" -ForegroundColor $ColorInfo
Write-Host "    - Enable LongPaths support for file paths above 260 characters" -ForegroundColor $ColorInfo
$confirmation = Read-Host -Prompt "Do you want to proceed? [y/N]"
if ($confirmation -notMatch '^y(es)?$') {
    eos
    exit
}
Remove-Variable -Name confirmation


#
# Dependencies
#

# Install NuGet package manager required to install WSL Interop and eventual others
# https://www.nuget.org/
if (Get-PackageProvider -ListAvailable -Name NuGet -ErrorAction "Ignore") {
    Write-Host "NuGet already installed, skipping." -ForegroundColor $ColorInfo
}
else {
    Write-Host "Installing NuGet..." -ForegroundColor $ColorInfo
    Install-PackageProvider -Name NuGet -Force
    $count++
}

# Install or update WSL Interop to skip having to prefix Linux commands with `wsl`
# https://github.com/mikebattista/PowerShell-WSL-Interop
if ($IsCoreCLR) {
    if (Get-Module -ListAvailable -Name WslInterop -ErrorAction "Ignore") {
        Write-Host "Checking for WSL Interop updates..." -ForegroundColor $ColorInfo
        Update-Module WslInterop
    }
    else {
        Write-Host "Installing WSL Interop..." -ForegroundColor $ColorInfo
        Install-Module WslInterop
        Get-Module -ListAvailable -Name WslInterop
        $count++
    }
}
else {
    Write-Host "PowerShell version is too old, skipping WSL Interop installation." -ForegroundColor $ColorInfo
}

# Install or update PSReadLine to allow syntax coloring of prompt (amongst others)
# https://github.com/PowerShell/PSReadLine
if ($IsCoreCLR) {
    if (Get-Module -ListAvailable -Name PSReadLine -ErrorAction "Ignore") {
        # (Get-Module -ListAvailable -Name PSReadLine).Version.Major[0]
        Write-Host "Checking for PSReadLine updates..." -ForegroundColor $ColorInfo
        Update-Module PSReadLine
    }
    else {
        Write-Host "Installing PSReadLine..." -ForegroundColor $ColorInfo
        Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
        Get-Module -ListAvailable -Name PSReadLine
        $count++
    }
}

# Install or update Posh-Git to display Git status summary information in prompt
# https://github.com/dahlbyk/posh-git
if (Get-Module -ListAvailable -Name posh-git -ErrorAction "Ignore") {
    Write-Host "Checking for posh-git updates..." -ForegroundColor $ColorInfo
    Update-Module posh-git
}
else {
    Write-Host "Installing posh-git..." -ForegroundColor $ColorInfo
    if ($IsCoreCLR) {
        Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
    }
    else {
        Install-Module posh-git -Scope CurrentUser -Force
    }
    Get-Module -ListAvailable -Name posh-git
    $count++
}

# Install or update Oh-My-Posh for prompt theming
# https://github.com/JanDeDobbeleer/oh-my-posh
if (Get-Module -ListAvailable -Name oh-my-posh -ErrorAction "Ignore") {
    Write-Host "Checking for oh-my-posh updates..." -ForegroundColor $ColorInfo
    Update-Module oh-my-posh
}
else {
    Write-Host "Installing oh-my-posh..." -ForegroundColor $ColorInfo
    Install-Module oh-my-posh -Scope CurrentUser
    Get-Module -ListAvailable -Name oh-my-posh
    $count++
}

# Verify that scoop is setup properly
# https://github.com/lukesampson/scoop
Write-Host "Verifying the state of Scoop..." -ForegroundColor $ColorInfo
Get-Command -Name scoop -ErrorAction Stop
Invoke-Command -ScriptBlock { scoop checkup }


#
# System tweaks
#

# Enable LongPaths support for file paths above 260 characters
# https://social.msdn.microsoft.com/Forums/en-US/fc85630e-5684-4df6-ad2f-5a128de3deef
$property = 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem'
$name = 'LongPathsEnabled'
if ((Get-ItemPropertyValue $property -Name $name) -ne 0) {
    Write-Host "LongPaths support already enabled, skipping." -ForegroundColor $ColorInfo
}
else {
    Write-Host "Enabling LongPaths support for file paths above 260 characters." -ForegroundColor $ColorInfo
    Set-ItemProperty $property -Name $name -Value 1
    $count++
}

# Display termination message
eos
