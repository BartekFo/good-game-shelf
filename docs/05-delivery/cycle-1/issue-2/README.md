# ISSUE-C1-2 Implementation Plan

## Audit update

Status po przegladzie repo: `zaimplementowane`.

Dowody w kodzie:

- tokeny istnieja w `lib/core/theme/app_colors.dart`, `lib/core/theme/app_spacing.dart`, `lib/core/theme/app_radius.dart` i `lib/core/theme/app_shadows.dart`,
- `ThemeData` jest zebrane w `lib/core/theme/app_theme.dart`,
- `lib/app/app.dart` korzysta z `AppTheme.light`,
- splash, shell i placeholderowe ekrany uzywaja wspolnego foundation stylistycznego.

Otwarte punkty:

- zostaje tylko lokalna walidacja wizualna na emulatorze lub urzadzeniu,
- ewentualne dalsze dopieszczanie wygladu nie jest juz blockerem dla `Cycle 2`.

## 1. Cel dokumentu

Ten dokument opisuje dokladny plan implementacji dla `ISSUE-C1-2 Create theme and design tokens` w `Cycle 1 - Foundation and Navigation`.

Plan rozwija zalozenia z `docs/05-delivery/cycle-1/README.md` i dopasowuje je do aktualnego stanu repozytorium Flutter.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- miec jeden spojny zestaw design tokens dla bazowego UI,
- miec gotowy `light theme` oparty o wspolne tokeny,
- stosowac wspolny styl dla scaffoldow, app bara, przyciskow i pol tekstowych,
- korzystac z tego samego theme w splashu, shellu aplikacji i ekranach placeholderowych,
- ograniczyc przypadkowe wartosci kolorow, spacingu i radiusow w warstwie UI.

## 3. Powiazanie z breakdownem Cycle 1

To issue zamyka:

- `TASK-4 Create base color palette and design tokens`,
- `TASK-5 Build application theme`.

## 4. Aktualny stan repo

Repo posiada juz wstepna implementacje warstwy wizualnej:

- istnieja pliki `lib/core/theme/app_colors.dart`, `lib/core/theme/app_spacing.dart`, `lib/core/theme/app_radius.dart`, `lib/core/theme/app_shadows.dart`,
- istnieje `lib/core/theme/app_theme.dart` i jest podpiete w `lib/app/app.dart`,
- splash korzysta czesciowo z `AppColors`,
- placeholderowe ekrany oraz shell aplikacji nadal sa bardzo bazowe i nie pokazuja pelnego wykorzystania wspolnego theme.

To oznacza, ze `ISSUE-C1-2` nie startuje od zera. Gownym celem jest uporzadkowanie i domkniecie istniejacej implementacji tak, aby rzeczywiscie spelniac kryteria `TASK-4` i `TASK-5`.

## 5. Zakres issue

### In scope

- dopracowanie palety kolorow i nadanie jej spójnych rol semantycznych,
- utrzymanie i wykorzystanie wspolnych tokenow spacing, radius i shadows,
- rozbudowa `AppTheme.light` jako glownego zrodla `ThemeData`,
- ustawienie typography dla aplikacji,
- ustawienie `AppBarTheme`, `InputDecorationTheme`, `ElevatedButtonThemeData`,
- dodanie podstawowego theme dla elementow shella, w tym `NavigationBar`,
- usuniecie najwazniejszych hardcodowanych wartosci wizualnych z glownego przeplywu placeholderowego UI,
- aktualizacja testu widgetowego tak, aby dalej weryfikowal poprawny start aplikacji po zmianach theme.

### Out of scope

- dark mode,
- zewnetrzne font packages i branding wykraczajacy poza bazowy foundation,
- rozbudowany design system dla wszystkich przyszlych komponentow,
- przebudowa architektury routingu,
- implementacja docelowych ekranow biznesowych,
- animacje inne niz te juz niezbedne dla splasha.

## 6. Docelowy rezultat po implementacji

Po zamknieciu issue warstwa `core/theme/` powinna byc czytelnym foundation dla kolejnych ekranow i feature'ow:

```text
lib/
  core/
    theme/
      app_colors.dart
      app_spacing.dart
      app_radius.dart
      app_shadows.dart
      app_theme.dart
```

W praktyce oznacza to, ze:

- kolory i wartosci layoutowe sa definiowane centralnie,
- `lib/app/app.dart` korzysta z jednego wspolnego `AppTheme.light`,
- splash, shell i placeholder screens wygladaja jak czesci jednej aplikacji,
- nowe UI w kolejnych issues moze budowac na gotowym zestawie tokenow bez dalszego porzadkowania foundation.

## 7. Plan implementacji krok po kroku

### Step 1. Zrobic audyt istniejacych tokenow i ograniczyc je do realnych potrzeb UI

Pliki:

- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_spacing.dart`
- `lib/core/theme/app_radius.dart`
- `lib/core/theme/app_shadows.dart`

Cel:

- upewnic sie, ze warstwa tokenow opisuje wspolne decyzje wizualne, a nie przypadkowy zestaw stalych.

Do zrobienia:

- sprawdzic, ktore tokeny juz istnieja i sa sensowne,
- utrzymac skale spacingu jako podstawowe odstepy dla layoutu,
- utrzymac skale radiusow dla pol tekstowych, kart i pill shapes,
- doprecyzowac palette kolorow pod role typu `primary`, `accent`, `background`, `surface`, `text`, `muted`, `border`, `success`, `warning`, `error`,
- zostawic tylko praktyczne shadows lub poziomy elevation, ktore beda faktycznie uzywane.

Rezultat:

- `core/theme/` zawiera lekki, ale czytelny zestaw tokenow gotowy do reuzycia.

### Step 2. Zbudowac docelowy `light theme` jako centralny punkt stylowania aplikacji

Plik:

- `lib/core/theme/app_theme.dart`

Cel:

- rozbudowac aktualne `ThemeData`, aby bylo jednym miejscem konfiguracji bazowego wygladu aplikacji.

Do zrobienia:

- ustawic `ColorScheme` zgodny z ustalonymi tokenami,
- ustawic `scaffoldBackgroundColor`, `surface`, `onSurface` i kolory akcentowe,
- dodac jawna typography zamiast polegac glownie na domyslnych wartosciach Material,
- skonfigurowac `AppBarTheme`,
- skonfigurowac `InputDecorationTheme`,
- skonfigurowac `ElevatedButtonThemeData`,
- w razie potrzeby dodac `OutlinedButtonThemeData`, `CardThemeData` i `NavigationBarThemeData`, jesli sa potrzebne do spójnego foundation.

Rezultat:

- aplikacja posiada jeden wspolny `light theme`, z ktorego korzystaja wszystkie glowne ekrany i komponenty startowe.

### Step 3. Podlaczyc tokeny i theme do splash screen

Plik:

- `lib/features/splash/presentation/splash_screen.dart`

Cel:

- usunac dryf wizualny miedzy splashem a reszta aplikacji.

Do zrobienia:

- ograniczyc hardcodowane kolory i odstepy,
- oprzec teksty i spacing na tokenach oraz `Theme.of(context)`,
- zachowac obecna animacje, ale osadzic ja w spojnosc wizualna aplikacji.

Rezultat:

- splash jest nadal prosty, ale wyglada jak element tego samego systemu wizualnego co dalsze ekrany.

### Step 4. Ujednolicic shell aplikacji i nawigacje dolna

Plik:

- `lib/app/app_shell.dart`

Cel:

- sprawic, aby shell aplikacji stal sie pierwszym realnym odbiorca wspolnego theme.

Do zrobienia:

- dopilnowac, by scaffold i app bary korzystaly z theme zamiast lokalnych decyzji wizualnych,
- ostylowac `NavigationBar` przez theme lub lekkie dopiecie lokalne zgodne z tokenami,
- utrzymac prosty placeholderowy charakter, ale z wyraznym wspolnym foundation.

Rezultat:

- dolna nawigacja i scaffoldy wygladaja spojnie i sa gotowe pod kolejne ekrany.

### Step 5. Zmienic placeholder screens tak, aby pokazywaly wspolny design foundation

Pliki:

- `lib/features/home/presentation/home_screen.dart`
- `lib/features/search/presentation/search_screen.dart`
- `lib/features/library/presentation/library_screen.dart`
- `lib/features/game_details/presentation/game_details_screen.dart`

Cel:

- sprawic, aby placeholdery potwierdzaly, ze aplikacja faktycznie korzysta z jednego theme, a nie tylko z domyslnego Material UI.

Do zrobienia:

- zastapic gole `Center + Text` prostymi, ale tematycznymi ukladami,
- korzystac ze wspolnych text styles, spacingu, radiusow i surface colors,
- zachowac minimalny zakres bez implementowania logiki docelowych ekranow.

Rezultat:

- placeholderowe ekrany sa nadal lekkie, ale wizualnie spojne i oparte na theme.

### Step 6. Zaktualizowac test widgetowy po zmianach theme

Plik:

- `test/widget_test.dart`

Cel:

- utrzymac prosty test gwarantujacy, ze aplikacja nadal startuje poprawnie po rozbudowie theme.

Do zrobienia:

- zweryfikowac, jaki ekran i jaki tekst sa najstabilniejszym punktem zaczepienia dla testu,
- dopasowac asercje do aktualnego flow startowego z routingiem i splashem,
- utrzymac test jako szybki smoke test, a nie szczegolowy test stylistyczny.

Rezultat:

- repo nadal posiada podstawowa ochrone przed regresja przy starcie aplikacji.

## 8. Kolejnosc wykonania

Rekomendowana kolejnosc prac:

1. uporzadkowac tokeny w `core/theme/`,
2. rozbudowac `AppTheme.light`,
3. podlaczyc theme do splasha,
4. ujednolicic shell i placeholder screens,
5. zaktualizowac test,
6. uruchomic `flutter test`.

Taka kolejnosc minimalizuje ryzyko cofania zmian, bo najpierw stabilizuje foundation, a dopiero potem ekrany, ktore z niego korzystaja.

## 9. Definition of done dla tego issue

Issue uznajemy za zakonczone, gdy:

- istnieje jeden spojny zestaw tokenow w `lib/core/theme/`,
- `lib/core/theme/app_theme.dart` definiuje gotowy `light theme`,
- glowne placeholderowe UI nie korzysta z przypadkowych wartosci wizualnych,
- splash, shell i placeholder screens dziela ten sam foundation stylistyczny,
- test widgetowy przechodzi po zmianach,
- kolejne issues moga budowac UI bez ponownego porzadkowania podstaw theme.

## 10. Ryzyka i decyzje projektowe

Najwazniejsze ryzyka:

- przesadne rozbudowanie tokenow za wczesnie,
- dodanie zbyt wielu abstrakcji, ktore nie sa jeszcze potrzebne,
- pozostawienie rozjazdu miedzy splashem a shellowym UI,
- problemy testowe wynikajace z routingu i czasu przejscia splasha.

Rekomendowane decyzje:

- utrzymac scope na `light theme`,
- nie dodawac dark mode w tym issue,
- nie dokladac zewnetrznych fontow, jesli nie sa konieczne,
- preferowac semantic tokens i praktyczne component theming zamiast szerokiego, niedojrzalego design systemu.
