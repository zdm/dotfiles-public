@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

set MSYS64_LOCATION="c:\msys64"
set MSYS64_USERPROFILE="%MSYS64_LOCATION%\home\%USERNAME%"
:: set GIT_USERPROFILE=%MSYS64_USERPROFILE%
set GIT_USERPROFILE=%USERPROFILE%

:: winget install AGWA.git-crypt

:: pacman -Rns mingw-w64-x86_64-git mingw-w64-x86_64-git-lfs
:: pacman -Rns git-crypt

pacman --sync --noconfirm --needed ^
    mingw-w64-x86_64-git ^
    mingw-w64-x86_64-git-lfs
    :: git-crypt ^
    :: filter-repo ^

del "%GIT_USERPROFILE%\.gitconfig"
mklink "%GIT_USERPROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%GIT_USERPROFILE%\.config\git"

rmdir /S /Q "%GIT_USERPROFILE%\.config\git\hooks"
mklink /D "%GIT_USERPROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%GIT_USERPROFILE%\.config\git\ssh"
mklink /D "%GIT_USERPROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"
