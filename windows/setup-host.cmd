@echo off

setlocal

set APPS_PATH=d:\apps

:: check script elevated
call "%APPS_PATH%\bin\is-elevated.cmd"

:: not elevated
if ERRORLEVEL 1 (

    "%APPS_PATH%\bin\hstart.exe" /ELEVATE /D="%~dp0" "cmd.exe /C ""%~sf0" %*

    exit /B
)

:: enable sudo
sudo config --enable normal

pushd "%~dp0"

:: set volume id
"%APPS_PATH%\bin\volumeid.exe" c: 1234-5670
"%APPS_PATH%\bin\volumeid.exe" d: 1234-5671

:: restore folders structure
mkdir d:\apps
mkdir d:\backup\tib
mkdir d:\downloads
mkdir d:\tmp
mkdir d:\vmware

rmdir /Q /S "d:\documents"
mklink /D "d:\documents" "g:\my drive\documents"

rmdir /Q /S "d:\music"
mklink /D "d:\music" "g:\my drive\music"

rmdir /Q /S "d:\pictures"
mklink /D "d:\pictures" "g:\my drive\pictures"

setx.exe /M PATHEXT ".com;.exe;.lnk;.bat;.cmd;.ps1;.js;.cjs;.mjs"

:: path
setx.exe /M PATH "%SystemRoot%\system32;%SystemRoot%;s:\bin;d:\apps\bin;%USERPROFILE%\.npm;d:\apps\node;c:\msys64\usr\bin;c:\msys64\mingw64\bin"

:: disable native language support for unix tools
:: setx /M LANG "en"
:: setx /M LANGUAGE "en"

:: mandatory for google drive
:: setx /M LANG "en_US"

:: git
setx /M GIT_CONFIG_COUNT 1
setx /M GIT_CONFIG_KEY_0 merge.tool
setx /M GIT_CONFIG_VALUE_0 bcompare

:: perl
:: setx /M PERL_CPANM_HOME "%TEMP%\.cpanm"
:: setx /M PERL_CPANM_OPT "--metacpan --from https://cpan.metacpan.org/"
:: setx /M HARNESS_OPTIONS "c"
:: setx /M HARNESS_SUMMARY_COLOR_SUCCESS "GREEN"
:: setx /M HARNESS_SUMMARY_COLOR_FAIL "RED"

:: ftype PerlScript="d:\apps\perl\perl\bin\perl.exe" "%%1" %%*
:: assoc .pl=PerlScript
:: assoc .t=PerlScript

:: powershell
ftype PowerShellScript="%LOCALAPPDATA%\Microsoft\WindowsApps\pwsh.exe" "%%1" %%*
assoc .ps1=PowerShellScript

:: javascript
ftype JavaScript="d:\apps\node\node.exe" "%%1" %%*
assoc .js=JavaScript
assoc .cjs=JavaScript
assoc .mjs=JavaScript

:: typescript
ftype TypeScript="d:\apps\node\node.exe" "%%1" %%*
assoc .ts=TypeScript
assoc .tsx=TypeScript
assoc .mts=TypeScript
assoc .cts=TypeScript

:: ftype PythonScript="d:\apps\python\python.exe" %%1 %%*
:: assoc .py=PythonScript

:: ftype ShockwaveFlash="d:\apps\bin\flash.exe" %%1 %%*
:: assoc .swf=ShockwaveFlash

ftype SQLite3DB="d:\apps\bin\sqlite3.exe" %%1 %%*
assoc .sqlite=SQLite3DB

:: ftype MHTWebArchive="d:\apps\firefox\firefox.exe" "%%1" %%*
:: assoc .mht=MHTWebArchive

:: ftype XNView="d:\apps\xnviewmp\xnviewmp.exe" "%%1" %%*
:: assoc .bmp=XNView
:: assoc .cur=XNView
:: assoc .emf=XNView
:: assoc .gif=XNView
:: assoc .ico=XNView
:: assoc .jpeg=XNView
:: assoc .jpg=XNView
:: assoc .png=XNView
:: assoc .tif=XNView
:: assoc .tiff=XNView
:: assoc .wmf=XNView

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
