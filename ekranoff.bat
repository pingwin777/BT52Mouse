@echo off
:: Zabija proces pythonw.exe, który w linii komend ma nazwę Twojego skryptu
powershell -Command "Get-CimInstance Win32_Process -Filter \"Name = 'pythonw.exe' AND CommandLine LIKE '%%BT52Mouse2.pyw%%'\" | Invoke-CimMethod -MethodName Terminate" >nul 2>&1
exit