@echo off

call elevate.cmd "%~sf0" %* & if errorlevel 1 exit /B 1

setlocal


rmdir /S /Q "%USERPROFILE%\Downloads"
mklink /D "%USERPROFILE%\Downloads" "d:\downloads"

rmdir /S /Q "%USERPROFILE%\Documents"
mklink /D "%USERPROFILE%\Documents" "d:\documents"

rmdir /S /Q "%USERPROFILE%\Pictures"
mklink /D "%USERPROFILE%\Pictures" "d:\pictures"

rmdir /S /Q "%USERPROFILE%\Videos"
mklink /D "%USERPROFILE%\Videos" "d:\pictures"

:: DOTFILES
rmdir /S /Q "%USERPROFILE%\.dotfiles"
mklink /D "%USERPROFILE%\.dotfiles" "%~dp0"

:: softvisio
rmdir /S /Q "%USERPROFILE%\.config\softvisio"
mklink /D "%USERPROFILE%\.config\softvisio" "%~dp0\..\.config\softvisio"

:: NPM
del "%USERPROFILE%\.npmrc"
mklink "%USERPROFILE%\.npmrc" "%~dp0\..\.npmrc"

:: GIT
del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%~dp0\..\.gitconfig"

:: MSYS2 GIT
:: del d:\devel\msys2\home\zdm\.gitconfig
:: mklink d:\devel\msys2\home\zdm\.gitconfig "%~dp0\.gitconfig"

:: PSQL
mkdir "%APPDATA%\postgresql"

del "%APPDATA%\postgresql\psqlrc.conf"
mklink "%APPDATA%\postgresql\psqlrc.conf" "%~dp0\..\.psqlrc"

del "%APPDATA%\postgresql\pgpass.conf"
mklink "%APPDATA%\postgresql\pgpass.conf" "%~dp0\..\.pgpass"

:: VIM
:: link vimrc
:: del "%USERPROFILE%\.vimrc"
:: mklink "%USERPROFILE%\.vimrc" "%~dp0\..\.vimrc"

:: link profile
:: mkdir "%USERPROFILE%\.vim"
:: rmdir /S /Q "%USERPROFILE%\.vim\bundle-local"
:: mklink /D "%USERPROFILE%\.vim\bundle-local" "%~dp0\..\.vim\bundle-local"

:: mkdir "%USERPROFILE%\.vim\unite\bookmark"
:: del "%USERPROFILE%\.vim\unite\bookmark\default"
:: mklink "%USERPROFILE%\.vim\unite\bookmark\default" "%~dp0\..\.vim\unite\bookmark\default"

:: NEOVIM
:: link nvim config dir
rmdir /S /Q "%LOCALAPPDATA%\nvim"
mklink /D "%LOCALAPPDATA%\nvim" "%~dp0\..\.config\nvim"

:: link profile
mkdir "%LOCALAPPDATA%\nvim-data"

rmdir /S /Q "%LOCALAPPDATA%\nvim-data\bundle-local"
mklink /D "%LOCALAPPDATA%\nvim-data\bundle-local" "%~dp0\..\.local\share\nvim\bundle-local"

rmdir /S /Q "%LOCALAPPDATA%\nvim-data\vsnip"
mklink /D "%LOCALAPPDATA%\nvim-data\vsnip" "%~dp0\..\.local\share\nvim\vsnip"

mkdir "%LOCALAPPDATA%\nvim-data\unite\bookmark"
del "%LOCALAPPDATA%\nvim-data\unite\bookmark\default.windows"
mklink "%LOCALAPPDATA%\nvim-data\unite\bookmark\default.windows" "%~dp0\..\.local\share\nvim\unite\bookmark\default.windows"

pause
