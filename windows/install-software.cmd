@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

:: Anthropic.ClaudeCode
winget install ^
    Google.GoogleDrive ^
    TeamViewer.TeamViewer.Host ^
    VaclavSlavik.Poedit ^
    Garmin.Express ^
    voidtools.Everything ^
    WireGuard.WireGuard ^
    SQLite.SQLite ^
    Rufus.Rufus

:: ChatGPT
winget install --source msstore ^
    "Authenticator App - OneAuth"
