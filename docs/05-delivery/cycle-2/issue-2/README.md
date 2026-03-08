# ISSUE-C2-2 Implementation Plan

## 1. Cel dokumentu

Ten dokument opisuje plan implementacji dla `ISSUE-C2-2 Build game details and connect discovery navigation` w `Cycle 2 - Discovery Core`.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- pozwalac wejsc z `Home` i `Search` do `Game Details`,
- pobierac szczegoly gry po `id`,
- wyswietlac realne dane na ekranie szczegolow,
- obslugiwac `loading`, `error` i retry na ekranie szczegolow,
- domknac pierwszy pelny flow discovery od listy do szczegolow.

## 3. Aktualny stan repo

Repo ma juz trase `game/:id` i placeholder `GameDetailsScreen`, ale ekran szczegolow nie jest jeszcze podpiety do realnego pobierania danych. To znaczy, ze routing foundation jest gotowy, ale flow produktowy nie jest jeszcze domkniety.

## 4. Zakres issue

### In scope

- podpiecie kart `Home` i wynikow `Search` do przejscia na trase szczegolow,
- dodanie repository i stanu dla `Game Details`,
- pobieranie szczegolow gry po `id`,
- wyswietlenie podstawowych danych: nazwa, grafika, opis, rating, data premiery, platformy, gatunki,
- obsluga `loading`, `error` i retry,
- dopracowanie fallbackow dla brakujacych danych lub obrazow,
- lekki polish details tak, aby ekran nadawal sie do pokazania.

### Out of scope

- zapisywanie gry do biblioteki jako dzialajaca funkcja,
- status gry i progress tracker,
- rozbudowane rekomendacje podobnych gier,
- bardzo rozbudowane galerie screenshotow, jesli mialyby mocno rozsadzic scope,
- offline cache szczegolow.

## 5. Docelowy rezultat po implementacji

Po zamknieciu issue discovery flow powinien wygladac tak:

1. uzytkownik widzi liste gier na `Home` albo wyniki `Search`,
2. klika wybrana gre,
3. router przechodzi do `Game Details` z poprawnym `id`,
4. ekran pokazuje loading,
5. po odpowiedzi API wyswietla szczegoly gry,
6. w razie bledu pokazuje czytelny komunikat i retry.

## 6. Plan implementacji krok po kroku

### Step 1. Podpiac akcje przejscia do szczegolow

Cel:

- umozliwic wejscie do `Game Details` z miejsc, gdzie pokazywane sa gry.

Do zrobienia:

- dopiac `onTap` do wspolnych kart gry,
- wykorzystac istniejacy router i trase `game/:id`,
- upewnic sie, ze identyfikator gry jest zawsze przekazywany poprawnie.

### Step 2. Dodac warstwe danych dla szczegolow gry

Cel:

- wydzielic pobieranie szczegolow poza widget.

Do zrobienia:

- dodac metode repozytorium dla `fetchGameDetails`,
- oprzec ja na istniejacym `RawgApiClient`,
- przewidziec latwe rozszerzenie o screenshoty lub podobne dane.

### Step 3. Dodac stan ekranu szczegolow

Cel:

- uniknac mieszania requestu, mapowania i renderowania w jednym miejscu.

Do zrobienia:

- przygotowac prosty kontroler lub state object dla details,
- obsluzyc `loading`, `success`, `error`,
- dodac prosty retry.

### Step 4. Zamienic `GameDetailsScreen` w realny ekran danych

Cel:

- pokazac faktyczna wartosc dla wybranej gry.

Do zrobienia:

- wyrenderowac nazwe gry,
- pokazac obraz hero lub fallback,
- pokazac opis,
- pokazac rating i date premiery,
- pokazac platformy i gatunki,
- zadbac o czytelnosc przy dluzszym opisie.

### Step 5. Dopracowac fallbacki i edge cases

Cel:

- nie psuc ekranu przy brakach w odpowiedzi API.

Do zrobienia:

- obsluzyc brak obrazu,
- obsluzyc brak opisu lub pustych list platform i gatunkow,
- utrzymac czytelny layout przy dlugich tekstach.

### Step 6. Dopracowac koniec discovery flow

Cel:

- zostawic ekran gotowy pod `Cycle 3`.

Do zrobienia:

- utrzymac placeholder akcji typu `Add to Library` jako UI-only albo usunac go, jesli myli co do gotowosci funkcji,
- przygotowac miejsce pod przyszle zapisanie gry,
- upewnic sie, ze ekran nie wymaga przebudowy przy starcie `Cycle 3`.

## 7. Kryteria akceptacji

Issue uznajemy za zamkniete, jesli:

- z `Home` i `Search` da sie wejsc do `Game Details`,
- `Game Details` pobiera dane po `id`,
- ekran pokazuje nazwe, opis, rating, date premiery, platformy i gatunki,
- ekran obsluguje `loading`, `error` i retry,
- fallbacki dla brakujacych danych nie rozwalaja UI,
- discovery flow od listy do szczegolow jest gotowy do demo.

## 8. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter analyze`,
- `flutter test`,
- `flutter run --dart-define=RAWG_API_KEY=...`,
- manualne sprawdzenie przejscia `Home -> Details`,
- manualne sprawdzenie przejscia `Search -> Details`,
- manualne sprawdzenie bledu API i retry na details.

## 9. Ryzyka i decyzje implementacyjne

- Nie warto przeinwestowac w details screen przed `Cycle 3`; ma byc dobry, ale nadal MVP.
- Jesli screenshoty okaza sie czasochlonne, priorytet ma solidny hero image i komplet podstawowych metadanych.
- Akcja `Add to Library` nie powinna udawac gotowej funkcji, jesli zapis nie jest jeszcze podpiety.

## 10. Rekomendacja wykonawcza

To issue ma domknac najwazniejszy flow produktowy dla prezentacji: uzytkownik odkrywa gre, klika i widzi sensowne szczegoly. Jesli ten przeplyw dziala stabilnie, `Cycle 2` mozna uznac za udany.
