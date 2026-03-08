# ISSUE-C2-1 Implementation Plan

## 1. Cel dokumentu

Ten dokument opisuje plan implementacji dla `ISSUE-C2-1 Build discovery lists and search flow` w `Cycle 2 - Discovery Core`.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- wyswietlac realne dane na ekranie `Home`,
- umozliwiac wyszukiwanie gier po nazwie,
- miec wspolna warstwe danych dla discovery,
- obslugiwac `loading`, `empty` i `error` dla `Home` oraz `Search`,
- miec wspolne karty lub komponenty listowe do dalszego reuzytu.

## 3. Aktualny stan repo

Repo ma juz potrzebny foundation:

- `RAWG` client i DTO istnieja,
- routing i shell sa gotowe,
- `HomeScreen` i `SearchScreen` sa nadal placeholderami,
- nie ma jeszcze realnego repository layer dla discovery,
- nie ma jeszcze realnego stanu ekranow opartego o dane z API.

To oznacza, ze to issue powinno zamienic placeholderowy discovery flow w pierwszy dzialajacy fragment produktu.

## 4. Zakres issue

### In scope

- uporzadkowanie struktury `home` i `search` pod `data`, `state`, `presentation`,
- dodanie repository layer dla list i wyszukiwania,
- wykorzystanie istniejacego `RawgApiClient` w warstwie danych,
- zbudowanie prostego stanu asynchronicznego dla ekranow discovery,
- implementacja realnego `Home` na danych z API,
- implementacja realnego `Search` na danych z API,
- obsluga `loading`, `empty`, `error` i retry,
- dodanie wspolnej karty gry lub list item dla discovery.

### Out of scope

- finalny ekran `Game Details`,
- dodawanie do biblioteki,
- progress tracker,
- zaawansowane filtry,
- paginacja i nieskonczone listy, jesli nie sa potrzebne do pierwszej wersji,
- rozbudowany caching offline.

## 5. Docelowy rezultat po implementacji

Po zamknieciu issue discovery powinno wygladac mniej wiecej tak:

```text
features/
  home/
    data/
    presentation/
    state/
  search/
    data/
    presentation/
    state/
shared/
  widgets/
    game_card.dart
```

Nie chodzi o idealna architekture clean architecture, tylko o czytelny podzial, w ktorym:

- widgety nie robia requestow bezposrednio,
- dane sa pobierane przez warstwe posrednia,
- stany ekranow sa jawne i przewidywalne.

## 6. Plan implementacji krok po kroku

### Step 1. Dodac repository layer dla discovery

Cel:

- oddzielic `Home` i `Search` od bezposredniej wiedzy o `RawgApiClient`.

Do zrobienia:

- przygotowac repozytorium dla list gier i wyszukiwania,
- schowac szczegoly endpointow za prostym API repozytorium,
- przewidziec latwe wykorzystanie tego samego repository w `Game Details`.

### Step 2. Dodac prosty model stanu dla ekranow discovery

Cel:

- miec jedno podejscie do `loading`, `data`, `empty`, `error`.

Do zrobienia:

- przygotowac kontroler, notifier albo prosty state object,
- przewidziec retry i refresh,
- unikac lokalnych, niespojnych booli w wielu widgetach.

### Step 3. Zmienic `HomeScreen` z placeholdera na realny ekran discovery

Cel:

- pokazac prawdziwe listy gier zamiast sekcji `coming soon`.

Do zrobienia:

- wybrac prosty MVP zakres, np. `Trending` i `Popular` albo jedna lista z sensowna nazwa sekcji,
- podpiac pobieranie danych po starcie ekranu,
- dodac pull-to-refresh lub prosty przycisk retry,
- pokazac komunikat bledu, gdy API nie odpowie.

### Step 4. Zbudowac wspolna karte gry

Cel:

- nie duplikowac UI miedzy `Home` i `Search`.

Do zrobienia:

- pokazac minimum: nazwa, obraz, rating lub data premiery,
- utrzymac karte klikalna pod details,
- zapewnic sensowny fallback bez obrazu.

### Step 5. Zmienic `SearchScreen` z placeholdera na realne wyszukiwanie

Cel:

- dowiezc pierwszy interaktywny flow discovery.

Do zrobienia:

- podpiac pole tekstowe do requestow,
- dodac debounce,
- pokazac poczatkowy stan, loading, wyniki, pusty stan i error,
- ograniczyc agresywne odpytywanie API przy kazdym znaku bez kontroli.

### Step 6. Posprzatac placeholdery i dopracowac testowalne punkty zaczepienia

Cel:

- zostawic stabilny i przewidywalny discovery flow.

Do zrobienia:

- usunac techniczne teksty `coming soon` z `Home` i `Search`,
- zostawic czytelne teksty dla empty state i error state,
- dopasowac widget testy lub smoke testy, jesli beda potrzebne.

## 7. Kryteria akceptacji

Issue uznajemy za zamkniete, jesli:

- `Home` pobiera i wyswietla realne dane z `RAWG`,
- `Search` pobiera i wyswietla realne wyniki po wpisaniu nazwy,
- `Home` i `Search` obsluguja `loading`, `empty` i `error`,
- istnieje wspolny komponent karty lub list item dla gry,
- logika requestow nie siedzi bezposrednio w glownej warstwie widgetow,
- kod jest gotowy pod podpienie `Game Details` w kolejnym issue.

## 8. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter analyze`,
- `flutter test`,
- `flutter run --dart-define=RAWG_API_KEY=...`,
- manualne sprawdzenie `Home`,
- manualne sprawdzenie `Search`,
- manualne sprawdzenie sytuacji pustych wynikow i bledu API.

## 9. Ryzyka i decyzje implementacyjne

- Nie warto teraz budowac bardzo ciezkiego systemu stanu, jesli prostsze podejscie wystarczy.
- Lepiej dowiezc jedna dobra lista na `Home` niz trzy sekcje z polowiczna jakoscia.
- Debounce w `Search` jest wazny, bo bez niego szybko pojawi sie nadmiar requestow.
- Wspolna karta gry da duzo wartosci, bo zaraz bedzie potrzebna tez w details navigation.

## 10. Rekomendacja wykonawcza

To issue powinno dowiezc pierwszy prawdziwy kontakt uzytkownika z danymi. Jesli po jego zamknieciu `Home` i `Search` beda dzialaly na realnym API z sensownymi stanami, to `Cycle 2` bedzie juz dobrze rozpedzony.
