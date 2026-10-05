@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Garmin.Express ^
    Google.GoogleDrive ^
    TeamViewer.TeamViewer.Host ^
    WireGuard.WireGuard ^
    voidtools.Everything

winget install --source msstore ^
    "Authenticator App - OneAuth" ^
    ChatGPT
