@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_LOCATION="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_LOCATION%\home\%USERNAME%"
set GPG_USERPROFILE="d:\apps\gpg\gpg"

:: gpg
pacman --sync --noconfirm --needed gnupg

rmdir /S /Q "%MSYS64_USERPROFILE%\.gnupg"
mklink /D "%MSYS64_USERPROFILE%\.gnupg" "%GPG_USERPROFILE%"

del "%GPG_USERPROFILE%\dirmngr.conf"
mklink "%GPG_USERPROFILE%\dirmngr.conf" "%~dp0\..\profile\.gnupg\dirmngr.conf"

del "%GPG_USERPROFILE%\gpg.conf"
mklink "%GPG_USERPROFILE%\gpg.conf" "%~dp0\..\profile\.gnupg\gpg.conf"

del "%GPG_USERPROFILE%\gpg-agent.conf"
mklink "%GPG_USERPROFILE%\gpg-agent.conf" "%~dp0\..\profile\.gnupg\gpg-agent.conf"

del "%GPG_USERPROFILE%\sshcontrol"
mklink "%GPG_USERPROFILE%\sshcontrol" "%~dp0\..\profile\.gnupg\sshcontrol"
