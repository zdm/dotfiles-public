@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

winget install MSYS2.MSYS2

set MSYS64_LOCATION="c:\msys64"
set PROFILE="%MSYS64_LOCATION%\home\%USERNAME%"
set GPG_PROFILE="s:\gpg"

:: bash
del "%PROFILE%\.bashrc"
mklink "%PROFILE%\.bashrc" "%~dp0\..\profile\.bashrc"

del "%PROFILE%\.inputrc"
mklink "%PROFILE%\.inputrc" "%~dp0\..\profile\.inputrc"

:: mc
mkdir "%PROFILE%\.config\mc"

del "%PROFILE%\.config\mc\ini"
mklink "%PROFILE%\.config\mc\ini" "%~dp0\..\profile\.config\mc\ini"

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
mklink /D "%PROFILE%\.gnupg" "%GPG_PROFILE%"

del "%GPG_PROFILE%\dirmngr.conf"
mklink "%GPG_PROFILE%\dirmngr.conf" "%~dp0\..\profile\.gnupg\dirmngr.conf"

del "%GPG_PROFILE%\gpg.conf"
mklink "%GPG_PROFILE%\gpg.conf" "%~dp0\..\profile\.gnupg\gpg.conf"

del "%GPG_PROFILE%\gpg-agent.conf"
mklink "%GPG_PROFILE%\gpg-agent.conf" "%~dp0\..\profile\.gnupg\gpg-agent.conf"

del "%GPG_PROFILE%\sshcontrol"
mklink "%GPG_PROFILE%\sshcontrol" "%~dp0\..\profile\.gnupg\sshcontrol"

:: export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
setx /M SSH_AUTH_SOCK "/home/%USERNAME%/.gnupg/S.gpg-agent.ssh"

:: generate sshd host keys
ssh-keygen -A

:: sshd
mkdir ""%MSYS64_LOCATION%\etc\ssh"

del "%MSYS64_LOCATION%\etc\ssh\ssh_config"
mklink "%MSYS64_LOCATION%\etc\ssh\ssh_config" "%~dp0\ssh\ssh_config"

del "%MSYS64_LOCATION%\etc\ssh\sshd_config"
mklink "%MSYS64_LOCATION%\etc\ssh\sshd_config" "%~dp0\ssh\sshd_config"

:: ssh
mkdir "%PROFILE%\.ssh"

del "%PROFILE%\.ssh\authorized_keys"
mklink "%PROFILE%\.ssh\authorized_keys" "%~dp0\ssh\authorized_keys"

del "%PROFILE%\.ssh\config"
mklink "%PROFILE%\.ssh\config" "%~dp0\..\profile\.ssh\config"

setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8
