@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

sc start "sshd" > NUL
sc config "sshd" start=auto > NUL
