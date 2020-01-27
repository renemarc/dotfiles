#
# PowerShell profile: aliases
#

if (! Test-Path variable:global:IsWindows) {
    Set-Variable IsWindows -Scope Global -Value ([System.Environment]::OSVersion.Platform -eq "Win32NT")
}


# Easier navigation
# -----------------------------------------------------------------------------

# Go to user home directory
function ~ { Set-Location $HOME }

# Go to last used directory
#function -- { Set-Location "-" }
function cd- { Set-Location "-" }

# Go up a directory
function .. { Set-Location ".." }

# Go up two directories
function ... { Set-Location "../.." }


# Go up three directories
function .... { Set-Location "../../.." }

# Go up four directories
function ..... { Set-Location "../../../.." }
function .4 { Set-Location "../../../.." }

# Go up five directories
function .5 { Set-Location "../../../../.." }


# Directory browsing
# -----------------------------------------------------------------------------

# List visible files in wide format
if (!(Get-Command 'ls' -ErrorAction "Ignore")) {
    function ls {
        Get-ChildItem . | Format-Wide
    }
}

# List visible files in long format
function l {
    Get-ChildItem . @args
}

# List all files files in long format, excluding `.` and `..`
function ll {
    Get-ChildItem . -Force @args
}

# List only directories in long format
function lsd {
    Get-ChildItem . -Directory @args
}

# List only hidden files in long format
function lsh {
    Get-ChildItem . -Hidden @args
}


# File management
# -----------------------------------------------------------------------------

# Copy a file securely
Set-Alias -Name "cpv" -Value "Copy-Item-Secure"

# Find directory
function fd {
    Get-ChildItem -Path . -Directory -Recurse -ErrorAction SilentlyContinue -Include @args
}

# Find file
function ff {
    Get-ChildItem -Path . -File -Recurse -ErrorAction SilentlyContinue -Include @args
}

# Mirror directories
Set-Alias -Name "mirror" -Value "Mirror-Path"


# General aliases
# -----------------------------------------------------------------------------

# Clear screen
Set-Alias -Name "c" -Value "Clear-Host"

# Display/Search global history
function h {
    Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -Like "*$args*"} | Get-Unique
}

# Display/Search session history
function hsession {
    Get-History | Where-Object {$_.CommandLine -like "*$args*"}
}

# Creates directory and change to it
Set-Alias -Name "mkcd" -Value New-Item-Set-Location
Set-Alias -Name "take" -Value New-Item-Set-Location

# Repeat a command `x` times
Set-Alias -Name "repeat" -Value "Repeat-Command"

# Reload the shell (i.e. invoke as a login shell)
#alias reload="exec ${SHELL} -l"

# Reload configuration
#alias resource='source ~/.bash_profile'


# Time
# -----------------------------------------------------------------------------

# Display local/UTC date and time in ISO-8601 format `YYYY-MM-DDThh:mm:ss`
function now {
    Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
}
function unow {
    (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
}

# Display local/UTC date in `YYYY-MM-DD` format
function nowdate {
    Get-Date -Format "yyyy-MM-dd"
}
function unowdate {
    (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd")
}

# Display local/UTC time in `hh:mm:ss` format
function nowtime {
    Get-Date -Format "HH:mm:ss"
}
function unowtime {
    (Get-Date).ToUniversalTime().ToString("HH:mm:ss")
}

# Display Unix time stamp
function timestamp {
    Get-Date -UFormat %s -Millisecond 0
}

# Get week number in ISO-9601 format `YYYY-Www`
function week {
    (Get-Date -UFormat %Y-W) + (Get-Date -UFormat %W).PadLeft(2,'0')
}

# Get weekday number
function weekday {
    Get-Date -UFormat %u
}


# Networking
# -----------------------------------------------------------------------------

# Ping 100 times without waiting 1 second between ECHO_REQUEST packets
#alias fastping='ping -c 100 -s.2'

# Flush the DNS cache
function flushdns {
    ipconfig /flushdns
}


# Show active network interfaces
#alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Get external IP address
function ip {
    Invoke-RestMethod http://ipinfo.io/json | Select -exp ip
}

# Get all IP addresse
function ips {
    Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred"} | Sort-object IPAddress | Format-Table -Wrap -AutoSize
}

# Get local IP address
function localip {
    $IPAddress = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.Ipaddress.length -gt 1}
    $IPAddress.ipaddress[0]
}

# Send HTTP requests
function GET {Invoke-RestMethod -Method GET @args}
function HEAD {Invoke-RestMethod -Method HEAD @args}
function POST {Invoke-RestMethod -Method POST @args}
function PUT {Invoke-RestMethod -Method PUT @args}
function DELETE {Invoke-RestMethod -Method DELETE @args}
function TRACE {Invoke-RestMethod -Method TRACE @args}
function OPTIONS {Invoke-RestMethod -Method OPTIONS @args}


# Power management
# -----------------------------------------------------------------------------

# Lock the session
function lock {
    Invoke-Command {rundll32.exe user32.dll,LockWorkStation}
}

# Go to sleep
function hibernate {
    shutdown.exe /h
}

# Restart the system
Set-Alias -Name "reboot" -Value Restart-Computer

# Shut down the system
Set-Alias -Name "poweroff" -Value Stop-Computer


# Sysadmin
# -----------------------------------------------------------------------------

# List drive mounts
# http://lifeofageekadmin.com/display-mount-points-drives-using-powershell/
function mnt {
    $Capacity = @{Name="Capacity(GB)";Expression={[math]::round(($_.Capacity/ 1073741824))}}
    $FreeSpace = @{Name="FreeSpace(GB)";Expression={[math]::round(($_.FreeSpace / 1073741824),1)}}
    $Usage = @{Name="Usage";Expression={-join([math]::round(100-((($_.FreeSpace / 1073741824)/($_.Capacity / 1073741824)) * 100),0),'%')};Alignment="Right"}

    if ($IsCoreCLR) {
        $volumes = Get-CimInstance -ClassName Win32_Volume
    }
    else {
        $volumes = Get-WmiObject Win32_Volume
    }
    $volumes | Where name -notlike \\?\Volume* | Format-Table DriveLetter, Label, FileSystem, $Capacity, $FreeSpace, $Usage, PageFilePresent, IndexingEnabled, Compressed
}

# Print each $PATH entry on a separate line
Set-Alias -Name "path" -Value "$ENV:PATH.split(';')"

# Keep all apps and packages up to date
Set-Alias -Name "update" -Value Update-Packages


# Applications
# -----------------------------------------------------------------------------

# Open file/URL (in) Browsers
function browse {
    start $args
}
function chrome {
    Start-Process "chrome" $args
}
function edge {
    Start microsoft-edge:$args
}
function firefox {
    Start-Process "firefox" $args
}
function iexplore {
    Start-Process "iexplore" $args
}
function opera {
    Start-Process "opera" $args
}
function safari {
    Start-Process "safari" $args
}

# Enter the Starship cross-shell prompt (https://starship.rs)
function ss {
    Invoke-Expression (&starship init powershell)
}

# Open (in) Sublime Text (https://www.sublimetext.com/)
Set-Alias -Name "subl" -Value "${Env:Programfiles}\Sublime Text 3\subl.exe"
Set-Alias -Name "st" -Value "${Env:Programfiles}\Sublime Text 3\subl.exe"


# Development
# -----------------------------------------------------------------------------

# Docker (https://www.docker.com/)
Set-Alias -Name "dk" -Value "${Env:Programfiles}\Docker\Docker\resources\bin\docker.exe"
Set-Alias -Name "dco" -Value "${Env:Programfiles}\Docker\Docker\resources\bin\docker-compose.exe"
#alias dwipe="docker kill $(docker ps -a -q) || docker rm $(docker ps -a -q) || docker ps -a"
#alias dockerstop='docker-compose stop'
#alias dockerup='docker-compose up -d'
#alias dockerrm='docker-compose rm --all'

# Git (https://git-scm.com/)
Set-Alias -Name "g" -Value "${Env:Programfiles}\Git\cmd\git.exe"

# Python: activate virtual environment (https://docs.python.org/3/tutorial/venv.html)
function va {
    . ./venv/bin/activate
}

# Python: create virtual environment
function ve {
    python3 -m venv ./venv
}


# macOS
# -----------------------------------------------------------------------------

if ($IsMacOS) {
    # Toggle display of desktop icons
    function hidedesktop {
        Invoke-Command 'defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
    }
    function showdesktop {
        Invoke-Command 'defaults write com.apple.finder CreateDesktop -bool true && killall Finder'
    }

    # Toggle hidden files in Finder
    function hidefiles {
        Invoke-Command 'defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder'
    }
    function showfiles {
        Invoke-Command 'defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'
    }

    # Toggle Spotlight
    function spotoff {
        Invoke-Command 'sudo mdutil -a -i off'
    }
    function spoton {
        Invoke-Command 'sudo mdutil -a -i on'
    }
}


# Windows
# -----------------------------------------------------------------------------

if ($IsWindows) {
    # Toggle hidden files in Explorer
    function hidefiles {
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
    }
    function showfiles {
        Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
    }

    # Host-level *nix equivalent to `which`
    if (!(Get-Command 'which' -ErrorAction "Ignore")) {
        function which($name) {
            Get-Command $name -ErrorAction SilentlyContinue
        }
    }
}


# Common paths
# -----------------------------------------------------------------------------

# User paths
function dl { Set-Location "${HOME}\Downloads" }
function docs { Set-Location "${HOME}\Documents" }
function dt { Set-Location "${HOME}\Desktop" }


# Configuration paths
# -----------------------------------------------------------------------------

# Go to Chezmoi's local repo
function chezmoiconf { Set-Location "${HOME}\.local\share\chezmoi"}

# Go to Sublime Text's local repo
if ($IsWindows) {
    function sublimeconf { Set-Location "${HOME}\AppData\Roaming\Sublime Text 3\Packages\User"}
}
elseif ($IsMacOS) {
    function sublimeconf { Set-Location "${HOME}\Library\Application Support\Sublime Text 3\Packages\User"}
}


# Custom paths
# -----------------------------------------------------------------------------

# Paths: Code
function archives { Set-Location "${HOME}\Archives" }
function repos { Set-Location "${HOME}\Code" }


# Varia
# -----------------------------------------------------------------------------
