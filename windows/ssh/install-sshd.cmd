@echo off

:: elevate script
call is-elevated.cmd || ( sudo -E "%~sf0" %* & exit /B )

sc stop sshd
sc delete sshd

:: XXX not works
:: sc create "sshd" binpath="c:\msys64\usr\bin\sshd.exe -D -e" start=auto
cygrunsrv -I sshd -d "sshd" -p /usr/bin/sshd.exe -a "-D -e" -y tcpip
