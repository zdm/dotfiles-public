@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

winget install ^
    Garmin.Express ^
    GitHub.Copilot ^
    Google.GoogleDrive ^
    Rufus.Rufus ^
    TeamViewer.TeamViewer.Host ^
    WireGuard.WireGuard ^
    voidtools.Everything

:: winget install Anthropic.ClaudeCode
:: winget install OpenAI.Codex

winget install --source msstore ^
    "Authenticator App - OneAuth" ^
    ChatGPT
