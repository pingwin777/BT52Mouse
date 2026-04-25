@echo off
setlocal

:: 1. Uruchomienie skryptu Python i oczekiwanie na jego zakoñczenie
echo Uruchamianie procedury odparowania Bluetooth...
start /wait pythonw.exe "C:\Mysz\koniec.pyw"

:: 2. Uruchomienie DeviceCleanupCmd z parametrem -n (brak pauzy na koncu)
if exist "C:\Mysz\DeviceCleanupCmd.exe" (
    echo Uruchamianie DeviceCleanupCmd...
    "C:\Mysz\DeviceCleanupCmd.exe" * -n
) else (
    echo Blad: Nie znaleziono DeviceCleanupCmd.exe w C:\Mysz\
)

echo Procedura zakonczona.
exit