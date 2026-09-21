@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_LOCATION="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_LOCATION%\home\%USERNAME%"

pacman --sync --noconfirm --needed ^
    openssh

mkdir "%MSYS64_USERPROFILE%\.ssh"

del "%MSYS64_USERPROFILE%\.ssh\config"
mklink "%MSYS64_USERPROFILE%\.ssh\config" "%~dp0\..\profile\.ssh\config"

setx /M MSYS winsymlinks:nativestrict
setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8

FOR /F "delims=" %%i IN ( 'gpgconf --list-dirs agent-ssh-socket' ) DO set SSH_AUTH_SOCK=%%i
setx /M SSH_AUTH_SOCK "%SSH_AUTH_SOCK%"
