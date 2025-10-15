@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Google.GoogleDrive ^
    Google.GoogleUpdater ^
    TeamViewer.TeamViewer.Host ^
    VaclavSlavik.Poedit ^
    Garmin.Express ^
    voidtools.Everything

winget install --source msstore ^
    ChatGPT ^
    "Authenticator App - OneAuth"
