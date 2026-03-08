# ISSUE-C1-3 Implementation Plan

## Audit update

Status po przegladzie repo: `zaimplementowane`.

Dowody w kodzie:

- `go_router` jest dodany w `pubspec.yaml`,
- centralna mapa tras istnieje w `lib/core/navigation/app_routes.dart`,
- glowny router jest w `lib/core/navigation/app_router.dart`,
- `lib/app/app.dart` uruchamia `MaterialApp.router`,
- placeholder screens istnieja dla splasha, home, search, library i details,
- shell z trzema zakladkami jest juz podpiety.

Otwarte punkty:

- warto lokalnie klikac przeplyw i potwierdzic, ze routing zachowuje sie poprawnie po splashu,
- jesli chcesz miec tymczasowy, jawny trigger z placeholderow do `Game Details`, mozna go dopiac jako drobny follow-up, ale nie blokuje to `Cycle 2`.

## 1. Cel dokumentu

Ten dokument opisuje plan implementacji dla `ISSUE-C1-3 Define route map and placeholder screens` w `Cycle 1 - Foundation and Navigation`.

Plan rozwija zalozenia z `docs/05-delivery/cycle-1/README.md` i dopasowuje je do aktualnego stanu repozytorium Flutter, w ktorym routing i placeholderowe UI sa juz czesciowo obecne.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- miec jedno centralne miejsce definiowania tras aplikacji,
- miec jasno opisana strategie nawigacji oparta o `go_router`,
- miec placeholderowe ekrany dla splash, home, search, library i game details,
- umozliwiac przejscie od splasha do glownego shellu oraz do widoku szczegolow gry,
- byc gotowy pod dalsza implementacje shell navigation i feature screens bez przebudowy routingu.

## 3. Powiazanie z breakdownem Cycle 1

To issue zamyka:

- `TASK-6 Define route map and navigation strategy`,
- `TASK-7 Build placeholder screens for app shell`.

## 4. Aktualny stan repo

Repo nie startuje juz od zera - czesc rozwiazan zwiazanych z tym issue istnieje:

- `pubspec.yaml` zawiera juz zaleznosc `go_router`,
- `lib/core/navigation/app_routes.dart` definiuje podstawowe stale tras,
- `lib/core/navigation/app_router.dart` posiada router z trasami dla splash, shell branches i details,
- `lib/app/app.dart` uruchamia `MaterialApp.router`,
- istnieja placeholderowe ekrany w `lib/features/splash/presentation/`, `lib/features/home/presentation/`, `lib/features/search/presentation/`, `lib/features/library/presentation/` oraz `lib/features/game_details/presentation/`,
- `lib/app/app_shell.dart` osadza ekrany `Home`, `Search` i `Library` w dolnej nawigacji,
- `test/widget_test.dart` zawiera tylko prosty smoke test splasha.

To oznacza, ze `ISSUE-C1-3` powinno domknac i uporzadkowac istniejace podejscie, zamiast projektowac routing od nowa.

## 5. Zakres issue

### In scope

- potwierdzenie `go_router` jako podejscia do routingu w MVP,
- uporzadkowanie centralnej mapy tras i nazw odpowiedzialnosci poszczegolnych ekranow,
- doprecyzowanie przeplywu `Splash -> App Shell -> Game Details`,
- utrzymanie placeholderowych ekranow jako lekkich widokow bez logiki biznesowej,
- dopilnowanie, aby glowne ekrany mialy stabilne punkty zaczepienia do testow i dalszej rozbudowy,
- aktualizacja dokumentacji issue tak, aby kolejne prace mogly korzystac z jednego planu.

### Out of scope

- implementacja docelowych danych i integracji z API,
- rozbudowana logika wyszukiwania, biblioteki i szczegolow gry,
- finalne decyzje dotyczace deep linkingu i web support wykraczajace poza MVP,
- rozbudowany navigation state poza podstawowym shellem,
- dopracowanie finalnego UI splash animation i finalnego wygladu ekranow biznesowych.

## 6. Docelowy rezultat po implementacji

Po zamknieciu issue routing i placeholder screens powinny byc uporzadkowane wokol nastepujacej struktury:

```text
lib/
  app/
    app.dart
    app_shell.dart
  core/
    navigation/
      app_routes.dart
      app_router.dart
  features/
    splash/
      presentation/
        splash_screen.dart
    home/
      presentation/
        home_screen.dart
    search/
      presentation/
        search_screen.dart
    library/
      presentation/
        library_screen.dart
    game_details/
      presentation/
        game_details_screen.dart
test/
  widget_test.dart
```

W praktyce oznacza to, ze:

- `AppRoutes` jest jedynym miejscem dla sciezek tras,
- `AppRouter` spina caly flow aplikacji,
- placeholderowe ekrany reprezentuja docelowe sekcje produktu, ale nie zawieraja jeszcze prawdziwej logiki,
- testy moga sprawdzac start aplikacji i podstawowy routing bez zaleznosci od danych.

## 7. Strategia routingu i mapa tras

Rekomendowane podejscie dla tego issue:

- utrzymac `go_router`, bo jest juz dodany do projektu i dobrze pasuje do declarative navigation,
- trzymac stale sciezek w `lib/core/navigation/app_routes.dart`,
- trzymac konfiguracje tras w `lib/core/navigation/app_router.dart`,
- wykorzystac osobna trase dla splasha,
- wykorzystac shell route dla glownych zakladek aplikacji,
- utrzymac oddzielna trase dla `game details`, poniewaz jest to flow wychodzacy poza dolna nawigacje.

Docelowa mapa tras:

| Route | Sciezka | Rola |
| --- | --- | --- |
| Splash | `/` | krotki ekran startowy i wejscie do flow aplikacji |
| Home | `/home` | glowna sekcja odkrywania gier |
| Search | `/search` | punkt startowy pod wyszukiwanie |
| Library | `/library` | placeholder biblioteki uzytkownika |
| Game details | `/game/:id` | ekran szczegolow wybranej gry |

Docelowy przeplyw uzytkownika:

1. aplikacja startuje na `Splash`,
2. po zakonczeniu krotkiego onboardingowego wejscia przechodzi do `Home` w shellu,
3. uzytkownik moze przelaczac sie miedzy `Home`, `Search` i `Library`,
4. z ekranow list lub placeholderowych kart mozliwe jest przejscie do `Game details` po `id`.

## 8. Todo checklist

- [ ] potwierdzic `go_router` jako docelowy mechanizm nawigacji dla MVP,
- [ ] utrzymac `AppRoutes` jako centralna mape wszystkich tras uzywanych przez aplikacje,
- [ ] upewnic sie, ze `AppRouter` definiuje osobna trase dla splasha, shell branches i game details,
- [ ] opisac i utrzymac flow `Splash -> Home shell -> Details`,
- [ ] utrzymac placeholder `SplashScreen` jako osobny ekran startowy,
- [ ] utrzymac placeholder `HomeScreen` jako ekran glownej sekcji aplikacji,
- [ ] utrzymac placeholder `SearchScreen` jako ekran wejscia do wyszukiwania,
- [ ] utrzymac placeholder `LibraryScreen` jako ekran kolekcji uzytkownika,
- [ ] utrzymac placeholder `GameDetailsScreen` jako ekran docelowy dla trasy z parametrem `id`,
- [ ] dopilnowac, aby placeholdery nie wprowadzaly logiki biznesowej ani fake data modelu,
- [ ] zachowac stabilne teksty lub inne punkty zaczepienia potrzebne do smoke testow,
- [ ] zweryfikowac start aplikacji i podstawowy routing po zmianach.

## 9. Plan implementacji krok po kroku

### Step 1. Potwierdzic i opisac strategia routingu

Pliki:

- `pubspec.yaml`
- `lib/app/app.dart`
- `lib/core/navigation/app_router.dart`

Cel:

- zamknac decyzje architektoniczna, ze aplikacja korzysta z `MaterialApp.router` i `go_router`.

Do zrobienia:

- upewnic sie, ze nie ma rownoleglego podejscia opartego o reczny `Navigator`,
- utrzymac `AppRouter.router` jako pojedynczy router uzywany przez `App`,
- opisac w dokumencie, dlaczego to podejscie pasuje do flow z shellem i trasami z parametrem.

Rezultat:

- dalsze issues buduja na jednym, juz wybranym mechanizmie nawigacji.

### Step 2. Uporzadkowac centralna mape tras

Plik:

- `lib/core/navigation/app_routes.dart`

Cel:

- zebrac wszystkie sciezki tras w jednym miejscu i ograniczyc rozsypane stringi.

Do zrobienia:

- utrzymac stale dla `splash`, `home`, `search`, `library` i `gameDetails`,
- zadbac o czytelne nazewnictwo zgodne z sekcjami aplikacji,
- pozostawic `game/:id` jako pattern dla szczegolow gry.

Rezultat:

- routing ma jedno centralne zrodlo prawdy dla sciezek.

### Step 3. Utrzymac i doprecyzowac konfiguracje routera

Plik:

- `lib/core/navigation/app_router.dart`

Cel:

- jasno opisac, jak poszczegolne ekrany sa podpiete do flow aplikacji.

Do zrobienia:

- utrzymac start na `AppRoutes.splash`,
- utrzymac shell route dla `home`, `search` i `library`,
- utrzymac osobna trase dla `game details`,
- dopilnowac, aby `GameDetailsScreen` odbieral `id` z `pathParameters`,
- unikac umieszczania logiki biznesowej w konfiguracji routera.

Rezultat:

- przeplyw miedzy ekranami jest czytelny i gotowy do dalszej rozbudowy.

### Step 4. Utrzymac placeholder screens jako osobne reprezentacje feature'ow

Pliki:

- `lib/features/splash/presentation/splash_screen.dart`
- `lib/features/home/presentation/home_screen.dart`
- `lib/features/search/presentation/search_screen.dart`
- `lib/features/library/presentation/library_screen.dart`
- `lib/features/game_details/presentation/game_details_screen.dart`

Cel:

- przygotowac stabilny ekranowy szkielet aplikacji bez wchodzenia w finalna logike produktu.

Do zrobienia:

- utrzymac kazdy placeholder jako osobny widget ekranowy,
- zachowac sensowne nazwy i lokalizacje plikow pod przyszla architekture feature-based,
- pokazywac tylko lekki, orientacyjny UI potwierdzajacy role ekranu,
- nie dodawac jeszcze integracji z repozytoriami, API i storage ponad to, co jest konieczne dla startu aplikacji.

Rezultat:

- aplikacja posiada komplet podstawowych ekranow potrzebnych do end-to-end navigation smoke flow.

### Step 5. Osadzic placeholdery w app shell

Plik:

- `lib/app/app_shell.dart`

Cel:

- upewnic sie, ze glowna nawigacja prowadzi do wlasciwych sekcji aplikacji.

Do zrobienia:

- utrzymac trzy glowne destination tabs: `Home`, `Search`, `Library`,
- przypiac placeholderowe ekrany do odpowiednich branch roots,
- pozostawic shell jako prosty kontener nawigacyjny bez dodatkowej logiki domenowej.

Rezultat:

- po wyjsciu ze splasha uzytkownik trafia do dzialajacej struktury glownej aplikacji.

### Step 6. Utrzymac test startowy jako szybki smoke test

Plik:

- `test/widget_test.dart`

Cel:

- zachowac minimalna ochrone przed regresja przy starcie aplikacji.

Do zrobienia:

- renderowac `App`,
- sprawdzac stabilny element startowy, np. branding splasha,
- nie rozbudowywac testu do pelnego testu nawigacji end-to-end w tym issue.

Rezultat:

- repo posiada szybki test, ktory potwierdza podstawowy start aplikacji.

## 10. Kolejnosc wykonania

Rekomendowana kolejnosc prac:

1. potwierdzic decyzje o `go_router`,
2. uporzadkowac `app_routes.dart`,
3. doprecyzowac `app_router.dart`,
4. utrzymac placeholder screens,
5. osadzic placeholdery w `app_shell.dart`,
6. sprawdzic `test/widget_test.dart`,
7. wykonac szybki sanity check routingu.

Taka kolejnosc ogranicza ryzyko rozjazdu miedzy dokumentacja, routerem i placeholderowym UI.

## 11. Definition of done dla tego issue

Issue uznajemy za zakonczone, gdy:

- istnieje centralna mapa tras w `lib/core/navigation/app_routes.dart`,
- `lib/core/navigation/app_router.dart` opisuje pelny podstawowy flow aplikacji,
- aplikacja korzysta z `MaterialApp.router` i `go_router`,
- istnieja placeholderowe ekrany dla splash, home, search, library i game details,
- glowna nawigacja pozwala wejsc do sekcji `Home`, `Search` i `Library`,
- ekran `GameDetailsScreen` jest podpiety do trasy z parametrem `id`,
- test startowy przechodzi,
- kolejne issues moga rozwijac logike ekranow bez zmiany fundamentu routingu.

## 12. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter analyze`,
- `flutter test`.

Opcjonalnie:

- `flutter run` jako manualny smoke check przejscia `Splash -> Home`,
- manualne sprawdzenie nawigacji do `Search`, `Library` i `Game details`.

## 13. Ryzyka i decyzje implementacyjne

Najwazniejsze ryzyka:

- rozjechanie dokumentacji z aktualna implementacja routera,
- przeniesienie zbyt duzej ilosci logiki do placeholder screens,
- mieszanie odpowiedzialnosci miedzy shell navigation a routingiem feature'ow,
- zbyt wczesne komplikowanie routingu przed realnymi wymaganiami biznesowymi.

Rekomendowane decyzje:

- utrzymac `go_router` jako jedyne podejscie,
- utrzymac prosty zestaw tras bez named routes, jesli nie sa jeszcze potrzebne,
- traktowac placeholder screens jako cienkie widoki prezentacyjne,
- rozwijac dalsze flow na bazie istniejacego shella zamiast przepisywac routing przy kazdym issue.

## 14. Rekomendacja wykonawcza

To issue powinno byc traktowane jako domkniecie fundamentu nawigacyjnego dla MVP. Najwazniejsze jest tutaj uporzadkowanie jednej mapy tras, jednego routera i kompletu placeholderowych ekranow, tak aby kolejne issues mogly skupic sie na realnych feature'ach, a nie na przepinaniu struktury aplikacji.
