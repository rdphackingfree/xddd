@echo off
set username=administrator
set password=@ngrokRDP
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By AdityaGans2542" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f > out.txt 2>&1
net user %username% %password% /add >nul
net localgroup administrators %username% /add >nul
net user %username% /active:yes >nul
net user installer /delete
diskperf -Y >nul
sc config Audiosrv start=auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant %username%:F >nul
ICACLS C:\Windows\installer /grant %username%:F >nul

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
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\ /v ComputerName /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v Hostname /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\ /v "AD Host" /t REG_SZ /d WindowsRDP /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Manufacturer /t REG_SZ /d "AdHost" /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v Model /t REG_SZ /d "AdHost Virtual Machine" /f
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation /v SupportURL /t REG_SZ /d "https://github.com/Metehanse/WindowsRDP/issues" /f
cls
echo Personalization complete
timeout /t 1
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters
rundll32 user32.dll,UpdatePerUserSystemParameters
ie4uinit.exe -ClearIconCache
taskkill /f /im explorer.exe
start explorer.exe

echo If the RDP dead, please rerun workflow.
 
echo|set /p="IP: "
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Unable to get NGROK tunnel, make sure NGROK_AUTH_TOKEN is correct in Settings > Secrets > Repository secret. Maybe your previous RDP is still running: https://dashboard.ngrok.com/status/tunnels "
echo Username: %username%
echo Password: %password%
echo Login to your RDP!
ping -n 10 127.0.0.1 >nul
