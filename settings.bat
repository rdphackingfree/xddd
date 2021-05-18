:: Coded by ?, remade my Metehanse
@echo off
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' ( goto a ) else ( goto b )
:a
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B
:b
if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
pushd "%CD%"
CD /D "%~dp0"
REG ADD "HKCU\Control Panel\Desktop" /v WallPaper /f /t REG_SZ /d C:\Windows\wallpaper.png
REG ADD "HKCU\Control Panel\Desktop" /v UserPreferencesMask /f /t REG_BINARY /d 9E12038010000000
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ /v ComputerName /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v Hostname /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v "AD Host" /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Manufacturer /t REG_SZ /d "AdHost" /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Model /t REG_SZ /d "AdHost Virtual Machine" /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportURL /t REG_SZ /d "https://github.com/Metehanse/WindowsRDP/issues" /f
REG ADD HKLU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects /v VisualFXSetting /t REG_DWORD /d 2 /f
REG ADD "HKLU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
REG ADD "HKLU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 1 /f
REG ADD "HKLU\Control Panel\Desktop" /v FontSmoothing /t REG_SZ /d 2 /f
REG ADD "HKLU\Control Panel\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ListviewShadow /t REG_SZ /d 0 /f
REG ADD "HKLU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
REG ADD HKLU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes /v AppsUseLightTheme /t REG_DWORD /d 0 /f
cls
echo Personalization complete
timeout /t 1
rundll32.exe user32.dll,UpdatePerUserSystemParameters 1, True
ie4uinit.exe -ClearIconCache
taskkill /f /im explorer.exe
start explorer.exe
