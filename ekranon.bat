@echo off
setlocal
cd /d "C:\Mysz"

:: Sprawdzenie czy skrypt o tej nazwie już działa (używamy PowerShell dla precyzji)
powershell -Command "$p = Get-CimInstance Win32_Process -Filter \"Name = 'pythonw.exe' AND CommandLine LIKE '%%BT52Mouse2.pyw%%'\"; if ($p) { exit 1 } else { exit 0 }"

if %errorlevel% equ 1 (
    :: Skrypt już działa, nie rób nic
    exit
) else (
    :: Skrypt nie działa, uruchom go
    start "" "pythonw.exe" "BT52Mouse2.pyw"
)
endlocal
exit