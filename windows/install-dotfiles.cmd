@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

:: create directories
rmdir /S /Q "%USERPROFILE%\Downloads"
mklink /D "%USERPROFILE%\Downloads" "d:\downloads"

rmdir /S /Q "%USERPROFILE%\Documents"
mklink /D "%USERPROFILE%\Documents" "d:\documents"

rmdir /S /Q "%USERPROFILE%\music"
mklink /D "%USERPROFILE%\music" "d:\music"

rmdir /S /Q "%USERPROFILE%\Pictures"
mklink /D "%USERPROFILE%\Pictures" "d:\pictures"

rmdir /S /Q "%USERPROFILE%\Videos"
mklink /D "%USERPROFILE%\Videos" "d:\pictures"

:: git
del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%USERPROFILE%\.config\git"

rmdir /S /Q "%USERPROFILE%\.config\git\hooks"
mklink /D "%USERPROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%USERPROFILE%\.config\git\ssh"
mklink /D "%USERPROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"

:: postgresqll
mkdir "%APPDATA%\postgresql"

del "%APPDATA%\postgresql\psqlrc.conf"
mklink "%APPDATA%\postgresql\psqlrc.conf" "%~dp0\..\profile\.psqlrc"

:: neovim
rmdir /S /Q "%LOCALAPPDATA%\nvim"
mklink /D "%LOCALAPPDATA%\nvim" "%~dp0\..\profile\.config\nvim"

pause
