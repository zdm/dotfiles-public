@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Google.GoogleDrive ^
    TeamViewer.TeamViewer.Host ^
    Garmin.Express ^
    voidtools.Everything ^
    WireGuard.WireGuard ^
    Rufus.Rufus ^
    GitHub.Copilot

:: winget install Anthropic.ClaudeCode
:: winget install OpenAI.Codex

winget install --source msstore ^
    "Authenticator App - OneAuth" ^
    ChatGPT
