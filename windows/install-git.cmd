@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

setlocal

setx GIT_CONFIG_GLOBAL "%USERPROFILE%\.gitconfig"

setx GIT_CONFIG_COUNT 5
setx GIT_CONFIG_KEY_0 diffTool.guiDefault
setx GIT_CONFIG_VALUE_0 true
setx GIT_CONFIG_KEY_1 mergeTool.guiDefault
setx GIT_CONFIG_VALUE_1 false
setx GIT_CONFIG_KEY_2 core.hooksPath
setx GIT_CONFIG_VALUE_2 %USERPROFILE%\.config\git\hooks
setx GIT_CONFIG_KEY_3 gpg.ssh.allowedSignersFile
setx GIT_CONFIG_VALUE_3 %USERPROFILE%\.config\git\ssh\allowed-signatures
setx GIT_CONFIG_KEY_4 gpg.ssh.revocationFile
setx GIT_CONFIG_VALUE_4 %USERPROFILE%\.config\git\ssh\revocatied-signatures

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
