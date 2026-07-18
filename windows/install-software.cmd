@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Google.GoogleDrive ^
    TeamViewer.TeamViewer.Host ^
    VaclavSlavik.Poedit ^
    Garmin.Express ^
    voidtools.Everything ^
    WireGuard.WireGuard ^
    SQLite.SQLite ^
    Rufus.Rufus

:: winget install Anthropic.ClaudeCode

winget install --source msstore ^
    "Authenticator App - OneAuth"

:: winget install --source msstore ChatGPT
