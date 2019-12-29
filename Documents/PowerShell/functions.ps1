#
# PowerShell profile: functions
#

if ((Get-Variable 'ColorInfo' -ErrorAction 'Ignore') -eq $null) {  
    Set-Variable -Name ColorInfo -Value 'DarkYellow'
}

# Keep all Scoop apps up to date
function scoopup {
    scoop update *
    scoop cleanup *
}
function brewery {
    Write-Host "Homebrew is not a Windows app. Calling Scoop instead..." -ForegroundColor $ColorInfo
    scoopup
}

function hideFiles {
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 2
}

function showFiles {
    Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1
}

# Import popular commands from Linux.
if (Get-Command Import-WslCommand -errorAction Ignore) {
    Import-WslCommand "chmod"
    Import-WslCommand "grep"
    Import-WslCommand "head"
    Import-WslCommand "less"
    Import-WslCommand "ls"
    Import-WslCommand "man"
    Import-WslCommand "ssh"
    Import-WslCommand "tail"

    $WslDefaultParameterValues = @{}
    $WslDefaultParameterValues["grep"] = "-E"
    $WslDefaultParameterValues["less"] = "-i"
    $WslDefaultParameterValues["ls"] = "-AFhl --color=auto"

    $WslImportedCommands = @()
    $WslImportedCommands += 'chmod'
    $WslImportedCommands += 'grep'
    $WslImportedCommands += 'head'
    $WslImportedCommands += 'less'
    $WslImportedCommands += 'ls'
    $WslImportedCommands += 'man'
    $WslImportedCommands += 'ssh'
    $WslImportedCommands += 'tail'
}

# Import "touch" command from Linux.
if (Get-Command Import-WslCommand -errorAction Ignore) {
    Import-WslCommand "touch"
    $WslImportedCommands += 'touch'
}
else {
    function touch {
        $file = $args[0]
        if ($file -eq $null) {
            throw "usage: touch file"
        }

        if (Test-Path $file) {
            (Get-ChildItem $file).LastWriteTime = Get-Date
        }
        else {
            New-Item -ItemType file $file
        }
    }
}
