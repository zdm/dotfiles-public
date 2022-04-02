@echo off

setlocal

set APPS_PATH=d:\apps

call "%APPS_PATH%\bin\elevate.cmd" "%~sf0" %* & if errorlevel 1 exit /B 1

pushd "%~dp0"

:: set volume id
"%APPS_PATH%\bin\volumeid.exe" c: 1234-5670
"%APPS_PATH%\bin\volumeid.exe" d: 1234-5671

:: restore folders structure
mkdir d:\apps
mkdir d:\backup\tib
mkdir d:\devel
mkdir d:\downloads
mkdir d:\tmp
mkdir d:\vmware

rmdir /Q /S "d:\documents"
mklink /D "d:\documents" "g:\my drive\documents"

rmdir /Q /S "d:\pictures"
mklink /D "d:\pictures" "g:\my drive\pictures"

setx.exe /M PATHEXT ".com;.exe;.bat;.cmd;.lnk;.pl;.t;.js;.cjs;.mjs"

:: PATH
setx.exe /M PATH "%SystemRoot%;%SystemRoot%\system32;%SystemRoot%\system32\wbem;%SystemRoot%\System32\WindowsPowerShell\v1.0;%ProgramFiles(x86)%\VMware\VMware Workstation;s:\bin;d:\apps\bin;d:\devel\bin;d:\devel\git\cmd;d:\devel\perl\perl\site\bin;d:\devel\perl\perl\bin;d:\devel\perl\c\bin;%USERPROFILE%\.npm;d:\devel\node;d:\devel\msys2\usr\bin;d:\devel\java\bin;d:\devel\python"

:: disable native language support for unix tools
:: setx /M LANG "en"
:: setx /M LANGUAGE "en"

:: mandatory for google drive
:: setx /M LANG "en_US"

:: setx /M WGETRC "d:\dropbox\shared\bin\wget.ini"

:: git
setx /M GIT_SSH plink.cmd
setx /M GIT_SSH_VARIANT plink

:: perl
:: setx /M PERL_CPANM_HOME "%TEMP%\.cpanm"
:: setx /M PERL_CPANM_OPT "--metacpan --from https://cpan.metacpan.org/"
:: setx /M HARNESS_OPTIONS "c"
:: setx /M HARNESS_SUMMARY_COLOR_SUCCESS "GREEN"
:: setx /M HARNESS_SUMMARY_COLOR_FAIL "RED"

:: ftype PerlScript="d:\devel\perl\perl\bin\perl.exe" "%%1" %%*
:: assoc .pl=PerlScript
:: assoc .t=PerlScript

:: javascript
ftype JavaScript="d:\devel\node\node.exe" "%%1" %%*
assoc .js=JavaScript
assoc .cjs=JavaScript
assoc .mjs=JavaScript

:: ftype PythonScript="d:\devel\python\python.exe" %%1 %%*
:: assoc .py=PythonScript

:: ftype ShockwaveFlash="d:\apps\bin\flash.exe" %%1 %%*
:: assoc .swf=ShockwaveFlash

ftype SQLiteDB="d:\devel\bin\sqlite3.exe" %%1 %%*
assoc .sqlite=SQLiteDB

ftype GetTextSource="d:\apps\poedit\poedit.exe" %%1 %%*
assoc .pot=GetTextSource
assoc .po=GetTextSource

:: ftype MHTWebArchive="d:\apps\firefox\firefox.exe" "%%1" %%*
:: assoc .mht=MHTWebArchive

ftype XNView="d:\apps\xnviewmp\xnviewmp.exe" "%%1" %%*
assoc .bmp=XNView
assoc .cur=XNView
assoc .emf=XNView
assoc .gif=XNView
assoc .ico=XNView
assoc .jpeg=XNView
assoc .jpg=XNView
assoc .png=XNView
assoc .tif=XNView
assoc .tiff=XNView
assoc .wmf=XNView

:: reg.exe add "HKLM\Software\Microsoft\Command Processor" /f /v "Autorun" /t REG_SZ /d "@chcp 1251>nul"

:: remap CAPSLOCK => F13
reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /f /v "Scancode Map" /t REG_BINARY /d 00000000000000000200000064003a0000000000

:: enable hibernate
:: powercfg /H /TYPE FULL

:: make I/O redirection work
:: !!!WARNING!!! do not apply under Windows 10
:: reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /f /v "InheritConsoleHandles" /t REG_DWORD /d "1"

:: set default suffix for single-lable domains names, reboot is required
reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient" /f /v "SearchList" /t REG_SZ /d "localhost"

:: import registry settings
@for /F "delims=" %%x in ('dir /B /S registry-backup\*.reg') do reg.exe import "%%x"

:: install fonts
:: @for /F "delims=" %%x in ('dir /B /S ..\fonts\*.ttf') do (
::     xcopy "%%x" %SystemRoot%\fonts
::     reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" /f /v "%%~nx (TrueType)" /t REG_SZ /d "%%~nx%%~xx"
:: )

:: console settings
:: discard old duplicates: checked
:: font: Liberation Mono
:: font size: 18
:: screen buffer size: 156 x 3000
:: windows size: 156 x 46
:: NOTE: install only "Liberation Mono" before change console font. After configure console install others fonts.
reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Console\TrueTypeFont" /f /v "0" /t REG_SZ /d "Liberation Mono"

:: disable 8.3 names creation
:: reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem" /f /v "NtfsDisable8dot3NameCreation" /t REG_DWORD /d 1

:: allow ping
netsh advfirewall firewall add rule name="All ICMP V4" protocol=icmpv4:any,any dir=in action=allow

:: allow RDP connections from public networks
:: netsh advfirewall firewall set rule group="Remote Desktop" new enable=Yes

:: disallow Remote Assistance connections totally
:: netsh advfirewall firewall set rule group="Remote Assistance" new enable=No

:: set time sync interval to 4 hours
:: reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\w32time\TimeProviders\NtpClient" /f /v "SpecialPollInterval" /t REG_DWORD /d 14400

:: clean pagefile.sys at shutdown
:: reg.exe add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /f /v "ClearPageFileAtShutdown" /t REG_DWORD /d 1

:: windows defender
:: http://technet.microsoft.com/en-us/library/dn433291.aspx
:: powershell.exe -Command Set-MpPreference -DisableArchiveScanning 0 -DisableBehaviorMonitoring 0 -DisableEmailScanning 0 -DisableIntrusionPreventionSystem 0 -DisableIOAVProtection 0 -DisablePrivacyMode 1 -DisableRealtimeMonitoring 1 -DisableRemovableDriveScanning 0 -DisableRestorePoint 1 -DisableScanningMappedNetworkDrivesForFullScan 1 -DisableScanningNetworkFiles 1 -DisableScriptScanning 0 -ExclusionPath "d:\dropbox\shared-win\bin\socks.exe" -HighThreatDefaultAction Quarantine -LowThreatDefaultAction Quarantine -MAPSReporting 0 -ModerateThreatDefaultAction Quarantine -QuarantinePurgeItemsAfterDelay 0 -ScanPurgeItemsAfterDelay 0 -SevereThreatDefaultAction Quarantine -UnknownThreatDefaultAction Quarantine
