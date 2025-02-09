@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

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

:: postgresqll
mkdir "%APPDATA%\postgresql"

del "%APPDATA%\postgresql\psqlrc.conf"
mklink "%APPDATA%\postgresql\psqlrc.conf" "%~dp0\..\profile\.psqlrc"

:: neovim
rmdir /S /Q "%LOCALAPPDATA%\nvim"
mklink /D "%LOCALAPPDATA%\nvim" "%~dp0\..\profile\.config\nvim"

:: msys2
if exist "c:\msys64\home\%USERNAME%" (

    del "c:\msys64\home\%USERNAME%\.bashrc"
    mklink "c:\msys64\home\%USERNAME%\.bashrc" "%~dp0\..\profile\.bashrc"

    del "c:\msys64\home\%USERNAME%\.inputrc"
    mklink "c:\msys64\home\%USERNAME%\.inputrc" "%~dp0\..\profile\.inputrc"

    rem ### git
    del "c:\msys64\home\%USERNAME%\.gitconfig"
    mklink "c:\msys64\home\%USERNAME%\.gitconfig" "%~dp0\..\profile\.gitconfig"

    mkdir "c:\msys64\home\%USERNAME%\.config\git"

    rmdir /S /Q "c:\msys64\home\%USERNAME%\.config\git\hooks"
    mklink /D "c:\msys64\home\%USERNAME%\.config\git\hooks" "%~dp0\..\profile\.config\git\hooks"

    rmdir /S /Q "c:\msys64\home\%USERNAME%\.config\git\ssh"
    mklink /D "c:\msys64\home\%USERNAME%\.config\git\ssh" "%~dp0\..\profile\.config\git\ssh"
)
