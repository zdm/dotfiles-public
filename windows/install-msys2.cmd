@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_LOCATION="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_LOCATION%\home\%USERNAME%"

winget install MSYS2.MSYS2
winget pin add -q MSYS2.MSYS2

:: start msys2 shell
:: initialize pacman environment, needed to run once
:: msys2_shell.bat

:: sync package list and perform system upgrade
pacman --sync --noconfirm --needed --refresh --sysupgrade

:: tools
pacman --sync --noconfirm --needed ^
    bash ^
    pacman pacman-mirrors ^
    msys2-runtime ^
    man tar curl wget patch diffutils whois unzip ^
    mingw-w64-x86_64-jq ^
    ctags
    :: mc

:: gcc
pacman --sync --noconfirm --needed mingw-w64-x86_64-gcc

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
pacman --sync --noconfirm --needed ^
    git ^
    git-filter-repo ^
    git-crypt ^
    mingw-w64-x86_64-git-lfs

del "%MSYS64_USERPROFILE%\.gitconfig"
mklink "%MSYS64_USERPROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%MSYS64_USERPROFILE%\.config\git"

rmdir /S /Q "%MSYS64_USERPROFILE%\.config\git\hooks"
mklink /D "%MSYS64_USERPROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%MSYS64_USERPROFILE%\.config\git\ssh"
mklink /D "%MSYS64_USERPROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"

:: github-cli
pacman --sync --noconfirm --needed mingw-w64-x86_64-github-cli

mkdir "%APPDATA%\GitHub CLI"

del "%APPDATA%\GitHub CLI\config.yml"
mklink "%APPDATA%\GitHub CLI\config.yml" "%~dp0\..\profile\.config\gh\config.yml"

:: gpg
call "%~dp0\install-gpg.cmd"

:: ssh
pacman --sync --noconfirm --needed openssh

mkdir "%MSYS64_USERPROFILE%\.ssh"

del "%MSYS64_USERPROFILE%\.ssh\config"
mklink "%MSYS64_USERPROFILE%\.ssh\config" "%~dp0\..\profile\.ssh\config"

setx /M MSYS winsymlinks:nativestrict
setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8

FOR /F "delims=" %i IN ( 'gpgconf --list-dirs agent-ssh-socket' ) DO set SSH_AUTH_SOCK=%i
setx /M SSH_AUTH_SOCK "%SSH_AUTH_SOCK%"
