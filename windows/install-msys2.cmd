@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_LOCATION="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_LOCATION%\home\%USERNAME%"
set GPG_USERPROFILE="s:\gpg"

winget install MSYS2.MSYS2
winget pin add -q MSYS2.MSYS2

:: start msys2 shell
:: initialize pacman environment, needed to run once
:: msys2_shell.bat

:: sync package list and perform system upgrade
pacman -S --noconfirm --needed --refresh --sysupgrade

:: tools
pacman -S --noconfirm --needed bash pacman pacman-mirrors msys2-runtime diffutils man tar curl wget ctags whois patch mc

:: bash
del "%MSYS64_USERPROFILE%\.bashrc"
mklink "%MSYS64_USERPROFILE%\.bashrc" "%~dp0\..\profile\.bashrc"

del "%MSYS64_USERPROFILE%\.inputrc"
mklink "%MSYS64_USERPROFILE%\.inputrc" "%~dp0\..\profile\.inputrc"

:: mc
mkdir "%MSYS64_USERPROFILE%\.config\mc"

del "%MSYS64_USERPROFILE%\.config\mc\ini"
mklink "%MSYS64_USERPROFILE%\.config\mc\ini" "%~dp0\..\profile\.config\mc\ini"

:: git
pacman -S --noconfirm --needed git git-filter-repo
:: mingw-w64-x86_64-git-lfs

del "%MSYS64_USERPROFILE%\.gitconfig"
mklink "%MSYS64_USERPROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%MSYS64_USERPROFILE%\.config\git"

rmdir /S /Q "%MSYS64_USERPROFILE%\.config\git\hooks"
mklink /D "%MSYS64_USERPROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%MSYS64_USERPROFILE%\.config\git\ssh"
mklink /D "%MSYS64_USERPROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"

:: gpg
pacman -S --noconfirm --needed gnupg

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

:: ssh
pacman -S --noconfirm --needed openssh

mkdir "%MSYS64_USERPROFILE%\.ssh"

del "%MSYS64_USERPROFILE%\.ssh\config"
mklink "%MSYS64_USERPROFILE%\.ssh\config" "%~dp0\..\profile\.ssh\config"

setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8

FOR /F "delims=" %i IN ( 'gpgconf --list-dirs agent-ssh-socket' ) DO set SSH_AUTH_SOCK=%i
setx /M SSH_AUTH_SOCK "%SSH_AUTH_SOCK%"
