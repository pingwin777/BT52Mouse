import os
import asyncio
import subprocess
import logging
from logging.handlers import RotatingFileHandler
from winsdk.windows.devices.enumeration import DeviceInformation

# --- KONFIGURACJA ---
LOG_PATH = r"C:\Mysz\koniec_log.txt"

# KONFIGURACJA LOGÓW
try:
    log_handler = RotatingFileHandler(LOG_PATH, maxBytes=1024*1024, backupCount=1, encoding='utf-8')
    logging.basicConfig(handlers=[log_handler], level=logging.INFO, format='%(asctime)s - %(message)s')
except:
    pass

def kill_all_python_processes():
    """Zabija wszystkie procesy pythonw.exe, w tym BT52Mouse2 oraz ten skrypt."""
    logging.info("Wysyłanie sygnału zamknięcia do wszystkich procesów Python...")
    try:
        # Wykorzystujemy pełną ścieżkę do taskkill
        # /F - wymuszenie, /IM - nazwa obrazu, /T - drzewo procesów
        subprocess.run(['C:\\Windows\\System32\\taskkill.exe', '/F', '/IM', 'pythonw.exe', '/T'], 
                       capture_output=True, check=False)
    except Exception as e:
        # Ten log prawdopodobnie i tak się nie zapisze, bo proces zostanie zabity natychmiast
        logging.error(f"Błąd podczas taskkill: {e}")

async def unpair_bt_devices():
    """Rozparowuje mysz przy użyciu natywnego API Windows SDK."""
    logging.info("Inicjacja czyszczenia Bluetooth API...")
    try:
        devices = await DeviceInformation.find_all_async()
        count_success = 0
        for device in devices:
            if device.name and "BT5.2 Mouse" in device.name:
                if hasattr(device, 'pairing') and device.pairing is not None:
                    try:
                        await asyncio.wait_for(device.pairing.unpair_async(), timeout=3.0)
                        count_success += 1
                    except:
                        continue 
        logging.info(f"Bluetooth API: Rozparowano pomyślnie {count_success} urządzeń.")
    except Exception as e:
        logging.error(f"Błąd krytyczny Bluetooth API: {e}")

async def main():
    logging.info("--- PROCEDURA ZAMYKANIA SYSTEMU ROZPOCZĘTA ---")
    
    # 1. Najpierw wykonujemy najważniejsze zadanie - rozparowanie myszki
    await unpair_bt_devices()
    
    # 2. Teraz wpisujemy zakończenie do loga, póki skrypt jeszcze działa
    logging.info("--- PROCEDURA ZAKOŃCZONA ---")
    
    # 3. Na samym końcu zabijamy procesy (BT52Mouse2 oraz siebie samego)
    kill_all_python_processes()

if __name__ == "__main__":
    asyncio.run(main())