echo|set /p="IP: "
tasklist | find /i "ngrok.exe" >Nul && curl -s localhost:4040/api/tunnels | jq -r .tunnels[0].public_url || echo "Unable to get NGROK tunnel, make sure NGROK_AUTH_TOKEN is correct in Settings > Secrets > Repository secret. Maybe your previous RDP is still running: https://dashboard.ngrok.com/status/tunnels "
echo Username: administrator
echo Password: %password%
echo Login to your RDP!!
ping -n 10 127.0.0.1 >nul
