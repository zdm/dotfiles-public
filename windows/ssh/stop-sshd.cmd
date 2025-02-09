@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

sc stop "sshd" > NUL
sc config "sshd" start=disabled > NUL
