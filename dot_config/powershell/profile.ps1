#
# PowerShell profile
#

$ColorInfo = "DarkYellow"
$ColorWarn = "DarkRed"

# Import popular commands from Linux
if (Get-Command Import-WslCommand -errorAction Ignore) {
    $WslCommands = @(
        "chmod",
        "grep",
        "head",
        "less",
        "ls",
        "man",
        "ssh",
        "tail",
        "touch"
    )
    $WslImportedCommands = @()
    $WslDefaultParameterValues = @{
        grep = "-E";
        less = "-i";
        ls = "-AFhl --color=auto"
    }

    $WslCommands | foreach {
        wsl command -v $_ > null
        if ($?) {
            $WslImportedCommands += $_
            Import-WslCommand "$_"
        }
        else {
            $Global:Error.RemoveAt($Global:Error.Count - 1)
        }
    }
}

# Load split configuration for easier maintenance
Push-Location (Split-Path -parent $profile)
"functions","aliases","exports","extras" | Where-Object {Test-Path "$_.ps1"} | ForEach-Object -process {Invoke-Expression ". .\$_.ps1"}
Pop-Location

# Add missing user paths
if (Get-Command Add-EnvPath -errorAction Ignore) {
    if ($IsWindows) {
        Add-EnvPath -Path "${Env:Programfiles}\Docker\Docker\resources\bin\" -Position "Append"
        Add-EnvPath -Path "${Env:Programfiles}\Git\cmd\" -Position "Append"
        Add-EnvPath -Path "${Env:Programfiles}\Sublime Text 3" -Position "Append"
    }
    else {
        Add-EnvPath -Path "/usr/local/sbin" -Position "Prepend"
        Add-EnvPath -Path "/usr/local/bin" -Position "Prepend"
    }
}

# Setup a pretty development-oriented PowerShell prompt
$modules = (
    "posh-git",
    "oh-my-posh",
    "Terminal-Icons"
)
$modules | foreach {
    if (Get-Module -ListAvailable -Name $_) {
        Import-Module $_
    }
}
if (Get-Module -ListAvailable -Name "oh-my-posh") {
    Set-Theme Paradox
    $ThemeSettings.Colors.PromptBackgroundColor = "Blue"
    $DefaultUser = $Env:username
}

# Display if/which WSL Interop commands are imported
if ($WslImportedCommands) {
    Write-Host "Windows Subsystem for Linux (WSL) Interop enabled." -ForegroundColor $ColorInfo
    Write-Host "WSL commands available:`n`t$($WslImportedCommands | sort)" -ForegroundColor $ColorInfo
}
