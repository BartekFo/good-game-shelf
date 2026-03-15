# ISSUE-C2-3 Implementation Plan

## 1. Cel dokumentu

Ten dokument opisuje plan implementacji dla `ISSUE-C2-3 Complete Game Details integration and fix discovery issues` w `Cycle 2 - Discovery Core`.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- miec pelna integracje danych na ekranie `Game Details`,
- dodac state management dla `GameDetailsScreen`,
- naprawic bug z duplikacja sekcji "Recently Released" na `Home`,
- dodac brakujace stany loading/error dla `Game Details`,
- domknac wszystkie braki z Cycle 2 przed przejsciem do Cycle 3.

## 3. Aktualny stan repo

Repo ma juz gotowy discovery flow z `ISSUE-C2-1` i `ISSUE-C2-2`:

- ✅ `Home` i `Search` dzialaja na realnych danych,
- ✅ routing do `Game Details` dziala,
- ✅ `RawgApiClient.fetchGameDetails()` istnieje,
- ⚠️ `GameDetailsScreen` to tylko UI placeholder - nie pobiera realnych danych,
- ⚠️ brak state management dla details screen,
- ⚠️ sekcja "Recently Released" na `Home` pokazuje te same dane co "Popular" (copy-paste bug).

To oznacza, ze ten issue ma domknac ostatnie dziury w discovery flow przed `Cycle 3`.

## 4. Zakres issue

### In scope

- dodanie `GameDetailsNotifier` z state management,
- podlaczenie `RawgApiClient.fetchGameDetails()` do ekranu,
- wyswietlanie realnych danych gry: tytul, opis, rating, platformy, gatunki, data premiery,
- obsluga stanow `loading`, `error` i retry dla details,
- naprawienie bug'a z sekcja "Recently Released" na `Home`,
- dodanie fallback'ow dla brakujacych obrazow lub danych,
- opcjonalnie: dodanie screenshotow lub carousel'a grafik (jesli scope pozwoli).

### Out of scope

- funkcjonalna akcja "Add to Library" - to bedzie w `Cycle 3`,
- zapisywanie do biblioteki,
- progress tracker,
- zaawansowane filtry,
- paginacja w details,
- offline cache.

## 5. Docelowy rezultat po implementacji

Po zamknieciu issue discovery flow powinien wygladac tak:

1. uzytkownik klika gre z `Home` lub `Search`,
2. przechodzi do `Game Details` z poprawnym `id`,
3. ekran pokazuje loading spinner,
4. po odpowiedzi API wyswietla prawdziwe szczegoly gry:
   - hero image (background_image),
   - tytul,
   - rating,
   - date premiery,
   - platformy (chips),
   - gatunki (chips),
   - opis (description_raw),
5. w razie bledu pokazuje czytelny komunikat i przycisk retry,
6. `Home` pokazuje rozne dane w sekcjach "Popular" i "Recently Released".

## 6. Zidentyfikowane braki i bugs

### Bug 1: "Recently Released" pokazuje te same dane co "Popular"

Lokalizacja:

- `lib/features/home/state/home_notifier.dart:34-35`

Przyczyna:

- copy-paste w metodzie `loadGames()`:

```dart
final trendingGames = await _discoveryRepository.getTrendingGames();
final popularGames = await _discoveryRepository.getTrendingGames(); // <-- BUG!
```

Rozwiazanie:

- zmienic druga linie na `getRecentlyReleasedGames()` lub podobna metode,
- jesli endpoint nie istnieje, dodac nowa metode do `DiscoveryRepository` i `RawgApiClient`.

### Brak 1: GameDetailsScreen nie pobiera danych

Lokalizacja:

- `lib/features/game_details/presentation/game_details_screen.dart`

Przyczyna:

- ekran to tylko statyczny UI placeholder,
- brak notifier'a,
- brak wywolan API.

Rozwiazanie:

- stworzyc `GameDetailsNotifier` z `AsyncState<RawgGameDetailsDto>`,
- podpiac do `RawgApiClient.fetchGameDetails(id)`,
- podmieniac UI w zaleznosci od stanu (loading/data/error).

### Brak 2: Game Details nie ma state management

Lokalizacja:

- brak folderu `lib/features/game_details/state/`

Rozwiazanie:

- stworzyc `game_details_notifier.dart`,
- uzywac tego samego patternu co `HomeNotifier` i `SearchNotifier`,
- obsluga stanow: loading, data, error,
- dodac metode `retry()`.

### Brak 3: Brak ladowania stanow UI na details

Lokalizacja:

- `GameDetailsScreen` nie renderuje loading/error states

Rozwiazanie:

- dodac `AsyncStateBuilder` lub manualny switch po stanach,
- pokazac `CircularProgressIndicator` podczas loading,
- pokazac error message + retry button przy bledzie,
- renderowac pelny UI tylko przy AsyncData.

## 7. Plan implementacji krok po kroku

### Step 1. Naprawic bug z "Recently Released" na Home

Cel:

- kazda sekcja na `Home` powinna pokazywac inne dane.

Do zrobienia:

- sprawdzic czy `DiscoveryRepository` ma metode dla "recently released",
- jesli nie ma, dodac nowy endpoint w `RawgApiClient` (np. `fetchRecentlyReleasedGames()`),
- zmienic `HomeNotifier.loadGames()` zeby uzywala roznych metod dla kazdej sekcji,
- upewnic sie, ze dane sie nie powtarzaja.

### Step 2. Stworzyc GameDetailsNotifier

Cel:

- wydzielic logike pobierania szczegolow poza widget.

Do zrobienia:

- stworzyc `lib/features/game_details/state/game_details_notifier.dart`,
- dodac pole `AsyncState<RawgGameDetailsDto> state`,
- dodac metode `loadGameDetails(int id)`,
- dodac metode `retry()`,
- uzyc `RawgApiClient.fetchGameDetails(id)`,
- obsluzyc bledy i ustawic odpowiedni state.

### Step 3. Podlaczyc GameDetailsNotifier do dependency injection

Cel:

- dostepnosc notifier'a w widgecie.

Do zrobienia:

- dodac singleton `GameDetailsNotifier` w `lib/core/navigation/app_router.dart` lub osobnym DI file,
- przekazac do `GameDetailsScreen` przez konstruktor lub provider.

### Step 4. Przepisac GameDetailsScreen na realne dane

Cel:

- zamienic placeholder na ekran pokazujacy prawdziwe szczegoly.

Do zrobienia:

- dodac `ListenableBuilder` lub podobny mechanizm nasluchu na `GameDetailsNotifier`,
- renderowac rozne UI w zaleznosci od stanu:
  - `AsyncLoading`: pokaz `CircularProgressIndicator`,
  - `AsyncData`: renderuj szczegoly gry,
  - `AsyncError`: pokaz komunikat bledu i przycisk retry,
- zachowac `SliverAppBar` z hero image,
- wyswietlic: tytul, rating, date premiery, platformy (chips), gatunki (chips), opis.

### Step 5. Dodac fallbacki dla brakujacych danych

Cel:

- nie psuc UI przy niepelnych danych z API.

Do zrobienia:

- jesli brak `background_image`: pokaz placeholder color lub asset,
- jesli brak `description_raw`: pokaz "No description available",
- jesli puste listy `platforms` lub `genres`: nie renderuj sekcji chips,
- upewnic sie, ze dlugie opisy nie wylazaja poza ekran (Expanded, flexible).

### Step 6. Opcjonalnie: dodac screenshots carousel

Cel:

- wizualnie wzbogacic ekran details.

Do zrobienia (tylko jesli scope pozwoli):

- wykorzystac pole `screenshots` z API (jesli istnieje),
- dodac poziomy scroll z miniaturami,
- alternatywnie: ograniczyc sie tylko do hero image.

### Step 7. Smoke test i weryfikacja

Cel:

- upewnic sie, ze caly discovery flow dziala end-to-end.

Do zrobienia:

- przetestowac przejscie `Home -> Details`,
- przetestowac przejscie `Search -> Details`,
- sprawdzic zachowanie przy bledie API (np. zly ID gry),
- sprawdzic retry po bledzie,
- sprawdzic czy "Recently Released" pokazuje inne dane niz "Popular".

## 8. Kryteria akceptacji

Issue uznajemy za zamkniete, jesli:

- `GameDetailsScreen` pobiera i wyswietla realne dane z `RAWG API`,
- ekran obsluguje stany `loading`, `error` i `retry`,
- ekran wyswietla: tytul, hero image, rating, date premiery, platformy, gatunki, opis,
- sekcja "Recently Released" na `Home` pokazuje inne gry niz "Popular",
- fallbacki dla brakujacych danych dzialaja poprawnie,
- `Home -> Details` i `Search -> Details` dzialaja stabilnie,
- kod jest gotowy pod `Cycle 3` (zapisywanie do biblioteki).

## 9. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter analyze`,
- `flutter test`,
- `flutter run --dart-define=RAWG_API_KEY=...`,
- manualny smoke test:
  - `Home -> Details` (kliknij Popular game),
  - `Home -> Details` (kliknij Recently Released game - sprawdz czy to inna gra),
  - `Search -> Details`,
  - Blad API (wpisz niepoprawne ID lub wylacz internet) -> retry.

## 10. Ryzyka i decyzje implementacyjne

- Nie warto przeinwestowac w bardzo rozbudowane UI details przed `Cycle 3`,
- Jesli screenshoty sa czasochlonne, priorytet ma solidny hero image i komplet podstawowych metadanych,
- Bug z "Recently Released" jest latwy do naprawy - wystarczy dodac nowy endpoint lub zmienic parametry,
- Notifier pattern powinien byc taki sam jak w `Home` i `Search` dla spojnosci.

## 11. Proponowana struktura kodu po implementacji

```
lib/
  features/
    game_details/
      state/
        game_details_notifier.dart    # NEW
      presentation/
        game_details_screen.dart       # UPDATED
  core/
    network/
      rawg_api_client.dart             # UPDATED (jesli dodamy nowy endpoint)
    models/
      rawg_game_details_dto.dart       # EXISTING
  features/
    home/
      state/
        home_notifier.dart               # UPDATED (fix bug)
```

## 12. Rekomendacja wykonawcza

To issue ma domknac ostatnie braki w `Cycle 2` przed przejsciem do `Cycle 3`. Priorytet to:

1. naprawienie bug'a z "Recently Released",
2. dodanie state management dla `Game Details`,
3. wyswietlanie realnych danych na ekranie szczegolow.

Jesli ten issue zostanie zamkniety, `Cycle 2 - Discovery Core` bedzie w pelni gotowy, a `Cycle 3` (Library & Progress) bedzie moglo wystartowac bez blokerow.
