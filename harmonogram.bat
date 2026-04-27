@echo off
:: Sprawdzenie uprawnień administratora
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo BLAD: Musisz uruchomic ten plik jako ADMINISTRATOR!
    pause
    exit /b
)

echo Rejestrowanie zadan w Harmonogramie...

:: Rejestracja zadania START
powershell -Command "Register-ScheduledTask -Xml (Get-Content 'C:\Mysz\Mysz_Start.xml' -Raw) -TaskName 'Mysz_Start_NaOdblokowanie' -Force"

:: Rejestracja zadania STOP
powershell -Command "Register-ScheduledTask -Xml (Get-Content 'C:\Mysz\Mysz_Stop.xml' -Raw) -TaskName 'Mysz_Stop_NaWylaczenieEkranu' -Force"

echo.
echo Gotowe! Zadania zostaly dodane/zaktualizowane.
pause