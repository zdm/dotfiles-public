@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

:: powershell
ftype PowerShellScript="%ProgramFiles%\PowerShell\7\pwsh.exe" "%%1" %%*
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
:: BUG: ccleaner removes ftype pointed to junction point
:: ftype JavaScript="d:\apps\fnm\data\current\node.exe" "%%1" %%*
ftype JavaScript="d:\apps\fnm\node.exe" "%%1" %%*
for %%i in ( .js .mjs .cjs ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=JavaScript
)

:: typescript
:: BUG: ccleaner removes ftype pointed to junction point
:: ftype TypeScript="d:\apps\fnm\data\current\node.exe" "%%1" %%*
ftype TypeScript="d:\apps\fnm\node.exe" "%%1" %%*
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
ftype JSON="%ProgramFiles%\Neovim\bin\nvim.exe" "%%1"
for %%i in ( .json .json5 ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=JSON
)

:: xml
ftype XML="%ProgramFiles%\Neovim\bin\nvim.exe" "%%1"
for %%i in ( .xml ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=XML
)

:: mht
ftype MHTWebArchive="%LOCALAPPDATA%\Vivaldi\Application\vivaldi.exe" "%%1"
for %%i in ( .mht ) do (
    reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
    reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
    assoc %%i=MHTWebArchive
)

:: pictures
:: ftype Picture="%ProgramFiles%\XnViewMP\xnviewmp.exe" "%%1"
:: for %%i in ( .bmp .cur .emf .gif .ico .jpeg .jpg .png .tif .tiff .wmf ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=Picture
:: )

:: perl
:: ftype PerlScript="d:\apps\perl\perl\bin\perl.exe" "%%1" %%*
:: for %%i in ( .pl .t ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=PerlScript
:: )

:: python
:: ftype PythonScript="d:\apps\python\python.exe" "%%1" %%*
:: for %%i in ( .py ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=PythonScript
:: )

:: flash
:: ftype ShockwaveFlash="d:\apps\bin\flash.exe" "%%1"
:: for %%i in ( .swf ) do (
::     reg delete "HKEY_CURRENT_USER\Software\Classes\%%i" /f
::     reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\%%i" /f
::     assoc %%i=ShockwaveFlash
:: )
