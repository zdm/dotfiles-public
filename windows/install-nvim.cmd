@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

pacman --sync --noconfirm --needed ^
    mingw-w64-ucrt-x86_64-neovim

rmdir /S /Q "%LOCALAPPDATA%\nvim"
mklink /D "%LOCALAPPDATA%\nvim" "%~dp0\..\profile\.config\nvim"
