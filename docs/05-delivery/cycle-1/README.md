# Cycle 1 Foundation Breakdown

## Status audytu implementacji

Ten folder nie opisuje juz tylko planu. Po przegladzie aktualnego kodu `Cycle 1` jest w praktyce w wiekszosci zaimplementowany, a dokumentacja byla czesciowo do tylu wzgledem repo.

Aktualny status per issue:

- `ISSUE-C1-1 Clean app bootstrap and folder structure` - prawie domkniete.
- `ISSUE-C1-2 Create theme and design tokens` - zaimplementowane.
- `ISSUE-C1-3 Setup routing and placeholder screens` - zaimplementowane.
- `ISSUE-C1-4 Build app shell navigation` - zaimplementowane.
- `ISSUE-C1-5 Setup RAWG API foundation` - zaimplementowane z drobnymi punktami do weryfikacji.
- `ISSUE-C1-6 Setup local storage foundation` - zaimplementowane.
- `ISSUE-C1-7 Build animated splash and transition` - zaimplementowane.
- `ISSUE-C1-8 Verify cycle integration and cleanup` - jeszcze niepotwierdzone pelnym lokalnym sanity checkiem.

## Co jeszcze zostalo do zrobienia

Na ten moment nie widac duzych brakow implementacyjnych blokujacych `Cycle 2`. Zostaly glownie rzeczy walidacyjne i porzadkowe:

- uruchomic lokalnie `flutter pub get`, `flutter analyze` i `flutter test`,
- wykonac manualny smoke run aplikacji z przeplywem `Splash -> Home/Search/Library -> Game Details`,
- sprawdzic uruchomienie z `RAWG_API_KEY` przekazanym przez `--dart-define`,
- opcjonalnie dodac brakujacy katalog `lib/shared/`, jesli chcesz trzymac sie dokladnie pierwotnej struktury z dokumentacji,
- opcjonalnie dopracowac zachowanie dla braku `RAWG_API_KEY`, jesli przed `Cycle 2` potrzebujesz lagodniejszego fallbacku niz obecny fail-fast.

## Rekomendacja przejscia do Cycle 2

Mozesz przejsc do `Cycle 2`, jesli wykonasz powyzszy check lokalny i nie wyjdzie z niego nic krytycznego. Z perspektywy struktury kodu fundament pod kolejny cykl juz istnieje.

## 1. Cel dokumentu

Dokument rozbija `Cycle 1 - Foundation and Navigation` na konkretne zadania implementacyjne. To jest praktyczny plan pracy pod Flutter MVP, przygotowany tak, zeby dalo sie go latwo przeniesc do `Linear`, `GitHub Issues` albo zwyklej tablicy Kanban.

## Struktura katalogu

Ten folder jest glownym miejscem dla dokumentacji `Cycle 1`:

- `docs/05-delivery/cycle-1/README.md` - plan calego cyklu,
- `docs/05-delivery/cycle-1/issue-1/README.md` - plan implementacji dla `ISSUE-C1-1`,
- `docs/05-delivery/cycle-1/issue-2/README.md` - miejsce na plan dla `ISSUE-C1-2`,
- `docs/05-delivery/cycle-1/issue-3/README.md` - miejsce na plan dla `ISSUE-C1-3`,
- `docs/05-delivery/cycle-1/issue-4/README.md` - miejsce na plan dla `ISSUE-C1-4`,
- `docs/05-delivery/cycle-1/issue-5/README.md` - miejsce na plan dla `ISSUE-C1-5`,
- `docs/05-delivery/cycle-1/issue-6/README.md` - miejsce na plan dla `ISSUE-C1-6`,
- `docs/05-delivery/cycle-1/issue-7/README.md` - miejsce na plan dla `ISSUE-C1-7`,
- `docs/05-delivery/cycle-1/issue-8/README.md` - miejsce na plan dla `ISSUE-C1-8`.

## 2. Cel cyklu

Po zakonczeniu tego cyklu aplikacja powinna:

- uruchamiac sie bez boilerplate'u Flutter Demo,
- miec sensowna strukture projektu,
- miec podstawowy theme i design tokens,
- miec routing i podstawowy app shell,
- miec dzialajacy splash screen,
- miec skonfigurowany klient API do `RAWG`,
- miec przygotowany lokalny storage do dalszych funkcji.

## 3. Zakres cyklu

Cycle 1 obejmuje:

- `ISSUE-1 Configure project structure for feature-based Flutter app`
- `ISSUE-2 Add app theme and shared design tokens`
- `ISSUE-3 Setup navigation and route map`
- `ISSUE-4 Setup RAWG API client and configuration`
- `ISSUE-5 Setup local storage for library and progress data`
- `ISSUE-6 Build animated splash screen`
- `ISSUE-7 Create app shell with bottom navigation or primary navigation`
- `ISSUE-8 Verify cycle integration and cleanup`

## 4. Kolejnosc realizacji

Najlepsza kolejnosc prac:

1. uporzadkowanie projektu,
2. theme i design system,
3. routing,
4. shell aplikacji,
5. konfiguracja API,
6. konfiguracja local storage,
7. splash screen,
8. porzadki i szybkie sprawdzenie integracyjne.

Ta kolejnosc zmniejsza ryzyko przepisywania tego samego kilka razy.

## 5. Szczegolowe zadania

### TASK-1 Remove Flutter demo code and define app entry point

Powiazanie:

- wspiera `ISSUE-1`.

Cel:

- usunac licznik i caly boilerplate Flutter Demo,
- przygotowac czysty punkt startowy aplikacji.

Do zrobienia:

- zastapic obecny `lib/main.dart` minimalnym bootstrapem,
- wydzielic widget aplikacji do `lib/app/app.dart`,
- przygotowac prosty `main()` bez logiki ekranu demo.

Done when:

- aplikacja startuje bez counter app,
- entry point jest czytelny,
- kod startowy nie miesza UI i konfiguracji.

### TASK-2 Create target folder structure under `lib/`

Powiazanie:

- wspiera `ISSUE-1`.

Cel:

- przygotowac strukture pod feature-based architecture.

Do zrobienia:

- utworzyc katalogi `app/`, `core/`, `features/`, `shared/`,
- dodac podkatalogi startowe, np. `core/theme/`, `core/navigation/`, `core/network/`, `core/storage/`,
- dodac placeholdery dla `features/splash/`, `features/home/`, `features/library/`.

Done when:

- struktura folderow odpowiada przyjetemu modelowi architektury,
- wiadomo, gdzie beda trafialy kolejne pliki.

### TASK-3 Define app naming placeholders and environment constants

Powiazanie:

- wspiera `ISSUE-1` i `ISSUE-4`.

Cel:

- oddzielic stale aplikacyjne od UI.

Do zrobienia:

- przygotowac plik z nazwa aplikacji,
- przygotowac plik z podstawowymi constants,
- przygotowac miejsce na `RAWG API key` i base URL.

Done when:

- stale aplikacji nie sa rozrzucone po ekranach,
- klucz API ma przewidziane miejsce w konfiguracji.

### TASK-4 Create base color palette and design tokens

Powiazanie:

- wspiera `ISSUE-2`.

Cel:

- ustalic wizualna baze aplikacji.

Do zrobienia:

- zdefiniowac palette kolorow glownego motywu,
- zdefiniowac spacing scale,
- zdefiniowac radius scale,
- zdefiniowac podstawowe shadows lub elevation usage.

Done when:

- projekt ma jeden spisany zestaw tokenow,
- UI nie korzysta z przypadkowych wartosci w kazdym miejscu.

### TASK-5 Build application theme

Powiazanie:

- wspiera `ISSUE-2`.

Cel:

- zbudowac podstawowy `ThemeData` dla aplikacji.

Do zrobienia:

- przygotowac `light theme`,
- ustawic typography,
- ustawic app bar theme,
- ustawic scaffold background,
- ustawic style przyciskow i pol tekstowych.

Done when:

- aplikacja ma spojny bazowy wyglad,
- ekrany placeholderowe korzystaja z tego samego theme.

### TASK-6 Define route map and navigation strategy

Powiazanie:

- wspiera `ISSUE-3`.

Cel:

- ustalic jak aplikacja bedzie poruszac sie miedzy ekranami.

Do zrobienia:

- wybrac podejscie: `Navigator` albo `go_router`,
- zdefiniowac liste glowych tras,
- zdefiniowac przejscia dla splash, home, search, library i details.

Done when:

- istnieje centralna mapa routingu,
- wiadomo jak przechodzic do glownej nawigacji i szczegolow gry.

### TASK-7 Build placeholder screens for app shell

Powiazanie:

- wspiera `ISSUE-3` i `ISSUE-7`.

Cel:

- przygotowac ekranowy szkielet aplikacji, zanim zacznie sie budowa funkcji docelowych.

Do zrobienia:

- utworzyc placeholder `SplashScreen`,
- utworzyc placeholder `HomeScreen`,
- utworzyc placeholder `SearchScreen`,
- utworzyc placeholder `LibraryScreen`,
- utworzyc placeholder `GameDetailsScreen`.

Done when:

- aplikacja ma komplet podstawowych ekranow jako placeholdery,
- routing moze byc przetestowany end-to-end.

### TASK-8 Implement primary app shell navigation

Powiazanie:

- wspiera `ISSUE-7`.

Cel:

- uruchomic glowna nawigacje aplikacji.

Do zrobienia:

- zdecydowac, czy MVP ma `bottom navigation`,
- zbudowac shell z minimum `Home`, `Search`, `Library`,
- osadzic placeholder screens w shellu,
- ustawic start aplikacji po splashu na shell.

Done when:

- uzytkownik moze przejsc miedzy glownymi sekcjami,
- shell dziala bez danych docelowych.

### TASK-9 Add HTTP dependency and create API client abstraction

Powiazanie:

- wspiera `ISSUE-4`.

Cel:

- przygotowac warstwe komunikacji z `RAWG`.

Do zrobienia:

- dodac wybrana biblioteke HTTP, np. `dio` albo `http`,
- stworzyc podstawowego klienta API,
- dodac konfiguracje base URL,
- dodac obsluge parametru `key` dla `RAWG`.

Done when:

- istnieje jedna warstwa do requestow,
- UI nie odwoluje sie bezposrednio do niskopoziomowego klienta HTTP.

### TASK-10 Define RAWG endpoints and initial DTO models

Powiazanie:

- wspiera `ISSUE-4`.

Cel:

- przygotowac baze pod Home, Search i Details.

Do zrobienia:

- spisac endpointy potrzebne do MVP,
- przygotowac pierwszy model listy gry,
- przygotowac pierwszy model szczegolow gry,
- przygotowac mapowanie JSON -> Dart.

Done when:

- backendowy kontrakt z API jest czytelny,
- kolejne feature'y nie beda zaczynaly od zera.

### TASK-11 Add secret handling strategy for API key

Powiazanie:

- wspiera `ISSUE-4`.

Cel:

- nie trzymac klucza API w przypadkowych miejscach projektu.

Do zrobienia:

- ustalic, czy klucz bedzie przekazywany przez `--dart-define`,
- przygotowac odczyt klucza w konfiguracji,
- przygotowac fallback lub komunikat dla braku klucza.

Done when:

- istnieje jeden sposob dostarczania klucza,
- projekt nie wymaga wpisywania klucza bezposrednio do widgetow.

### TASK-12 Choose and configure local storage solution

Powiazanie:

- wspiera `ISSUE-5`.

Cel:

- przygotowac baze pod biblioteke i tracker progresu.

Do zrobienia:

- wybrac `Hive`, `Isar` albo `shared_preferences`,
- dodac zaleznosc,
- zainicjalizowac storage w bootstrapie aplikacji.

Done when:

- storage uruchamia sie poprawnie,
- aplikacja jest gotowa do zapisu lokalnych danych.

### TASK-13 Create local models for saved games and progress

Powiazanie:

- wspiera `ISSUE-5`.

Cel:

- zdefiniowac model danych lokalnych przed implementacja biblioteki.

Do zrobienia:

- przygotowac model zapisanej gry,
- przygotowac model statusu gry,
- przygotowac model checklisty i progressu,
- przygotowac mapowanie dla storage.

Done when:

- wiadomo, jakie dane beda trwale zapisywane lokalnie,
- modele sa gotowe do wykorzystania w `Cycle 3`.

### TASK-14 Build splash screen UI and animation

Powiazanie:

- wspiera `ISSUE-6`.

Cel:

- przygotowac ekran startowy, ktory od razu robi dobre pierwsze wrazenie.

Do zrobienia:

- zaprojektowac prosty layout splasha,
- dodac animacje logo lub napisu,
- dodac animowane tlo lub subtelny efekt wizualny.

Done when:

- splash jest estetyczny,
- animacja jest plynna,
- ekran nie wyglada jak placeholder techniczny.

### TASK-15 Connect splash transition to app shell

Powiazanie:

- wspiera `ISSUE-6` i `ISSUE-7`.

Cel:

- domknac pierwszy pelny flow aplikacji.

Do zrobienia:

- ustawic czas trwania splasha,
- przejsc do shellu po animacji,
- upewnic sie, ze nie da sie wracac do splasha przez back navigation.

Done when:

- aplikacja uruchamia sie: `Splash -> App Shell`,
- flow jest stabilny i gotowy do pokazania.

### TASK-16 Run a Cycle 1 integration sanity check

Powiazanie:

- domyka caly cykl.

Cel:

- sprawdzic, czy fundamenty naprawde ze soba wspolgraja.

Do zrobienia:

- uruchomic aplikacje lokalnie,
- przejsc caly flow startowy,
- sprawdzic routing,
- sprawdzic inicjalizacje storage,
- sprawdzic inicjalizacje klienta API,
- usunac martwy boilerplate lub tymczasowe debug widgety.

Done when:

- aplikacja dziala bez crasha po starcie,
- mozna pokazac bazowa strukture calej aplikacji.

## 6. Zaleznosci miedzy zadaniami

Najwazniejsze zaleznosci:

- `TASK-1` przed prawie wszystkim, bo usuwa boilerplate,
- `TASK-2` przed widgetami feature'ow,
- `TASK-4` przed `TASK-5`,
- `TASK-6` przed `TASK-7`, `TASK-8` i `TASK-15`,
- `TASK-9` przed `TASK-10` i `TASK-11`,
- `TASK-12` przed `TASK-13`,
- `TASK-14` przed `TASK-15`,
- `TASK-15` i `TASK-13` przed `TASK-16`.

## 7. Proponowany podzial na issues do Lineara

Jesli chcesz to od razu wrzucic do Lineara, mozesz rozbic Cycle 1 tak:

### ISSUE-C1-1 Clean app bootstrap and folder structure

Obejmuje:

- `TASK-1`
- `TASK-2`
- `TASK-3`

### ISSUE-C1-2 Create theme and design tokens

Obejmuje:

- `TASK-4`
- `TASK-5`

### ISSUE-C1-3 Setup routing and placeholder screens

Obejmuje:

- `TASK-6`
- `TASK-7`

### ISSUE-C1-4 Build app shell navigation

Obejmuje:

- `TASK-8`

### ISSUE-C1-5 Setup RAWG API foundation

Obejmuje:

- `TASK-9`
- `TASK-10`
- `TASK-11`

### ISSUE-C1-6 Setup local storage foundation

Obejmuje:

- `TASK-12`
- `TASK-13`

### ISSUE-C1-7 Build animated splash and transition

Obejmuje:

- `TASK-14`
- `TASK-15`

### ISSUE-C1-8 Verify cycle integration and cleanup

Obejmuje:

- `TASK-16`

## 8. Priorytet i kolejnosc implementacyjna

Jesli chcesz realizowac to sekwencyjnie, najlepszy porzadek jest taki:

1. `ISSUE-C1-1`
2. `ISSUE-C1-2`
3. `ISSUE-C1-3`
4. `ISSUE-C1-4`
5. `ISSUE-C1-5`
6. `ISSUE-C1-6`
7. `ISSUE-C1-7`
8. `ISSUE-C1-8`

Jesli chcesz troche zrownoleglic prace:

- po `ISSUE-C1-1` mozna niezaleznie robic `ISSUE-C1-2` i `ISSUE-C1-5`,
- po `ISSUE-C1-3` mozna osobno robic `ISSUE-C1-4` i `ISSUE-C1-7`,
- `ISSUE-C1-6` moze isc rownolegle do UI, jesli bootstrap storage jest juz ustalony.

## 9. Definition of done dla Cycle 1

Cycle 1 jest zamkniety, jesli:

- nie ma juz counter app ani kodu demo,
- projekt ma docelowa strukture katalogow,
- aplikacja ma theme i bazowy styl,
- aplikacja startuje przez splash screen,
- po splashu laduje sie glowny shell,
- routing miedzy placeholderowymi ekranami dziala,
- klient API jest gotowy do uzycia,
- local storage jest gotowy do uzycia,
- istnieje jasna baza pod `Cycle 2`.

Aktualna ocena:

- warunki implementacyjne sa w praktyce spelnione,
- brakujacym krokiem do formalnego zamkniecia pozostaje lokalny verify run i szybki cleanup dokumentacyjny.

## 10. Rekomendacja koncowa

Nie probuj w `Cycle 1` robic jeszcze prawdziwego Home, Search i Details. Ten cykl ma tylko postawic fundament. Jesli dobrze go zrobisz, kolejne cykle pojda szybciej i z mniejsza liczba przepinek architektonicznych.
