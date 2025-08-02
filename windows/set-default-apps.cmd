@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

:: powershell
ftype PowerShellScript="%LOCALAPPDATA%\Microsoft\WindowsApps\pwsh.exe" "%%1" %%*
for %%i in ( .ps1 ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=PowerShellScript
)

:: bash
ftype ShellScript="c:\msys64\usr\bin\bash.exe" "%%1" %%*
for %%i in ( .sh ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=ShellScript
)

:: javascript
ftype JavaScript="d:\apps\fnm\data\current\node.exe" "%%1" %%*
for %%i in ( .js .mjs .cjs ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=JavaScript
)

:: typescript
ftype TypeScript="d:\apps\fnm\data\current\node.exe" "%%1" %%*
for %%i in ( .ts .tsx .mts .cts ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=TypeScript
)

:: sqlite
ftype SQLite3="d:\apps\bin\sqlite3.exe" "%%1"
for %%i in ( .sqlite ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=SQLite3
)

:: json
ftype JSON="C:\Program Files\Neovim\bin\nvim.exe" "%%1"
for %%i in ( .json .json5 ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=JSON
)

ftype MHTWebArchive="C:\Users\zdm\AppData\Local\Vivaldi\Application\vivaldi.exe" "%%1"
for %%i in ( .mht ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=MHTWebArchive
)

ftype Picture="C:\Program Files\XnViewMP\xnviewmp.exe" "%%1"
for %%i in ( .bmp .cur .emf .gif .ico .jpeg .jpg .png .tif .tiff .wmf ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=Picture
)

:: ftype PerlScript="d:\apps\perl\perl\bin\perl.exe" "%%1" %%*
:: for %%i in ( .pl .t ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=PerlScript
:: )

:: ftype PythonScript="d:\apps\python\python.exe" "%%1" %%*
:: for %%i in ( .py ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=PythonScript
:: )

:: ftype ShockwaveFlash="d:\apps\bin\flash.exe" "%%1"
:: for %%i in ( .swf ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=ShockwaveFlash
:: )
