@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

pacman --sync --noconfirm --needed ^
    mingw-w64-x86_64-github-cli

mkdir "%APPDATA%\GitHub CLI"

del "%APPDATA%\GitHub CLI\config.yml"
mklink "%APPDATA%\GitHub CLI\config.yml" "%~dp0\..\profile\.config\gh\config.yml"
