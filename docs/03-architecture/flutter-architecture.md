# Flutter Architecture

## 1. Cel dokumentu

Dokument opisuje prosta architekture aplikacji `Game Explorer` w Flutterze. Celem jest utrzymanie projektu w ryzach bez przesadnego komplikowania go backendem lub zbyt rozbudowana infrastruktura.

## 2. Glowna decyzja architektoniczna

Projekt bedzie aplikacja `frontend only`:

- `Flutter` odpowiada za UI, nawigacje, stan, requesty do API i lokalny storage,
- dane o grach beda pobierane z `RAWG API`,
- dane uzytkownika beda zapisywane lokalnie na urzadzeniu,
- projekt nie posiada wlasnego backendu.

To jest odpowiedni wybor dla projektu studenckiego, bo daje ciekawa aplikacje bez nadmiarowej zlozonosci.

## 3. Proponowany przeplyw danych

Schemat przeplywu:

1. ekran wywoluje akcje, np. pobranie listy gier,
2. warstwa stanu lub kontroler wywoluje repozytorium,
3. repozytorium pobiera dane z `RAWG API` albo lokalnego storage,
4. dane wracaja do warstwy stanu,
5. UI renderuje wynik, loader albo blad.

Uproszczony zapis:

`UI -> Controller/Provider -> Repository -> API or Local Storage`

## 4. Proponowane warstwy aplikacji

### 4.1 Presentation

Warstwa odpowiedzialna za:

- ekrany,
- widgety,
- animacje,
- nawigacje,
- renderowanie stanow `loading`, `data`, `error`.

### 4.2 Application or State

Warstwa odpowiedzialna za:

- pobieranie danych dla ekranow,
- laczenie danych z API i danych lokalnych,
- trzymanie stanu list, szczegolow i biblioteki,
- obsluge akcji uzytkownika.

### 4.3 Data

Warstwa odpowiedzialna za:

- klient HTTP,
- mapowanie odpowiedzi API,
- lokalny storage,
- repozytoria.

## 5. Struktura folderow

Rekomendowany prosty podzial:

```text
lib/
  app/
  core/
  features/
    splash/
    home/
    search/
    game_details/
    library/
    progress_tracker/
  shared/
```

Znaczenie:

- `app/` - start aplikacji, routing, theme,
- `core/` - networking, constants, storage, helpers,
- `features/` - logika podzielona po ekranach i funkcjach,
- `shared/` - wspolne widgety i modele UI.

## 6. Struktura pojedynczego feature'a

Wewnatrz feature'a warto trzymac porzadek w prosty sposob:

```text
features/home/
  data/
  presentation/
  state/
```

Lub szerzej:

```text
features/game_details/
  data/
    models/
    datasource/
    repository/
  state/
  presentation/
```

Nie trzeba od razu budowac czystej architektury w pelnym wydaniu. Wystarczy lekki i czytelny podzial.

## 7. Integracja z API

Rekomendacja:

- prosty klient HTTP,
- osobny plik z endpointami i kluczem API,
- osobne modele dla danych z RAWG,
- osobne repozytorium do pobierania list i szczegolow gier.

Przyklady danych pobieranych z API:

- lista gier,
- wyniki wyszukiwania,
- szczegoly gry,
- screenshoty,
- gatunki lub platformy.

## 8. Lokalny storage

Lokalnie warto przechowywac:

- ulubione gry,
- status gry,
- checkliste progresu,
- procent ukonczenia,
- opcjonalnie ostatnie wyszukiwania.

Mozliwe narzedzia:

- `shared_preferences` - najprostsze, dobre do malych danych,
- `Hive` - dobre do prostego lokalnego storage,
- `Isar` - mocniejsze, ale nadal wygodne rozwiazanie.

Na projekt studencki najprostszy wybor to zwykle `Hive` albo `shared_preferences`.

## 9. Zarzadzanie stanem

Najrozsadniejsze opcje do takiego projektu:

- `Riverpod`,
- `Provider`,
- `Bloc`.

Rekomendacja praktyczna:

- `Riverpod`, jesli chcesz miec nowoczesny i wygodny stan,
- `Provider`, jesli chcesz absolutne minimum,
- `Bloc`, jesli juz go znasz i chcesz bardziej formalna strukture.

Dla tego projektu najrozsadniej brzmi `Riverpod` albo `Provider`.

## 10. Nawigacja

Aplikacja powinna miec prosta nawigacje:

- `Splash -> Home`,
- `Home -> Search`,
- `Home -> Game Details`,
- `Game Details -> Progress Tracker`,
- `Home -> My Library`.

Mozna to zrobic przez:

- zwykla nawigacje Fluttera,
- albo `go_router`, jesli chcesz bardziej uporzadkowany routing.

Na start sensowny jest `go_router`, ale zwykla nawigacja tez wystarczy.

## 11. Obsluga stanow UI

Kazdy ekran oparty o dane powinien obslugiwac:

- `loading`,
- `success`,
- `empty`,
- `error`.

To jest wazne szczegolnie dla:

- home,
- search,
- game details,
- my library.

## 12. Animacje i warstwa wizualna

W projekcie warto wykorzystac animacje w trzech miejscach:

- splash screen,
- przejscie z listy do szczegolow gry,
- progress tracker i paski ukonczenia.

Nie trzeba przesadzac z liczba efektow. Lepiej zrobic kilka dopracowanych animacji niz duzo przypadkowych.

## 13. Rekomendowany minimalny stack

Praktyczny zestaw na ten projekt:

- `Flutter`,
- `dio` albo `http` do requestow,
- `Riverpod` albo `Provider` do stanu,
- `Hive` albo `shared_preferences` do local storage,
- `cached_network_image` do obrazow,
- `go_router` opcjonalnie do nawigacji.

## 14. Rekomendacja koncowa

Najprostsza i najzdrowsza architektura dla tego projektu to:

- Flutter bez backendu,
- RAWG jako zewnetrzne API,
- lokalny storage do danych uzytkownika,
- podzial kodu po feature'ach,
- prosty state management,
- nacisk na UI, animacje i czytelny przeplyw danych.

To da Ci projekt, ktory bedzie jednoczesnie efektowny, sensowny i wykonalny na studia.
