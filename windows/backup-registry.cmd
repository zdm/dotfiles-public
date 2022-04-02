@echo off

call elevate.cmd "%~sf0" %* & if errorlevel 1 exit /B 1

setlocal

mkdir "%~dp0\registry-backup"

pushd "%~dp0\registry-backup"

:: sysinternals
reg.exe export "HKEY_CURRENT_USER\Software\Sysinternals" "sysinternals.reg" /y

:: poedit
reg.exe export "HKEY_CURRENT_USER\Software\Vaclav Slavik\Poedit" "poedit.reg" /y

:: roboform
reg.exe export "HKEY_CURRENT_USER\SOFTWARE\Siber Systems" "roboform.reg" /y
reg.exe export "HKEY_CURRENT_USER\Software\Google\Chrome\NativeMessagingHosts\com.siber.roboform" "roboform-chrome.reg" /y
reg.exe export "HKEY_CURRENT_USER\Software\Mozilla\NativeMessagingHosts\com.siber.roboform" "roboform-firefox.reg" /y

:: regedit favorites
reg.exe export "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit\Favorites" "regedit-favorites.reg" /y

:: console
reg.exe export "HKEY_CURRENT_USER\Console" "console.reg" /y
