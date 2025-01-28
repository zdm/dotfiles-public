@echo off

call elevate.cmd "%~sf0" %* & if errorlevel 1 exit /B 1

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

:: wsl
del "%USERPROFILE%\.wslconfig"
mklink "%USERPROFILE%\.wslconfig" "%~dp0\.wslconfig"

:: ssh
mkdir "%USERPROFILE%\.ssh"

del "%USERPROFILE%\.ssh\config"
mklink "%USERPROFILE%\.ssh\config" "%~dp0\.ssh\config"

del "%USERPROFILE%\.ssh\authorized_keys"
mklink "%USERPROFILE%\.ssh\authorized_keys" "%~dp0\.ssh\authorized_keys"

mkdir "%ProgramData%\ssh"

del "%ProgramData%\ssh\sshd_config"
mklink "%ProgramData%\ssh\sshd_config" "%~dp0\.ssh\sshd_config"

del "%ProgramData%\ssh\administrators_authorized_keys"
mklink "%ProgramData%\ssh\administrators_authorized_keys" "%~dp0\.ssh\authorized_keys"

pause
