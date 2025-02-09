@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

:: winget install Neovim.Neovim
:: winget install equalsraf.neovim-qt

winget install Google.GoogleDrive
winget install TeamViewer.TeamViewer.Host
winget install VaclavSlavik.Poedit
winget install Garmin.Express
