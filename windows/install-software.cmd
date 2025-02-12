@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Google.GoogleDrive ^
    TeamViewer.TeamViewer.Host ^
    VaclavSlavik.Poedit ^
    Garmin.Express
