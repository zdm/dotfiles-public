@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

winget install MSYS2.MSYS2

set PROFILE="c:\msys64\home\%USERNAME%"

:: bash
del "%PROFILE%\.bashrc"
mklink "%PROFILE%\.bashrc" "%~dp0\..\profile\.bashrc"

del "%PROFILE%\.inputrc"
mklink "%PROFILE%\.inputrc" "%~dp0\..\profile\.inputrc"

:: git
del "%PROFILE%\.gitconfig"
mklink "%PROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%PROFILE%\.config\git"

rmdir /S /Q "%PROFILE%\.config\git\hooks"
mklink /D "%PROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%PROFILE%\.config\git\ssh"
mklink /D "%PROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"

:: gpg
rmdir /S /Q "%PROFILE%\.gnupg"
mklink /D "%PROFILE%\.gnupg" "s:\gpg"

del "s:\gpg\dirmngr.conf"
mklink "s:\gpg\dirmngr.conf" "%~dp0\..\profile\.gnupg\dirmngr.conf"

del "s:\gpg\gpg.conf"
mklink "s:\gpg\gpg.conf" "%~dp0\..\profile\.gnupg\gpg.conf"

del "s:\gpg\gpg-agent.conf"
mklink "s:\gpg\gpg-agent.conf" "%~dp0\..\profile\.gnupg\gpg-agent.conf"

del "s:\gpg\sshcontrol"
mklink "s:\gpg\sshcontrol" "%~dp0\..\profile\.gnupg\sshcontrol"

:: ssh
mkdir "%PROFILE%\.ssh"

del "%PROFILE%\.ssh\authorized_keys"
mklink "%PROFILE%\.ssh\authorized_keys" "%~dp0\ssh\authorized_keys"

del "%PROFILE%\.ssh\config"
mklink "%PROFILE%\.ssh\config" "%~dp0\ssh\config"

setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8
setx /M SSH_AUTH_SOCK "/home/%USERNAME%/.gnupg/S.gpg-agent.ssh"
rem export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
