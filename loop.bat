:: Coded by ?, remade my Metehanse
@echo off
echo Coded by ?, remade my Metehanse
echo RDP started successfully.
tasklist | find /i "ngrok.exe" >Nul && goto check || echo "Unable to get NGROK tunnel, make sure NGROK_AUTH_TOKEN is correct in Settings > Secrets > Repository secret. Maybe your previous RDP is still running: https://dashboard.ngrok.com/status/tunnels " & ping 127.0.0.1 >Nul & exit
:check
ping 127.0.0.1 > nul
cls
set /a num=(%RANDOM%*9000/32768)+1000
echo %num%
goto check