@echo off

REM Copy Hyper configuration file to final destination on Windows

REM Hyper has not been installed
IF NOT EXIST %APPDATA%\Hyper\ (
    exit 0
)

REM Destination is a symbolic link
dir %APPDATA%\Hyper\.hyper.js | find "<SYMLINK>" > nul
IF %errorlevel% == 0 (
    exit 0
)

REM Configuration files are identical
fc /b %userprofile%\.hyper.js %APPDATA%\Hyper\.hyper.js > nul
IF %errorlevel% == 0 (
    exit 0
)

exit 0
REM Files are different or destination does not exist
xcopy /fvy %userprofile%\.hyper.js %APPDATA%\Hyper\
