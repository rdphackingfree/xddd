@echo off
set username=administrator
set password=@ngrokRDP
del /f "C:\Users\Public\Desktop\Epic Games Launcher.lnk" > out.txt 2>&1
net config server /srvcomment:"Windows Server 2019 By AdityaGans2542" > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v EnableAutoTray /t REG_DWORD /d 0 /f > out.txt 2>&1
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v Personalization /t REG_SZ /d personalization.bat
net user %username% %password% /add >nul
net localgroup administrators %username% /add >nul
net user %username% /active:yes >nul
net user installer /delete
diskperf -Y >nul
sc config Audiosrv start=auto >nul
sc start audiosrv >nul
ICACLS C:\Windows\Temp /grant %username%:F >nul
ICACLS C:\Windows\installer /grant %username%:F >nul
echo If the RDP dead, please rerun workflow.
 
echo|set /p="IP: "
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Unable to get NGROK tunnel, make sure NGROK_AUTH_TOKEN is correct in Settings > Secrets > Repository secret. Maybe your previous RDP is still running: https://dashboard.ngrok.com/status/tunnels "
echo Username: %username%
echo Password: %password%
echo Login to your RDP!
ping -n 10 127.0.0.1 >nul
