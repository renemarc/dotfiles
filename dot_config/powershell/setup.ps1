#
# PowerShell Windows configuration script
#

# Changing system properties requires to be running Powershell as an admin
#Requires -RunAsAdministrator

# Create missing $IsWindows if running Powershell 5 or below
if (!(Test-Path variable:global:IsWindows)) {
    Set-Variable "IsWindows" -Scope "Global" -Value ([System.Environment]::OSVersion.Platform -eq "Win32NT")
}

if ($null -eq (Get-Variable "ColorInfo" -ErrorAction "Ignore")) {
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
$hereString = "
    This script will perform the following non-destructive adjustements to the system (if required):
        - Install package provider NuGet
        - Install/update Powershell modules"
if (!$IsWindows) {
    $hereString += "
        - Enable LongPaths support for file paths above 260 characters"
}
$hereString += [Environment]::NewLine
Write-Host $hereString -ForegroundColor $ColorInfo
$confirmation = Read-Host -Prompt "Do you want to proceed? [y/N]"
if ($confirmation -notMatch '^y(es)?$') {
    eos
    exit
}
Remove-Variable -Name ("confirmation", "hereString")


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

$AllowPrerelease = ($null -ne (Get-Command Install-Module -Syntax | Select-String "AllowPrerelease"))

# Install or update Powershell modules
$modules = @{
    "WslInterop" = @{
        Info = "Linux commands import";
        Repo = "https://github.com/mikebattista/PowerShell-WSL-Interop";
        Install = $IsWindows;
        Force = $false;
        Prerelease = $false;
        IsCoreCLR = $true;
        SkipPublisherCheck = $false;
    };
    "PSReadLine" = @{
        Info = "command line editing";
        Repo = "https://github.com/PowerShell/PSReadLine";
        Install = $true;
        Force = $true;
        Prerelease = $true;
        IsCoreCLR = $false;
        SkipPublisherCheck = $true;
    };
    "posh-git" = @{
        Info = "environment for Git";
        Repo = "https://github.com/dahlbyk/posh-git";
        Install = $true;
        Force = $true;
        Prerelease = $true;
        IsCoreCLR = $false;
        SkipPublisherCheck = $false;
    };
    "oh-my-posh" = @{
        Info = "prompt theming";
        Repo = "https://github.com/JanDeDobbeleer/oh-my-posh";
        Install = $true;
        Force = $false;
        Prerelease = $false;
        IsCoreCLR = $false;
        SkipPublisherCheck = $false;
    };
    "Terminal-Icons" = @{
        Info = "colorized file listings";
        Repo = "https://github.com/devblackops/Terminal-Icons";
        Install = $true;
        Force = $false;
        Prerelease = $false;
        IsCoreCLR = $false;
        SkipPublisherCheck = $false;
    };
}

foreach ($m in ($modules.GetEnumerator() | Sort-Object -Property name)) {
    $name = $m.Name
    $info = $m.Value.Info

    if (!$m.Value.Install -or (!$IsCoreCLR -and $m.Value.IsCoreCLR)) {
        continue
    }

    if (Get-Module -ListAvailable -Name $name -ErrorAction "Ignore") {
        Write-Host "Checking for $name ($info) updates..." -ForegroundColor $ColorInfo
        Update-Module $name
    }
    else {
        Write-Host "Installing $name ($info)..." -ForegroundColor $ColorInfo
        if ($AllowPrerelease -and $m.Value.Prerelease) {
            Install-Module $name -Scope CurrentUser -Force:$m.Value.Force -SkipPublisherCheck:$m.Value.SkipPublisherCheck -AllowPrerelease:$m.Value.Prerelease
        }
        else {
            Install-Module $name -Scope CurrentUser -Force:$m.Value.Force -SkipPublisherCheck:$m.Value.SkipPublisherCheck
        }
        Get-Module -ListAvailable -Name $name
        $count++
    }

    Remove-Variable -Name ("name", "info")
}

# Verify that scoop is setup properly
# https://github.com/lukesampson/scoop
if (Get-Command 'scoop' -ErrorAction "Ignore") {
    Write-Host "Verifying the state of Scoop..." -ForegroundColor $ColorInfo
    Get-Command -Name scoop -ErrorAction Stop
    Invoke-Command -ScriptBlock { scoop checkup }
}

#
# System tweaks
#

# Enable LongPaths support for file paths above 260 characters
# https://social.msdn.microsoft.com/Forums/en-US/fc85630e-5684-4df6-ad2f-5a128de3deef
if ($IsWindows) {
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
}

# Display termination message
eos
