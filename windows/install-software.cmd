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

:: npm install -g @github/copilot
:: npm install -g @anthropic-ai/claude-code
:: npm install -g @openai/codex

:: winget install Anthropic.ClaudeCode
:: winget install OpenAI.Codex

winget install --source msstore ^
    "Authenticator App - OneAuth" ^
    ChatGPT
