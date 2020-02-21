# -*-mode:powershell-*- vim:ft=powershell

# ~/.config/powershell/profile.ps1
# =============================================================================
# PowerShell functions sourced by `./profile.ps1`.
#
# On Windows, this file will be copied over to these locations after
# running `chezmoi apply` by the script `../../run_powershell.bat.tmpl`:
#     - %USERPROFILE%\Documents\PowerShell
#     - %USERPROFILE%\Documents\WindowsPowerShell

# Create missing $IsWindows if running Powershell 5 or below.
if (!(Test-Path variable:global:IsWindows)) {
    Set-Variable "IsWindows" -Scope "Global" -Value ([System.Environment]::OSVersion.Platform -eq "Win32NT")
}

if ($null -eq (Get-Variable "ColorInfo" -ErrorAction "Ignore")) {
    Set-Variable -Name "ColorInfo" -Value "DarkYellow"
}


# Easier navigation
# -----------------------------------------------------------------------------

function Set-LocationHome {
    <#
    .SYNOPSIS
        Goes to user home directory.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = $HOME
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationLast {
    <#
    .SYNOPSIS
        Goes to last used directory.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        if (!(Test-Path variable:global:LocationHistoryForward)) {
            Set-Variable "LocationHistoryForward" -Scope "Global" -Value $false
        }
        if (!$LocationHistoryForward) {
            $path = "-"
        }
        else {
            $path = "+"
        }
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            if (!$LocationHistoryForward) {
                Set-Variable "LocationHistoryForward" -Scope "Global" -Value $true
            }
            else {
                Set-Variable "LocationHistoryForward" -Scope "Global" -Value $false
            }
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp {
    <#
    .SYNOPSIS
        Goes up a directory.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path ".."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp2 {
    <#
    .SYNOPSIS
        Goes up two directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp3 {
    <#
    .SYNOPSIS
        Goes up three directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp4 {
    <#
    .SYNOPSIS
        Goes up four directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationUp5 {
    <#
    .SYNOPSIS
        Goes up five directories.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "../../../../.."
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}


# Directory browsing
# -----------------------------------------------------------------------------

function Get-ChildItemSimple {
    <#
    .SYNOPSIS
        Lists visible files in wide format.
    .PARAMETER Path
        The directory to list from.
    .INPUTS
        System.String[]
    .OUTPUTS
        System.IO.FileInfo
        System.IO.DirectoryInfo
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string[]]$Path = ".",

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        # https://stackoverflow.com/a/33302472
        $hashtable = @{}
        if ($Params) {
            $Params | ForEach-Object {
                if ($_ -match "^-") {
                    $hashtable.$($_ -replace "^-") = $null
                }
                else {
                    $hashtable.$(([string[]]$hashtable.Keys)[-1]) = $_
                }
            }
        }
    }

    process {
        Get-ChildItem -Path @Path @hashtable | Format-Wide
    }
}

function Get-ChildItemVisible {
    <#
    .SYNOPSIS
        Lists visible files in long format.
    .PARAMETER Path
        The directory to list from.
    .INPUTS
        System.String[]
    .OUTPUTS
        System.IO.FileInfo
        System.IO.DirectoryInfo
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string[]]$Path = ".",

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        # https://stackoverflow.com/a/33302472
        $hashtable = @{}
        if ($Params) {
            $Params | ForEach-Object {
                if ($_ -match "^-") {
                    $hashtable.$($_ -replace "^-") = $null
                }
                else {
                    $hashtable.$(([string[]]$hashtable.Keys)[-1]) = $_
                }
            }
        }
    }

    process {
        Get-ChildItem -Path @Path @hashtable
    }
}

function Get-ChildItemAll {
    <#
    .SYNOPSIS
        Lists all files in long format, excluding `.` and `..`.
    .PARAMETER Path
        The directory to list from.
    .INPUTS
        System.String[]
    .OUTPUTS
        System.IO.FileInfo
        System.IO.DirectoryInfo
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string[]]$Path = ".",

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        # https://stackoverflow.com/a/33302472
        $hashtable = @{}
        if ($Params) {
            $Params | ForEach-Object {
                if ($_ -match "^-") {
                    $hashtable.$($_ -replace "^-") = $null
                }
                else {
                    $hashtable.$(([string[]]$hashtable.Keys)[-1]) = $_
                }
            }
        }
    }

    process {
        Get-ChildItem -Path @Path -Force @hashtable
    }
}

function Get-ChildItemDirectory {
    <#
    .SYNOPSIS
        Lists only directories in long format.
    .PARAMETER Path
        The directory to list from.
    .INPUTS
        System.String[]
    .OUTPUTS
        System.IO.FileInfo
        System.IO.DirectoryInfo
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string[]]$Path = ".",

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        # https://stackoverflow.com/a/33302472
        $hashtable = @{}
        if ($Params) {
            $Params | ForEach-Object {
                if ($_ -match "^-") {
                    $hashtable.$($_ -replace "^-") = $null
                }
                else {
                    $hashtable.$(([string[]]$hashtable.Keys)[-1]) = $_
                }
            }
        }
    }

    process {
        Get-ChildItem -Path @Path -Directory @hashtable
    }
}

function Get-ChildItemHidden {
    <#
    .SYNOPSIS
        Lists only hidden files in long format.
    .PARAMETER Path
        The directory to list from.
    .INPUTS
        System.String[]
    .OUTPUTS
        System.IO.FileInfo
        System.IO.DirectoryInfo
    .LINK
        Get-ChildItem
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string[]]$Path = ".",

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        # https://stackoverflow.com/a/33302472
        $hashtable = @{}
        if ($Params) {
            $Params | ForEach-Object {
                if ($_ -match "^-") {
                    $hashtable.$($_ -replace "^-") = $null
                }
                else {
                    $hashtable.$(([string[]]$hashtable.Keys)[-1]) = $_
                }
            }
        }
    }

    process {
        Get-ChildItem -Path @Path -Hidden @hashtable
    }
}


# File management
# -----------------------------------------------------------------------------

function Copy-ItemSecure {
    <#
    .SYNOPSIS
        Makes an exact copy of files.
    .DESCRIPTION
        Creates a copy of source files onto a local or network destination.
    .PARAMETER Source
        The source directory. This can be an absolute or relative path.
    .PARAMETER Destination
        The destination directory. It will be created if needed. This can be an
        absolute or relative path.
    .PARAMETER Flags
        Extra ROBOCOPY parameters.
    .EXAMPLE
        Copy-Item-Secure file.txt .\Destination\
    .EXAMPLE
        Copy-Item-Secure .\Source\*.zip .\Destination\
    .EXAMPLE
        Copy-Item-Secure file.txt .\Destination\ /TIMFIX
    .INPUTS
        System.Object
    .OUTPUTS
        None
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$Source,

        [Parameter(Mandatory=$true)]
        [string]$Destination
    )

    $SourcePath = Split-Path -Path $Source
    if (!$SourcePath) {
        $SourcePath = '.'
    }
    $File = Split-Path -Path $Source -Leaf

    robocopy /COPY:DAT /DCOPY:DAT /LEV:0 /R:1000000 /W:30 $SourcePath $Destination $File
}

function Find-Directory {
    <#
    .SYNOPSIS
        Finds directories.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    Get-ChildItem -Path . -Directory -Name -Recurse -ErrorAction SilentlyContinue -Include @args
}

function Find-File {
    <#
    .SYNOPSIS
        Finds files.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
    .LINK
        Get-ChildItem
    #>
    Get-ChildItem -Path . -File -Name -Recurse -ErrorAction SilentlyContinue -Include @args
}

# Mirror directories
function Copy-ItemMirror {
    <#
    .SYNOPSIS
        Makes an exact copy of files and folders.
    .DESCRIPTION
        Creates a mirror of a source directory onto a local or network
        destination. Files currently existing at destination but not present
        in the source will be deleted.
    .PARAMETER Source
        The source directory. This can be an absolute or relative path.
    .PARAMETER Destination
        The destination directory. It will be created if needed. This can be an
        absolute or relative path.
    .PARAMETER Files
        File(s) to copy (names/wildcards: default is "*.*").
    .PARAMETER Flags
        Extra ROBOCOPY parameters.
    .EXAMPLE
        Mirror-Path .\Source\ .\Destination\
    .EXAMPLE
        Mirror-Path .\Source\ .\Destination\ *.txt
    .EXAMPLE
        Mirror-Path .\Source\ .\Destination\ *.* /XD:ExcludedDirs
    .INPUTS
        System.Object
    .OUTPUTS
        None
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$Source,

        [Parameter(Mandatory=$true)]
        [string]$Destination,

        [Parameter()]
        [string]$Files = "*.*",

        [Parameter()]
        [string]$Flags
    )

    robocopy /MIR /COPY:DAT /DCOPY:DAT /R:1000000 /W:30 $Source $Destination $Files $Flags
}

function New-ItemEmpty {
    <#
    .SYNOPSIS
        Creates an empty file or updates its timestamp.
    .Description
        Host-level *nix equivalent to `touch`.
    .INPUTS
        System.Object
    .OUTPUTS
        None
    .LINK
        New-Item
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$File
    )

    if (Test-Path $File) {
        (Get-ChildItem $File).LastWriteTime = Get-Date
    }
    else {
        New-Item -ItemType File $File
    }
}


# General
# -----------------------------------------------------------------------------

function Get-Aliases {
    <#
    .SYNOPSIS
        Lists aliases.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.Internal.Format
    .LINK
        Get-Alias
    #>
    Get-Alias | Format-Table Name,ResolvedCommandName,Description,HelpUri
}

function Search-History {
    <#
    .SYNOPSIS
        Displays/Searches global history.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
    .LINK
        Get-Content
    #>
    $pattern = '*' + $args + '*'
    Get-Content (Get-PSReadlineOption).HistorySavePath | ? {$_ -Like $pattern} | Get-Unique
}

function Search-HistorySession {
    <#
    .SYNOPSIS
        Displays/Searches session history.
    .INPUTS
        System.Object
    .OUTPUTS
        System.String
        System.Object
    .LINK
        Get-History
    #>
    $pattern = '*' + $args + '*'
    Get-History | Where-Object {$_.CommandLine -like $pattern}
}

function New-ItemSetLocation {
    <#
    .SYNOPSIS
        Makes a directory and changes to it.
    .DESCRIPTION
        Creates a directory (if it doesn't already exist) and navigates to it.
    .PARAMETER Path
        The directory to switch to.
    .EXAMPLE
        New-Item-Set-Location .\New-Folder\
    .EXAMPLE
        New-Item-Set-Location .\Existing-Folder\
    .INPUTS
        System.Object
    .OUTPUTS
        None
    .LINK
        New-Item
    .LINK
        Get-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$Path
    )

    if (!(Test-Path -path $Path)) {
        if ($PSCmdlet.ShouldProcess($Path, 'Create directory')) {
            New-Item -ItemType Directory -Path $Path
            Write-Verbose "Path $Path created."
        }
    }

    if ($PSCmdlet.ShouldProcess($Path, 'Go to directory')) {
        Write-Verbose "Navigating to $Path"
        Set-Location -Path $Path -PassThru
    }
}

function Invoke-RepeatCommand {
    <#
    .SYNOPSIS
        Repeats a command `x` times.
    .DESCRIPTION
        Allows issuing a command multiple times in a row.
    .PARAMETER Count
        The max number of times to repeat a command.
    .PARAMETER Command
        The command to run. Can include spaces and arguments.
    .EXAMPLE
        Repeat-Command 5 echo hello world
    .INPUTS
        System.String
    .OUTPUTS
        None
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [int]$Count,

        [Parameter(Mandatory=$true)]
        $Command,

        [Parameter(ValueFromRemainingArguments=$true)]
        $Params
    )

    begin {
        $Params = $Params -join ' '
    }

    process {
        for ($i=1; $i -le $Count; $i++) {
            if ($Params) {
                &$Command $Params
            }
            else {
                &$Command
            }
        }
    }
}


# Time
# -----------------------------------------------------------------------------

function Get-DateExtended {
    <#
    .SYNOPSIS
        Display local date and time in ISO-8601 format `YYYY-MM-DDThh:mm:ss`.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://e.wikipedia.org/wiki/ISO_8601
    #>
    Get-Date -Format "yyyy-MM-ddTHH:mm:ss"
}

function Get-DateExtendedUTC {
    <#
    .SYNOPSIS
        Display UTC date and time in ISO-8601 format `YYYY-MM-DDThh:mm:ss`.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ss")
}

function Get-CalendarDate {
    <#
    .SYNOPSIS
        Displays local date in `YYYY-MM-DD` format.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    Get-Date -Format "yyyy-MM-dd"
}

function Get-CalendarDateUTC {
    <#
    .SYNOPSIS
        Displays UTC date in `YYYY-MM-DD` format.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd")
}

function Get-Time {
    <#
    .SYNOPSIS
        Displays local time in `hh:mm:ss` format.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    Get-Date -Format "HH:mm:ss"
}

function Get-TimeUTC {
    <#
    .SYNOPSIS
        Displays UTC time in `hh:mm:ss` format.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    (Get-Date).ToUniversalTime().ToString("HH:mm:ss")
}

function Get-Timestamp {
    <#
    .SYNOPSIS
        Display Unix time stamp.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    #>
    Get-Date -UFormat %s -Millisecond 0
}

function Get-WeekDate {
    <#
    .SYNOPSIS
        Displays week number in ISO-9601 format `YYYY-Www`.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    (Get-Date -UFormat %Y-W) + (Get-Date -UFormat %W).PadLeft(2,'0')
}

function Get-Weekday {
    <#
    .SYNOPSIS
        Displays weekday number.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        Get-Date
    .LINK
        https://en.wikipedia.org/wiki/ISO_8601
    #>
    Get-Date -UFormat %u
}


# Networking
# -----------------------------------------------------------------------------

#TODO: re-connect this erased function.
function Invoke-FastPingSimple {
    <#
    .SYNOPSIS
        Pings hostname(s) 30 times in quick succession.
    .INPUTS
        None
    .OUTPUTS
        System.String
    #>
    [CmdletBinding()]
    param()
}

function Clear-DNSCache {
    <#
    .SYNOPSIS
        Flushes the DNS cache.
    .INPUTS
        None
    .OUTPUTS
        System.String
    #>
    [CmdletBinding()]
    param()

    if ($IsLinux) {
        sudo /etc/init.d/dns-clean restart
    }
    elseif ($IsMacOS) {
        dscacheutil -flushcache
        sudo killall -HUP mDNSResponder
    }
    else {
        ipconfig /flushdns
    }
    Write-Information "DNS cache flushed."
}

function Get-IPS {
    <#
    .SYNOPSIS
        Gets all IP addresses.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.Internal.Format
        System.String[]
    .LINK
        Get-NetIPAddress
    #>
    if ($IsWindows) {
        Get-NetIPAddress | Where-Object {$_.AddressState -eq "Preferred"} | Sort-object IPAddress | Format-Table -Wrap -AutoSize
    }
    else {
        ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'
    }
}

function Get-LocalIP {
    <#
    .SYNOPSIS
        Gets local IP address.
    .INPUTS
        None
    .OUTPUTS
        System.String
        Object
    #>
    if ($IsWindows) {
        $IPAddress = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object {$_.Ipaddress.length -gt 1}
        $IPAddress.ipaddress[0]
    }
    else {
        ipconfig getifaddr en0
    }
}

function Get-PublicIP {
    <#
    .SYNOPSIS
        Gets external IP address.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.MatchInfo
        System.Boolean
        System.String
    .LINK
        Invoke-RestMethod
    .LINK
        https://github.com/chubin/awesome-console-services
    #>
    Invoke-RestMethod http://ipinfo.io/json | Select -exp ip
}

function Invoke-RestMethodGet {
    <#
    .SYNOPSIS
        Sends a GET http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method GET @args
}

function Invoke-RestMethodHead {
    <#
    .SYNOPSIS
        Sends a HEAD http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method HEAD @args
}

function Invoke-RestMethodPost {
    <#
    .SYNOPSIS
        Sends a POST http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method POST @args
}

function Invoke-RestMethodPut {
    <#
    .SYNOPSIS
        Sends a PUT http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method PUT @args
}

function Invoke-RestMethodDelete {
    <#
    .SYNOPSIS
        Sends a DELETE http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method DELETE @args
}

function Invoke-RestMethodTrace {
    <#
    .SYNOPSIS
        Sends a TRACE http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Object
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method TRACE @args
}

function Invoke-RestMethodOptions {
    <#
    .SYNOPSIS
        Sends an OPTIONS http request.
    .INPUTS
        System.Object
    .OUTPUTS
        System.Int64
        System.String
        System.Xml.XmlDocument
        PSObject
    .LINK
        Invoke-RestMethod
    #>
    Invoke-RestMethod -Method OPTIONS @args
}


# Power management
# -----------------------------------------------------------------------------

function Invoke-Lock {
    <#
    .SYNOPSIS
        Locks the session.
    .PARAMETER Force
        Do not prompt for confirmation.
    .INPUTS
        None
    .OUTPUTS
        None
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Medium'
    )]
    param(
        [switch]$Force
    )

    if ($Force -or $PSCmdlet.ShouldContinue("Are you sure you want to do this?", "Lock the session.")) {

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
}

function Invoke-Hibernate {
    <#
    .SYNOPSIS
        Goes to sleep.
    .PARAMETER Force
        Do not prompt for confirmation.
    .INPUTS
        None
    .OUTPUTS
        None
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Medium'
    )]
    param(
        [switch]$Force
    )

    if ($Force -or $PSCmdlet.ShouldContinue("Are you sure you want to do this?", "Send the system to sleep.")) {
        if ($IsLinux) {
            systemctl suspend
        }
        elseif ($IsMacOS) {
            pmset sleep now
        }
        else {
            shutdown.exe /h
        }
    }
}

function Invoke-Restart {
    <#
    .SYNOPSIS
        Restarts the system.
    .PARAMETER Force
        Do not prompt for confirmation.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Restart-Computer
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Medium'
    )]
    param(
        [switch]$Force
    )

    if ($Force -or $PSCmdlet.ShouldContinue("Are you sure you want to do this?", "Restart the system.")) {
        if ($IsLinux) {
            sudo /sbin/reboot
        }
        elseif ($IsMacOS) {
            osascript -e 'tell application "System Events" to restart'
        }
        else {
            Restart-Computer
        }
    }
}

function Invoke-PowerOff {
    <#
    .SYNOPSIS
        Shuts down the system.
    .PARAMETER Force
        Do not prompt for confirmation.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Stop-Computer
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Medium'
    )]
    param(
        [switch]$Force
    )

    if ($Force -or $PSCmdlet.ShouldContinue("Are you sure you want to do this?", "Shut down the system.")) {
        if ($IsLinux) {
            sudo /sbin/poweroff
        }
        elseif ($IsMacOS) {
            osascript -e 'tell application "System Events" to shut down'
        }
        else {
            Stop-Computer
        }
    }
}


# Sysadmin
# -----------------------------------------------------------------------------

function Add-EnvPath {
    <#
    .SYNOPSIS
        Adds a path to the global path list.
    .DESCRIPTION
        Allows adding a new path to the beginning of end of the path list,
        whether it be for the session (default), the user or the machine.
    .PARAMETER Path
        The path to add.
    .PARAMETER Container
        The persistence of the path's inclusion: "Session", "User", or "Machine".
    .PARAMETER Position
        "Append" (default) or "Prepend" the new path.
    .EXAMPLE
        Add-EnvPath -Path /usr/local/bin -Container User -Position Prepend
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://gist.github.com/mkropat/c1226e0cc2ca941b23a9
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [ValidateSet('Machine', 'User', 'Session')]
        [string]$Container = 'Session',

        [ValidateSet('Append', 'Prepend')]
        [string]$Position = 'Append'
    )

    begin {
        $separator = ';'
        if (!$IsWindows) {
            $separator = ':'
        }
    }

    process {
        if ($Container -ne 'Session') {
            $containerMapping = @{
                Machine = [EnvironmentVariableTarget]::Machine
                User = [EnvironmentVariableTarget]::User
            }
            $containerType = $containerMapping[$Container]

            $persistedPaths = [Environment]::GetEnvironmentVariable('Path', $containerType) -Split $separator
            if ($persistedPaths -NotContains $Path) {
                if ($Position -eq 'Append') {
                    $persistedPaths = $persistedPaths + $Path | Where { $_ }
                }
                else {
                    $persistedPaths = @($Path | Where { $_ }) + $persistedPaths
                }
                [Environment]::SetEnvironmentVariable('Path', $persistedPaths -Join ';', $containerType)
            }
        }

        $envPaths = $env:PATH -Split $separator
        if ($envPaths -NotContains $Path) {
            if ($Position -eq 'Append') {
                $envPaths = $envPaths + $Path | Where { $_ }
            }
            else {
                $envPaths = @($Path | Where { $_ }) + $envPaths
            }
            $env:PATH = $envPaths -Join $separator
        }
    }
}

function Get-Mounts {
    <#
    .SYNOPSIS
        Lists drive mounts.
    .INPUTS
        None
    .OUTPUTS
        Microsoft.PowerShell.Commands.Internal.Format
        System.String
    .LINK
        http://lifeofageekadmin.com/display-mount-points-drives-using-powershell/
    #>
    [CmdletBinding()]
    param()

    if ($IsLinux) {
        mount | awk -F" " "{ printf \"%s\t%s\n\",\$1,\$3; }" | column -t | egrep ^/dev/ | sort
    }
    elseif ($IsMacOS) {
        mount | grep -E ^/dev | column -t
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

function Get-Path {
    <#
    .SYNOPSIS
        Prints each PATH entry on a separate lines.
    .INPUTS
        None
    .OUTPUTS
        System.String[]
    #>
    begin {
        $separator = ';'
        if (!$IsWindows) {
            $separator = ':'
        }
    }

    process {
        ${Env:PATH}.split($separator)
    }
}

function Get-TopProcess {
    <#
    .SYNOPSIS
        Monitors processes and system resource..
    .INPUTS
        None
    .OUTPUTS
        System.Object
    #>
    while ($true) {
        Clear-Host
        # Sort by Working Set size.
        Get-Process | Sort-Object -Descending "WS" | Select-Object -First 30 | Format-Table -Autosize
        Start-Sleep -Seconds 2
    }
}

function Update-Packages {
    <#
    .SYNOPSIS
        Keeps all apps and packages up to date.
    .DESCRIPTION
        Looks for updates for system modules and help, then proceeds to
        updating any packages by these optional managers: Chocolatey, Choco,
        npm, RubyGems.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Update-Module
    .LINK
        Update-Help
    .LINK
        https://chocolatey.org/
    .LINK
        https://scoop.sh/
    .LINK
        https://www.npmjs.com/
    .LINK
        https://rubygems.org/
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='High'
    )]
    param()

    Write-Host "Looks for updates for system modules and help, then proceeds to updating any packages by these optional managers: Chocolatey, Choco, npm, RubyGems."

    if ($PSCmdlet.ShouldProcess("System modules", "Update")) {
        Write-Host "Updating system modules..." -ForegroundColor $ColorInfo
        Update-Module
    }

    if ($PSCmdlet.ShouldProcess("Help files", "Update")) {
        Write-Host "Updating help files..." -ForegroundColor $ColorInfo
        Update-Help -Force
    }

    if (Get-Command 'choco' -ErrorAction "Ignore") {
        if ($PSCmdlet.ShouldProcess("Chocolatey packages", "Update")) {
            Write-Host "Updating packages with Chocolatey..." -ForegroundColor $ColorInfo
            choco upgrade all
        }
    }

    if (Get-Command 'scoop' -ErrorAction "Ignore") {
        if ($PSCmdlet.ShouldProcess("Scoop packages", "Update")) {
            Write-Host "Updating packages with Scoop..." -ForegroundColor $ColorInfo
            scoop update *
            scoop cleanup *
        }
    }

    if (Get-Command 'npm' -ErrorAction "Ignore") {
        if ($PSCmdlet.ShouldProcess("Node.js packages", "Update")) {
            Write-Host "Updating Node.js packages with npm..." -ForegroundColor $ColorInfo
            # npm install npm -g
            npm update -g
        }
    }

    if (Get-Command 'gem' -ErrorAction "Ignore") {
        if ($PSCmdlet.ShouldProcess("Ruby gems", "Update")) {
            Write-Host "Updating Ruby gems..." -ForegroundColor $ColorInfo
            gem update --system
            gem update
            gem cleanup
        }
    }

    Write-Host "Done!"
}

function Search-Command {
    <#
    .SYNOPSIS
        Locates a command.
    .Description
        Host-level *nix equivalent to `which`.
    .INPUTS
        System.String
    .OUTPUTS
        System.Management.Automation.CommandInfo
        System.Management.Automation.AliasInfo
        System.Management.Automation.ApplicationInfo
        System.Management.Automation.FunctionInfo
        System.Management.Automation.CmdletInfo
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            ValueFromPipeline=$true
        )]
        [string]$Command
    )

    Get-Command $Command -ErrorAction SilentlyContinue
}


# Applications
# -----------------------------------------------------------------------------

function Start-Browser {
    <#
    .SYNOPSIS
        Opens file/URL in default browsers.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/start
    .LINK
        https://scriptingosx.com/2017/02/the-macos-open-command/
    #>
    if ($IsWindows) {
        start $args
    }
    else {
        open $args
    }
}

function Start-Chrome {
    <#
    .SYNOPSIS
        Opens in Google Chrome.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.google.com/chrome/
    #>
    $process = "chrome"
    if ($IsMacOS) {
        $process = "/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
    }
    Start-Process $process $args
}

function Start-Edge {
    <#
    .SYNOPSIS
        Opens in Microsoft Edge.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.microsoft.com/en-us/windows/microsoft-edge
    #>
    if ($IsMacOS) {
        $process = "/Applications/Microsoft\ Edge.app/Contents/MacOS/Microsoft\ Edge"
        Start-Process $process $args
    }
    else {
        Start microsoft-edge:$args
    }
}

function Start-Firefox {
    <#
    .SYNOPSIS
        Opens in Mozilla Firefox.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.mozilla.org/firefox/
    #>
    $process = "firefox"
    if ($IsMacOS) {
        $process = "/Applications/Firefox.app/Contents/MacOS/Firefox"
    }
    Start-Process $process $args
}

function Start-InternetExplorer {
    <#
    .SYNOPSIS
        Opens in Internet Explorer.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.microsoft.com/ie/
    #>
    Start-Process "iexplore" $args
}

function Start-Opera {
    <#
    .SYNOPSIS
        Opens in Opera.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.opera.com/
    #>
    $process = "opera"
    if ($IsMacOS) {
        $process = "/Applications/Opera.app/Contents/MacOS/Opera"
    }
    Start-Process $process $args
}

function Start-Safari {
    <#
    .SYNOPSIS
        Opens in Safari.
    .INPUTS
        System.String
    .OUTPUTS
        None
    .LINK
        https://www.apple.com/safari/
    #>
    Start-Process "/Applications/Safari.app/Contents/MacOS/Safari" $args
}

function Enter-Starship {
    <#
    .SYNOPSIS
        Enters the Starship cross-shell prompt.
    .DESCRIPTION
        Calls the `starship` command, enabling its universal prompt.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://starship.rs/
    #>
    Invoke-Expression (&starship init powershell)
}

function Start-SublimeText {
    <#
    .SYNOPSIS
        Opens in Sublime Text.
    .DESCRIPTION
        Calls the `sublime` command, and locates it on Windows if it isn't in the Path.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://www.sublimetext.com/
    #>
    $process = "sublime"
    if ($IsWindows) {
        $process = "subl"
    }
    Invoke-Expression "& '$process' $args"
}


# Development
# -----------------------------------------------------------------------------

function Invoke-Docker {
    <#
    .SYNOPSIS
        Passthrough to the `docker` command.
    .DESCRIPTION
        Calls the `docker` command and passes it any supplied arguments.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://www.docker.com/
    #>
    $process = "docker"
    Invoke-Expression "$process $args"
}

function Invoke-DockerCompose {
    <#
    .SYNOPSIS
        Passthrough to the `docker-compose` command.
    .DESCRIPTION
        Calls the `docker-compose` command and passes it any supplied arguments.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://www.docker.com/
    #>
    $process = "docker-compose"
    Invoke-Expression "$process $args"
}

function Invoke-Git {
    <#
    .SYNOPSIS
        Passthrough to the `git` command.
    .DESCRIPTION
        Calls the `git` command and passes it any supplied arguments.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://git-scm.com/
    #>
    $process = "git"
    &$process $args
}

function Invoke-Venv {
    <#
    .SYNOPSIS
        Python: activates the virtual environment.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://docs.python.org/3/tutorial/venv.html
    #>
    $paths = (
        "./.venv/bin/activate",
        "./venv/bin/activate"
    )
    foreach ($_ in $paths) {
        if (Test-Path $_) {
            . $_
            break
        }
    }
}

function Initialize-Venv {
    <#
    .SYNOPSIS
        Python: creates the virtual environment.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://docs.python.org/3/tutorial/venv.html
    #>
    python3 -m venv ./venv
}


# macOS
# -----------------------------------------------------------------------------

if ($IsMacOS) {
    function Hide-DesktopIcons {
        <#
        .SYNOPSIS
            Hides desktop icons.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://www.defaults-write.com/os-x-how-to-quickly-hide-the-desktop-icons/
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("All desktop icons", "Hide")) {
            Invoke-Expression 'defaults write com.apple.finder CreateDesktop -bool false; killall Finder'
            Write-Verbose "Desktop icons are now hidden"
        }
    }

    function Show-DesktopIcons {
        <#
        .SYNOPSIS
            Shows desktop icons.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://www.defaults-write.com/os-x-how-to-quickly-hide-the-desktop-icons/
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("All desktop icons", "Show")) {
            Invoke-Expression 'defaults write com.apple.finder CreateDesktop -bool true; killall Finder'
            Write-Verbose "Desktop icons are now visible"
        }
    }

    function Hide-HiddenFiles {
        <#
        .SYNOPSIS
            Hides hidden files in Finder.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://www.defaults-write.com/show-hidden-files-in-os-x-finder/
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Hidden files", "Are you sure that you want to hide these files from the Finder?")) {
            Invoke-Expression 'defaults write com.apple.finder AppleShowAllFiles -bool false; killall Finder'
            Write-Verbose "Hidden files are now hidden in the Finder"
        }
    }

    function Show-HiddenFiles {
        <#
        .SYNOPSIS
            Shows hidden files in Finder.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://www.defaults-write.com/show-hidden-files-in-os-x-finder/
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Hidden files", "Are you sure that you want to display these files from the Finder?")) {
            Invoke-Expression 'defaults write com.apple.finder AppleShowAllFiles -bool true; killall Finder'
            Write-Verbose "Hidden files are now visible in the Finder"
        }
    }

    function Disable-Spotlight {
        <#
        .SYNOPSIS
            Disables Spotlight.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://discussions.apple.com/message/32354266#message32354266
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Spotlight search system", "Are you sure you want to disable Spotlight?")) {
            Invoke-Expression 'sudo mdutil -a -i off'
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
            Write-Verbose "Hidden files are now hidden in Explorer"
        }
    }

    function Enable-Spotlight {
        <#
        .SYNOPSIS
            Enables Spotlight.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://discussions.apple.com/message/32354266#message32354266
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Spotlight search system", "Are you sure you want to enable Spotlight?")) {
            Invoke-Expression 'sudo mdutil -a -i on'
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
            Write-Verbose "Hidden files are now hidden in Explorer"
        }
    }
}


# Windows
# -----------------------------------------------------------------------------

if ($IsWindows) {
    function Hide-HiddenFiles {
        <#
        .SYNOPSIS
            Hides hidden files in Explorer.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://ss64.com/nt/syntax-reghacks.html
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Hidden files", "Are you sure that you want to hide these files from Explorer?")) {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
            Write-Verbose "Hidden files are now hidden in Explorer"
        }
    }

    function Show-HiddenFiles {
        <#
        .SYNOPSIS
            Shows hidden files in Explorer.
        .INPUTS
            None
        .OUTPUTS
            None
        .LINK
            https://ss64.com/nt/syntax-reghacks.html
        #>
        [CmdletBinding(
            SupportsShouldProcess=$true,
            ConfirmImpact='Low'
        )]
        param()

        if ($PSCmdlet.ShouldProcess("Hidden files", "Are you sure that you want to display these files from Explorer?")) {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
            Write-Verbose "Hidden files are now visible in Explorer"
        }
    }
}


# Common paths
# -----------------------------------------------------------------------------

function Set-LocationDownloads {
    <#
    .SYNOPSIS
        Navigates to Downloads directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\Downloads"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationDocuments {
    <#
    .SYNOPSIS
        Navigates to Documents directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\Documents"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationDesktop {
    <#
    .SYNOPSIS
        Navigates to Desktop directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\Desktop"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}


# Configuration paths
# -----------------------------------------------------------------------------

function Set-LocationChezmoiConf {
    <#
    .SYNOPSIS
        Navigates to Chezmoi's local repo.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://www.chezmoi.io/docs/quick-start/
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        if (Get-Command chezmoi -ErrorAction SilentlyContinue) {
            $path = "$(chezmoi source-path)"
        }
        else {
            $path = "${HOME}\.local\share\chezmoi"
        }
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationPowershellConf {
    <#
    .SYNOPSIS
        Navigates to Powershell's profile location.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://devblogs.microsoft.com/scripting/understanding-the-six-powershell-profiles/
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Split-Path -Path $Profile
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationSublimeConf {
    <#
    .SYNOPSIS
        Navigates to Sublime Text's local repo.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        https://www.sublimetext.com/docs/3/revert.html
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        if ($IsLinux) {
            $path = "${HOME}/.config/sublime-text-3/Packages/User"
        }
        elseif ($IsMacOS) {
            $path = "${HOME}/Library/Application Support/Sublime Text 3/Packages/User"
        }
        else {
            $path = "${Env:AppData}\Sublime Text 3\Packages\User"
        }
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}


# Custom paths
# -----------------------------------------------------------------------------

function Set-LocationArchives {
    <#
    .SYNOPSIS
        Navigates to Archives directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\Archives"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}

function Set-LocationCode {
    <#
    .SYNOPSIS
        Navigates to Code directory.
    .INPUTS
        None
    .OUTPUTS
        None
    .LINK
        Set-Location
    #>
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact='Low'
    )]
    param()

    begin {
        $path = Convert-Path -Path "${HOME}\Code"
        Write-Verbose "Destination set to $path"
    }

    process {
        if ($PSCmdlet.ShouldProcess($path, 'Go to directory')) {
            Write-Verbose "Navigating to $path"
            Set-Location $path
        }
    }
}


# Varia
# -----------------------------------------------------------------------------

function Get-FileHashMD5 {
    <#
    .SYNOPSIS
        Calculates the MD5 hash of an input.
    .PARAMETER Path
        Path to calculate hashes from.
    .EXAMPLE
        Get-FileHashMD5 file
    .EXAMPLE
        Get-FileHashMD5 file1,file2
    .EXAMPLE
        Get-FileHashMD5 *.gz
    .INPUTS
        System.String[]
    .OUTPUTS
        Microsoft.PowerShell.Commands.FileHashInfo
    .LINK
        Get-FileHash
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true
        )]
        [string]$Path
    )
    Get-FileHash $Path -Algorithm MD5
}

function Get-FileHashSHA1 {
    <#
    .SYNOPSIS
        Calculates the SHA1 hash of an input.
    .PARAMETER Path
        File(s) to calculate hashes from.
    .EXAMPLE
        Get-FileHashSHA1 file
    .EXAMPLE
        Get-FileHashSHA1 file1,file2
    .EXAMPLE
        Get-FileHashSHA1 *.gz
    .INPUTS
        System.String[]
    .OUTPUTS
        Microsoft.PowerShell.Commands.FileHashInfo
    .LINK
        Get-FileHash
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true
        )]
        [string]$Path
    )
    Get-FileHash $Path -Algorithm SHA1
}

function Get-FileHashSHA256 {
    <#
    .SYNOPSIS
        Calculates the SHA256 hash of an input.
    .PARAMETER Path
        File(s) to calculate hashes from.
    .EXAMPLE
        Get-FileHashSHA256 file
    .EXAMPLE
        Get-FileHashSHA256 file1,file2
    .EXAMPLE
        Get-FileHashSHA256 *.gz
    .INPUTS
        System.String[]
    .OUTPUTS
        Microsoft.PowerShell.Commands.FileHashInfo
    .LINK
        Get-FileHash
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$true,
            Position=0,
            ValueFromPipeline=$true
        )]
        [string]$Path
    )
    Get-FileHash $Path -Algorithm SHA256
}

function Get-Weather {
    <#
    .SYNOPSIS
        Display the current weather and forecast.
    .DESCRIPTION
        Fetches the weather information from https://wttr.in for terminal
        display.
    .PARAMETER Request
        The full URL to the wttr request.
    .PARAMETER Timeout
        The number of seconds to wait for a response.
    .EXAMPLE
        Get-Weather nF 10
    .INPUTS
        System.String
    .OUTPUTS
        System.String
    .LINK
        https://github.com/chubin/wttr.in
    .LINK
        https://wttr.in
    #>
    [CmdletBinding()]
    param(
        [Parameter(
            Mandatory=$false,
            ValueFromPipeline=$true
        )]
        [string]$Request,

        [Parameter(Mandatory=$false)]
        [PSDefaultValue(Help = '10')]
        [int]$Timeout = 10
    )

    begin {
        if ($Request) {
            $Request = '?' + $Request
        }
        $Request = 'https://wttr.in' + $Request
    }

    process {
        $headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
        $headers.Add("Content-Encoding", 'deflate, gzip')
        (Invoke-WebRequest -Uri "$Request" -UserAgent "curl" -Headers $headers -UseBasicParsing -TimeoutSec "$Timeout").content
    }
}

function Get-WeatherForecast {
    <#
    .SYNOPSIS
        Displays detailed weather and forecast.
    .DESCRIPTION
        Fetches the weather information from wttr.in for terminal display.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        https://wttr.in
    #>
    [CmdletBinding()]
    param()

    Get-Weather 'F'
}

function Get-WeatherCurrent {
    <#
    .SYNOPSIS
        Displays current weather.
    .DESCRIPTION
        Fetches the weather information from wttr.in for terminal display.
    .INPUTS
        None
    .OUTPUTS
        System.String
    .LINK
        https://wttr.in
    #>
    [CmdletBinding()]
    param()

    Get-Weather 'format=%l:+(%C)+%c++%t+[%h,+%w]'
}
