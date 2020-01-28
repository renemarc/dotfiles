#
# PowerShell profile: aliases
#

# Create missing $IsWindows if running Powershell 5 or below
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


# General
# -----------------------------------------------------------------------------

# Clear screen
Set-Alias -Name "c" -Value "Clear-Host"

# Display/Search global history
function h {
    $pattern = '*' + $args + '*'
    Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -Like $pattern} | Get-Unique
}
del alias:h

# Display/Search session history
function hs {
    $pattern = '*' + $args + '*'
    Get-History | Where-Object {$_.CommandLine -like $pattern}
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
    if ($IsMacOS) {
        dscacheutil -flushcache
        sudo killall -HUP mDNSResponder
    }
    elseif ($IsLinux) {
        sudo /etc/init.d/dns-clean restart
    }
    else {
        ipconfig /flushdns
    }
    Write-Host "DNS cache flushed."
}

# Show active network interfaces
#alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Get external IP address
function ip {
    Invoke-RestMethod http://ipinfo.io/json | Select -exp ip
}

# Get all IP addresse
function ips {
    if ($IsWindows) {
        Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred"} | Sort-object IPAddress | Format-Table -Wrap -AutoSize
    }
    else {
        ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'
    }
}

# Get local IP address
function localip {
    if ($IsWindows) {
        $IPAddress = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.Ipaddress.length -gt 1}
        $IPAddress.ipaddress[0]
    }
    else {
        ipconfig getifaddr en0
    }
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
    if ($IsWindows) {
        Invoke-Command {rundll32.exe user32.dll,LockWorkStation}
    }
    elseif ($IsMacOS) {
        pmset displaysleepnow
    }
    elseif (Get-Command "vlock" -ErrorAction "Ignore") {
        vlock --all
    }
    elseif (Get-Command "gnome-screensaver-command" -ErrorAction "Ignore") {
        gnome-screensaver-command --lock
    }
}

# Go to sleep
function hibernate {
    if ($IsMacOS) {
        pmset sleep now
    }
    elseif ($IsLinux) {
        systemctl suspend
    }
    else {
        shutdown.exe /h
    }
}

# Restart the system
function reboot {
    if ($IsMacOS) {
        osascript -e 'tell application "System Events" to restart'
    }
    elseif ($IsLinux) {
        sudo /sbin/reboot
    }
    else {
        Restart-Computer
    }
}

# Shut down the system
function poweroff {
    if ($IsMacOS) {
        osascript -e 'tell application "System Events" to shut down'
    }
    elseif ($IsLinux) {
        sudo /sbin/poweroff
    }
    else {
        Stop-Computer
    }
}


# Sysadmin
# -----------------------------------------------------------------------------

# List drive mounts
# http://lifeofageekadmin.com/display-mount-points-drives-using-powershell/
function mnt {
    if ($IsMacOS) {
        mount | grep -E ^/dev | column -t
    }
    elseif ($IsLinux) {
        mount | awk -F" " "{ printf \"%s\t%s\n\",\$1,\$3; }" | column -t | egrep ^/dev/ | sort
    }
    else {
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
}

# Print each $PATH entry on a separate line
function path {
    $separator = ';'
    if (!$IsWindows) {
        $separator = ':'
    }
    ${ENV:PATH}.split($separator)
}

# Keep all apps and packages up to date
Set-Alias -Name "update" -Value Update-Packages


# Applications
# -----------------------------------------------------------------------------

# Open file/URL (in) Browsers
function browse {
    if ($IsWindows) {
        start $args
    }
    else {
        open $args
    }
}
function chrome {
    $process = "chrome"
    if ($IsMacOS) {
        $process = "/Applications/Firefox.app/Contents/MacOS/Firefox"
    }
    Start-Process $process $args
}
function edge {
    if ($IsMacOS) {
        $process = "/Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge"
        Start-Process $process $args
    }
    else {
        Start microsoft-edge:$args
    }
}
function firefox {
    $process = "firefox"
    if ($IsMacOS) {
        $process = "/Applications/Firefox.app/Contents/MacOS/Firefox"
    }
    Start-Process $process $args
}
function iexplore {
    Start-Process "iexplore" $args
}
function opera {
    $process = "opera"
    if ($IsMacOS) {
        $process = "/Applications/Opera.app/Contents/MacOS/Opera"
    }
    Start-Process $process $args
}
function safari {
    Start-Process "/Applications/Safari.app/Contents/MacOS/Safari" $args
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
function dk {
    $process = "docker"
    if ($IsWindows) {
        $process = "${Env:Programfiles}\Docker\Docker\resources\bin\docker.exe"
    }
    Invoke-Expression "$process $args"
}
function dco {
    $process = "docker-compose"
    if ($IsWindows) {
        $process = "${Env:Programfiles}\Docker\Docker\resources\bin\docker-compose.exe"
    }
    Invoke-Expression "$process $args"
}
#alias dwipe="docker kill $(docker ps -a -q) || docker rm $(docker ps -a -q) || docker ps -a"
#alias dockerstop='docker-compose stop'
#alias dockerup='docker-compose up -d'
#alias dockerrm='docker-compose rm --all'

# Git (https://git-scm.com/)
function g {
    $process = "git"
    if ($IsWindows) {
        $process = "${Env:Programfiles}\Git\cmd\git.exe"
    }
    Invoke-Expression "$process $args"
}

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
        Invoke-Expression 'defaults write com.apple.finder CreateDesktop -bool false; killall Finder'
    }
    function showdesktop {
        Invoke-Expression 'defaults write com.apple.finder CreateDesktop -bool true; killall Finder'
    }

    # Toggle hidden files in Finder
    function hidefiles {
        Invoke-Expression 'defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder'
    }
    function showfiles {
        Invoke-Expression 'defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder'
    }

    # Toggle Spotlight
    function spotoff {
        Invoke-Expression 'sudo mdutil -a -i off'
    }
    function spoton {
        Invoke-Expression 'sudo mdutil -a -i on'
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
