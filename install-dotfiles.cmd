@echo off

call elevate.cmd "%~sf0" %* & if errorlevel 1 exit /B 1

setlocal

:: create directories
rmdir /S /Q "%USERPROFILE%\Downloads"
mklink /D "%USERPROFILE%\Downloads" "d:\downloads"

rmdir /S /Q "%USERPROFILE%\Documents"
mklink /D "%USERPROFILE%\Documents" "d:\documents"

rmdir /S /Q "%USERPROFILE%\Pictures"
mklink /D "%USERPROFILE%\Pictures" "d:\pictures"

rmdir /S /Q "%USERPROFILE%\Videos"
mklink /D "%USERPROFILE%\Videos" "d:\pictures"

:: git
del "%USERPROFILE%\.gitconfig"
mklink "%USERPROFILE%\.gitconfig" "%~dp0\profile\.gitconfig"

rmdir /S /Q "%USERPROFILE%\.git-hooks"
mklink /D "%USERPROFILE%\.git-hooks" "%~dp0\profile\.git-hooks"

:: psql
mkdir "%APPDATA%\postgresql"

del "%APPDATA%\postgresql\psqlrc.conf"
mklink "%APPDATA%\postgresql\psqlrc.conf" "%~dp0\profile\.psqlrc"

:: neovim
:: link nvim config dir
rmdir /S /Q "%LOCALAPPDATA%\nvim"
mklink /D "%LOCALAPPDATA%\nvim" "%~dp0\profile\.config\nvim"

:: link profile
mkdir "%LOCALAPPDATA%\nvim-data"

rmdir /S /Q "%LOCALAPPDATA%\nvim-data\bundle-local"
mklink /D "%LOCALAPPDATA%\nvim-data\bundle-local" "%~dp0\profile\.local\share\nvim\bundle-local"

rmdir /S /Q "%LOCALAPPDATA%\nvim-data\vsnip"
mklink /D "%LOCALAPPDATA%\nvim-data\vsnip" "%~dp0\profile\.local\share\nvim\vsnip"

mkdir "%LOCALAPPDATA%\nvim-data\unite\bookmark"
del "%LOCALAPPDATA%\nvim-data\unite\bookmark\default.windows"
mklink "%LOCALAPPDATA%\nvim-data\unite\bookmark\default.windows" "%~dp0\profile\.local\share\nvim\unite\bookmark\default.windows"

pause
