@echo off
title Master Installer - BT 5.2 Mouse Automation
setlocal enabledelayedexpansion

:: --- 1. SPRAWDZENIE UPRAWNIEŃ ADMINISTRATORA ---
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ======================================================
    echo BLAD: Musisz uruchomic ten skrypt jako ADMINISTRATOR!
    echo Kliknij prawym przyciskiem myszy i wybierz "Uruchom jako administrator".
    echo ======================================================
    pause
    exit /b
)

echo ======================================================
echo 1. INSTALACJA SRODOWISKA PYTHON I BIBLIOTEK
echo ======================================================
:: Instalacja Pythona 3.12 przez Winget
winget install -e --id Python.Python.3.12 --scope machine --accept-package-agreements --accept-source-agreements

:: Odswiezenie sciezki PATH dla obecnej sesji
set "PATH=%PATH%;%LocalAppdata%\Programs\Python\Python312;%LocalAppdata%\Programs\Python\Python312\Scripts"

:: Instalacja wymaganych bibliotek Python
echo Instalacja bibliotek: pyautogui, opencv, winsdk, pillow...
pip install pyautogui opencv-python winsdk pillow --quiet

echo ======================================================
echo 2. KONFIGURACJA OCHRONY SYSTEMU (PUNKTY PRZYWRACANIA)
echo ======================================================
:: Wlaczenie ochrony na dysku C
powershell.exe -Command "Enable-ComputerRestore -Drive 'C:\'"
:: Usuniecie limitu czestotliwosci tworzenia punktow (Frequency = 0)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d 0 /f

echo ======================================================
echo 3. TWORZENIE STRUKTURY PLIKOW
echo ======================================================
if not exist "C:\Mysz" mkdir "C:\Mysz"

:: Kopiowanie skryptow, batow i grafik
copy /y "BT52Mouse2.pyw" "C:\Mysz\"
copy /y "koniec.pyw" "C:\Mysz\"
copy /y "startmysz.bat" "C:\Mysz\"
copy /y "startkoniec.bat" "C:\Mysz\"
copy /y "DeviceCleanupCmd.exe" "C:\Mysz\" 2>nul
copy /y "*.png" "C:\Mysz\"

echo ======================================================
echo 4. KONFIGURACJA GPO (SKRYPT WYLOGOWANIA)
echo ======================================================
set "GPO_LOGOFF=C:\WINDOWS\System32\GroupPolicy\User\Scripts\Logoff"
if not exist "!GPO_LOGOFF!" mkdir "!GPO_LOGOFF!"

:: Kopiowanie skryptu sterujacego do folderu zasad grup
copy /y "C:\Mysz\startkoniec.bat" "!GPO_LOGOFF!\"

:: Rejestracja w scripts.ini dla poprawnego dzialania GPO
echo [Logoff] > "!GPO_LOGOFF!\scripts.ini"
echo 0CmdLine=C:\Mysz\startkoniec.bat >> "!GPO_LOGOFF!\scripts.ini"
echo 0Parameters= >> "!GPO_LOGOFF!\scripts.ini"

echo ======================================================
echo 5. KONFIGURACJA AUTOSTARTU (LOGOWANIE)
echo ======================================================
:: Dodanie startmysz.bat do rejestru Run dla biezacego uzytkownika
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MyszAutoStart" /t REG_SZ /d "C:\Mysz\startmysz.bat" /f

echo ======================================================
echo GOTOWE! System zostal skonfigurowany ppomyslnie.
echo.
echo Dane techniczne:
echo - Rozdzielczosc: 2736 x 1824
echo - Skalowanie: 200%%
echo - Folder roboczy: C:\Mysz
echo.
echo Zrestartuj komputer, aby aktywowac wszystkie funkcje.
echo ======================================================
pause