# -*-mode:powershell-*- vim:ft=powershell

# ~/.config/powershell/aliases.ps1
# =============================================================================
# PowerShell aliases sourced by `./profile.ps1`.
#
# On Windows, this file will be copied over to these locations after
# running `chezmoi apply` by the script `../../run_powershell.bat.tmpl`:
#     - %USERPROFILE%\Documents\PowerShell
#     - %USERPROFILE%\Documents\WindowsPowerShell
#
# Since PowerShell does not allow aliases to contain parameters, most of the
# logic is wrapped in `./functions.ps1`.

# Create missing $IsWindows if running Powershell 5 or below.
if (!(Test-Path variable:global:IsWindows)) {
    Set-Variable "IsWindows" -Scope "Global" -Value ([System.Environment]::OSVersion.Platform -eq "Win32NT")
}


# Easier navigation
# -----------------------------------------------------------------------------

Set-Alias -Name "~" -Value Set-LocationHome -Description "Goes to user home directory."

Set-Alias -Name "cd-" -Value Set-LocationLast -Description "Goes to last used directory."

Set-Alias -Name ".." -Value Set-LocationUp -Description "Goes up a directory."

Set-Alias -Name "..." -Value Set-LocationUp2 -Description "Goes up two directories."

Set-Alias -Name "...." -Value Set-LocationUp3 -Description "Goes up three directories."

Set-Alias -Name "....." -Value Set-LocationUp4 -Description "Goes up four directories."

Set-Alias -Name "......" -Value Set-LocationUp5 -Description "Goes up five directories."


# Directory browsing
# -----------------------------------------------------------------------------

if (!(Get-Command "ls" -ErrorAction "Ignore")) {
    Set-Alias -Name "ls" -Value Get-ChildItemSimple -Description "Lists visible files in wide format."
}

Set-Alias -Name "l" -Value Get-ChildItemVisible -Description "Lists visible files in long format."

Set-Alias -Name "ll" -Value Get-ChildItemAll -Description "Lists all files in long format."

Set-Alias -Name "lsd" -Value Get-ChildItemDirectory -Description "Lists only directories in long format."

Set-Alias -Name "lsh" -Value Get-ChildItemHidden -Description "Lists only hidden files in long format."


# File management
# -----------------------------------------------------------------------------

Set-Alias -Name "cpv" -Value Copy-ItemSecure -Description "Makes an exact copy of files."

Set-Alias -Name "fd" -Value Find-Directory -Description "Finds directories."

Set-Alias -Name "ff" -Value Find-File -Description "Finds files."

Set-Alias -Name "mirror" -Value Copy-ItemMirror -Description "Makes an exact copy of files and folders."

if (!(Get-Command "touch" -ErrorAction "Ignore")) {
    Set-Alias -Name "touch" -Value New-ItemEmpty -Description "Creates an empty file or updates its timestamp."
}


# General
# -----------------------------------------------------------------------------

Set-Alias -Name "alias" -Value Get-Aliases -Description "Lists aliases."

Set-Alias -Name "c" -Value Clear-Host -Description "Clears screen."

if (Test-Path alias:h) {
    Remove-Item alias:h
}
Set-Alias -Name "h" -Value "Search-History" -Description "Displays/Searches global history."

Set-Alias -Name "hs" -Value "Search-HistorySession" -Description "Displays/Searches session history."

Set-Alias -Name "mkcd" -Value New-ItemSetLocation -Description "Makes a directory and change to it."
Set-Alias -Name "take" -Value New-ItemSetLocation -Description "Makes a directory and change to it."

Set-Alias -Name "repeat" -Value Invoke-RepeatCommand -Description "Repeats a command x times."

#Set-Alias -Name "reload" -Value Start-Shell

#Set-Alias -Name "resource" -Value Import-Profile


# Time
# -----------------------------------------------------------------------------

Set-Alias -Name "now" -Value Get-DateExtended -Description "Displays local date and time in ISO-8601 format YYYY-MM-DDThh:mm:ss."

Set-Alias -Name "unow" -Value Get-DateExtendedUTC -Description "Displays UTC date and time in ISO-8601 format YYYY-MM-DDThh:mm:ss."

Set-Alias -Name "nowdate" -Value Get-CalendarDate -Description "Displays local date in YYYY-MM-DD format."

Set-Alias -Name "unowdate" -Value Get-CalendarDateUTC -Description "Displays UTC date in YYYY-MM-DD format."

Set-Alias -Name "nowtime" -Value Get-Time -Description "Displays local time in hh:mm:ss format."

Set-Alias -Name "unowtime" -Value Get-TimeUTC -Description "Displays UTC time in hh:mm:ss format."

Set-Alias -Name "timestamp" -Value Get-Timestamp -Description "Displays Unix time stamp."

Set-Alias -Name "week" -Value Get-WeekDate -Description "Displays week number in ISO-9601 format YYYY-Www."

Set-Alias -Name "weekday" -Value Get-Weekday -Description "Displays weekday number."


# Networking
# -----------------------------------------------------------------------------

if (Test-Path alias:fastping) {
    Remove-Item alias:fastping
}
Set-Alias -Name "fastping" -Value Invoke-FastPingSimple -Description "Pings hostname(s) 30 times in quick succession."

Set-Alias -Name "flushdns" -Value Clear-DNSCache -Description "Flushes the DNS cache."

Set-Alias -Name "ips" -Value Get-IPS -Description "Gets all IP addresses."

Set-Alias -Name "localip" -Value Get-LocalIP -Description "Gets local IP address."

Set-Alias -Name "publicip" -Value Get-PublicIP -Description "Gets external IP address."

Set-Alias -Name "GET" -Value Invoke-RestMethodGet -Description "Sends a GET http request."

Set-Alias -Name "HEAD" -Value Invoke-RestMethodHead -Description "Sends a HEAD http request."

Set-Alias -Name "POST" -Value Invoke-RestMethodPost -Description "Sends a POST http request."

Set-Alias -Name "PUT" -Value Invoke-RestMethodPut -Description "Sends a PUT http request."

Set-Alias -Name "DELETE" -Value Invoke-RestMethodDelete -Description "Sends a DELETE http request."

Set-Alias -Name "TRACE" -Value Invoke-RestMethodTrace -Description "Sends a TRACE http request."

Set-Alias -Name "OPTIONS" -Value Invoke-RestMethodOptions -Description "Sends an OPTIONS http request."


# Power management
# -----------------------------------------------------------------------------

Set-Alias -Name "lock" -Value Invoke-Lock -Description "Locks the session."

Set-Alias -Name "hibernate" -Value Invoke-Hibernate -Description "Goes to sleep."

Set-Alias -Name "reboot" -Value Invoke-Restart -Description "Restarts the system."

Set-Alias -Name "poweroff" -Value Invoke-PowerOff -Description "Shuts down the system."


# Sysadmin
# -----------------------------------------------------------------------------

Set-Alias -Name "mnt" -Value Get-Mounts -Description "Lists drive mounts."

Set-Alias -Name "path" -Value Get-Path -Description "Prints each PATH entry on a separate line."

foreach ($_ in ("ntop", "atop", "htop", "top", "Get-TopProcess")) {
    if (Get-Command $_ -ErrorAction "Ignore") {
        Set-Alias -Name "top" -Value $_ -Description "Monitors processes and system resources."
        break
    }
}

foreach ($_ in ("winfetch", "neofetch", "screenfetch")) {
    if (Get-Command $_ -ErrorAction "Ignore") {
        Set-Alias -Name "sysinfo" -Value $_ -Description "Displays information about the system."
        break
    }
}

Set-Alias -Name "update" -Value Update-Packages -Description "Keeps all apps and packages up to date."

if (!(Get-Command "which" -ErrorAction "Ignore")) {
    Set-Alias -Name "which" -Value Search-Command -Description "Locates a command."
}

# Applications
# -----------------------------------------------------------------------------

Set-Alias -Name "browse" -Value Start-Browser -Description "Opens file/URL in default browsers."

Set-Alias -Name "chrome" -Value Start-Chrome -Description "Opens in Google Chrome."

Set-Alias -Name "edge" -Value Start-Edge -Description "Opens in Microsoft Edge."

Set-Alias -Name "firefox" -Value Start-Firefox -Description "Opens in Mozilla Firefox."

Set-Alias -Name "iexplore" -Value Start-InternetExplorer -Description "Opens in Internet Explorer."

Set-Alias -Name "opera" -Value Start-Opera -Description "Opens in Opera."

Set-Alias -Name "safari" -Value Start-Safari -Description "Opens in Safari."

Set-Alias -Name "ss" -Value Enter-Starship -Description "Enters the Starship cross-shell prompt."

Set-Alias -Name "subl" -Value Start-SublimeText -Description "Opens in Sublime Text."
Set-Alias -Name "st" -Value Start-SublimeText -Description "Opens in Sublime Text."


# Development
# -----------------------------------------------------------------------------

Set-Alias -Name "dk" -Value Invoke-Docker -Description "Passthrough to the `docker` command."

Set-Alias -Name "dco" -Value Invoke-DockerCompose -Description "Passthrough to the `docker-compose` command."

Set-Alias -Name "g" -Value Invoke-Git -Description "Passthrough to the `git` command."

Set-Alias -Name "va" -Value Invoke-Venv -Description "Python: activates the virtual environment."

Set-Alias -Name "ve" -Value Initialize-Venv -Description "Python: creates the virtual environment."


# macOS
# -----------------------------------------------------------------------------

if ($IsMacOS) {
    Set-Alias -Name "hidedesktop" -Value Hide-DesktopIcons -Description "Hides desktop icons."

    Set-Alias -Name "showdesktop" -Value Show-DesktopIcons -Description "Shows desktop icons."

    Set-Alias -Name "hidefiles" -Value Hide-HiddenFiles -Description "Hides hidden files in Finder."

    Set-Alias -Name "showfiles" -Value Show-HiddenFiles -Description "Shows hidden files in Finder."

    Set-Alias -Name "spotoff" -Value Disable-Spotlight -Description "Disables Spotlight."

    Set-Alias -Name "spoton" -Value Enable-Spotlight -Description "Enables Spotlight."
}


# Windows
# -----------------------------------------------------------------------------

if ($IsWindows) {
    Set-Alias -Name "hidefiles" -Value Hide-HiddenFiles -Description "Hides hidden files in Explorer."

    Set-Alias -Name "showfiles" -Value Show-HiddenFiles -Description "Shows hidden files in Explorer."
}


# Common paths
# -----------------------------------------------------------------------------

Set-Alias -Name "dls" -Value Set-LocationDownloads -Description "Navigates to Downloads directory."

Set-Alias -Name "docs" -Value Set-LocationDocuments -Description "Navigates to Documents directory."

Set-Alias -Name "dt" -Value Set-LocationDesktop -Description "Navigates to Desktop directory."


# Configuration paths
# -----------------------------------------------------------------------------

Set-Alias -Name "chezmoiconf" -Value Set-LocationChezmoiConf -Description "Navigates to Chezmoi's local repo."

Set-Alias -Name "powershellconf" -Value Set-LocationPowershellConf -Description "Navigates to Powershell's profile location."

Set-Alias -Name "sublimeconf" -Value Set-LocationSublimeConf -Description "Navigates to Sublime Text's local repo."


# Custom paths
# -----------------------------------------------------------------------------

Set-Alias -Name "archives" -Value Set-LocationArchives -Description "Navigates to Archives directory."

Set-Alias -Name "repos" -Value Set-LocationCode -Description "Navigates to Code directory."


# Varia
# -----------------------------------------------------------------------------
foreach ($_ in ("Set-Clipboard", "Set-ClipboardText")) {
    if (Get-Command $_ -ErrorAction "Ignore") {
        Set-Alias -Name "cb" -Value $_ -Description "Copies contents to the clipboard."
        break
    }
}

foreach ($_ in ("Get-Clipboard", "Get-ClipboardText")) {
    if (Get-Command $_ -ErrorAction "Ignore") {
        Set-Alias -Name "cbpaste" -Value $_ -Description "Copies contents to the clipboard."
        break
    }
}

Set-Alias -Name "md5sum" -Value Get-FileHashMD5 -Description "Calculates the MD5 hash of an input."

Set-Alias -Name "sha1sum" -Value Get-FileHashSHA1 -Description "Calculates the SHA1 hash of an input."

Set-Alias -Name "sha256sum" -Value Get-FileHashSHA256 -Description "Calculates the SHA256 hash of an input."

Set-Alias -Name "forecast" -Value Get-WeatherForecast -Description "Displays detailed weather and forecast."

Set-Alias -Name "weather" -Value Get-WeatherCurrent -Description "Displays current weather."
