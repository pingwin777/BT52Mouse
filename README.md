# 🖱️ BT 5.2 Mouse Automation (SMRGBCD001 & Generic Chinese Mice)

Kompletny zestaw skryptów do automatyzacji procesu parowania i czyszczenia urządzeń Bluetooth. Projekt rozwiązuje problem uporczywych powiadomień o parowaniu oraz błędów "Driver Error" w tanich myszkach Bluetooth (np. model **SMRGBCD001**).

## 🌟 Funkcje
- **Automatyczne parowanie**: Skrypt Python (`BT52Mouse2.pyw`) monitoruje ekran i klika "Połącz", gdy tylko mysz zgłosi chęć parowania.
- **Optymalizacja pod wysoką rozdzielczość**: Skrypt dostosowany do ekranów **2736 x 1824** przy skalowaniu **200%**.
- **Czyste wylogowanie**: Automatyczne rozparowanie przy wylogowaniu zapobiega konfliktom przy ponownym uruchomieniu systemu.
- **Usuwanie "Duchów"**: Integracja z czyszczeniem martwych sterowników Bluetooth w rejestrze.

## 🛠️ Specyfikacja Techniczna
Projekt został zoptymalizowany pod następujące parametry:
- **Urządzenie**: Surface Pro 5 (lub dowolne o tej samej rozdzielczości).
- **Ekran**: 2736 x 1824 px.
- **Skalowanie systemowe**: 200%.
- **Model myszy**: SMRGBCD001 (BT 5.2 Mouse) oraz pokrewne modele generyczne.

## 🚀 Szybki Start (Instalacja)
1. Pobierz repozytorium.
2. Uruchom `scripts/Instaluj_Mysz.bat` jako **Administrator**.
3. Zrestartuj komputer.

Skrypt instalacyjny automatycznie:
- Instaluje **Python 3.12** oraz biblioteki `pyautogui`, `opencv-python`, `winsdk`.
- Konfiguruje folder roboczy `C:\Mysz\`.
- Dodaje automatyzację do systemowych skryptów wylogowania (GPO).

## 💻 Wymagania
- Windows 11 Pro / Windows 10.
- Uprawnienia administratora.

---
*Projekt stworzony, aby tanie akcesoria działały tak stabilnie, jak te z najwyższej półki.*
