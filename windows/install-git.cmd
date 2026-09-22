@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

pacman --sync --noconfirm --needed ^
    mingw-w64-x86_64-git ^
    mingw-w64-x86_64-git-lfs ^
    git-crypt
    filter-repo

del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%~dp0\..\profile\.gitconfig"

mkdir "%USERPROFILE%\.config\git"

rmdir /S /Q "%USERPROFILE%\.config\git\hooks"
mklink /D "%USERPROFILE%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

rmdir /S /Q "%USERPROFILE%\.config\git\ssh"
mklink /D "%USERPROFILE%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"
