@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_ROOT="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_ROOT%\home\%USERNAME%"

setx /M MSYS winsymlinks:nativestrict
setx /M LANGUAGE C.UTF-8
setx /M LANG C.UTF-8
setx /M LC_ALL C.UTF-8

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
    man tar patch whois ^
    mingw-w64-x86_64-curl ^
    mingw-w64-x86_64-wget ^
    mingw-w64-x86_64-diffutils ^
    mingw-w64-x86_64-unzip ^
    mingw-w64-x86_64-jq ^
    mingw-w64-x86_64-ctags ^
    mingw64/mingw-w64-x86_64-sqlite3 ^
    mingw-w64-x86_64-libtree-sitter
    :: mc

:: gcc
pacman --sync --noconfirm --needed ^
    mingw-w64-x86_64-gcc

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
call "%~dp0\install-git.cmd"

:: github-cli
pacman --sync --noconfirm --needed ^
    mingw-w64-x86_64-github-cli

mkdir "%APPDATA%\GitHub CLI"

del "%APPDATA%\GitHub CLI\config.yml"
mklink "%APPDATA%\GitHub CLI\config.yml" "%~dp0\..\profile\.config\gh\config.yml"

:: gpg
call "%~dp0\install-gpg.cmd"

:: ssh
call "%~dp0\install-ssh.cmd"
