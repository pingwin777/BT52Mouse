import pyautogui
import time
import logging
import os
from logging.handlers import RotatingFileHandler

# OPTYMALIZACJA
pyautogui.PAUSE = 0
pyautogui.MINIMUM_DURATION = 0

BASE_DIR = r"C:\Mysz"
IKONA_PATH = os.path.join(BASE_DIR, "ikona_mysz.png")
POLACZ_PATH1 = os.path.join(BASE_DIR, "polacz.png")
POLACZ_PATH2 = os.path.join(BASE_DIR, "polacz2.png")
LOG_FILE = os.path.join(BASE_DIR, "skrypt_log.txt")

# LOGOWANIE
log_handler = RotatingFileHandler(LOG_FILE, maxBytes=1024*1024, backupCount=1, encoding='utf-8')
logging.basicConfig(handlers=[log_handler], level=logging.INFO, format='%(asctime)s - %(message)s')

# OBSZAR (Surface Pro 5)
SZUKANY_OBSZAR = (1600, 850, 1100, 950) 
PEWNOSC = 0.5 

logging.info("--- SKRYPT STARTOWY URUCHOMIONY (V5) ---")

def ciche_szukanie(sciezka_obrazka, obszar=SZUKANY_OBSZAR):
    """Szuka obrazka i zwraca pozycję lub None, bez wyrzucania błędu ImageNotFound."""
    try:
        return pyautogui.locateOnScreen(sciezka_obrazka, region=obszar, confidence=PEWNOSC, grayscale=True)
    except (pyautogui.ImageNotFoundException, Exception):
        return None

while True:
    try:
        # 1. Szukaj ikony powiadomienia
        ikona = ciche_szukanie(IKONA_PATH)
        
        if ikona:
            logging.info("Wykryto ikonę. Szukam przycisku...")
            
            # 2. Tryb TURBO przez 10 sekund
            start_turbo = time.time()
            kliknieto = False
            
            while time.time() - start_turbo < 10:
                # Próbuj oba wzory przycisku
                btn = ciche_szukanie(POLACZ_PATH1)
                if not btn:
                    btn = ciche_szukanie(POLACZ_PATH2)
                
                if btn:
                    p = pyautogui.center(btn)
                    pyautogui.click(p.x, p.y)
                    logging.info(f"SUKCES: Kliknięto 'Połącz' na {p.x}, {p.y}")
                    # Czekamy 20s, aż Windows sam schowa powiadomienie
                    time.sleep(20)
                    kliknieto = True
                    break
                time.sleep(0.2)
            
            if not kliknieto:
                # Jeśli po 10s nie ma przycisku, odczekaj chwilę, by nie spamować loga
                time.sleep(2)

    except Exception as e:
        msg = str(e).lower()
        if "screen grab failed" in msg or "oserror" in msg:
            time.sleep(10)
        else:
            logging.error(f"Nieoczekiwany błąd pętli: {e}")
            time.sleep(2)

    time.sleep(0.5)