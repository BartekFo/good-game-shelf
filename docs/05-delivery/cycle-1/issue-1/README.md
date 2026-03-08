# ISSUE-C1-1 Implementation Plan

## Audit update

Status po przegladzie repo: `prawie domkniete`.

To issue zostalo w duzej mierze zaimplementowane:

- `lib/main.dart` nie zawiera juz Flutter Demo i uruchamia `App`,
- root widget jest wydzielony do `lib/app/app.dart`,
- istnieja `lib/core/config/app_env.dart`, `lib/core/constants/app_constants.dart` i `lib/core/network/rawg_config.dart`,
- struktura `lib/app`, `lib/core` i `lib/features` istnieje,
- test startowy nie sprawdza juz counter demo.

Otwarte punkty:

- w repo nie widac katalogu `lib/shared/`, mimo ze byl przewidziany w pierwotnym planie,
- `lib/main.dart` inicjalizuje juz storage, wiec aktualny stan repo wykracza poza czyste foundation z tego issue,
- formalne domkniecie wymaga lokalnego `flutter analyze` i `flutter test`.

## 1. Cel dokumentu

Ten dokument opisuje dokladny plan implementacji dla `ISSUE-C1-1 Clean app bootstrap and folder structure` w `Cycle 1 - Foundation and Navigation`.

Plan rozwija zalozenia z `docs/05-delivery/cycle-1/README.md` i zamienia je na konkretne kroki wykonawcze dla aktualnego repozytorium Flutter.

## 2. Cel issue

Po zakonczeniu tego issue projekt powinien:

- startowac bez Flutter Demo counter app,
- miec czytelny entry point,
- miec wydzielony root widget aplikacji,
- miec podstawowa strukture folderow pod architecture feature-based,
- miec jedno miejsce na stale aplikacyjne,
- miec przygotowane miejsce na konfiguracje `RAWG API`.

## 3. Powiazanie z breakdownem Cycle 1

To issue zamyka:

- `TASK-1 Remove Flutter demo code and define app entry point`,
- `TASK-2 Create target folder structure under lib/`,
- `TASK-3 Define app naming placeholders and environment constants`.

## 4. Aktualny stan repo

Na starcie repo zawiera tylko domyslny bootstrap Fluttera:

- `lib/main.dart` oparty o demo counter app,
- brak docelowej struktury `app/core/features/shared`,
- brak centralnego miejsca na constants i env,
- test w `test/widget_test.dart` nadal sprawdza licznik demo.

To oznacza, ze `ISSUE-1` powinno wyczyscic boilerplate i przygotowac neutralny fundament pod kolejne issues.

## 5. Zakres issue

### In scope

- uproszczenie `lib/main.dart`,
- wydzielenie widgetu aplikacji do `lib/app/app.dart`,
- utworzenie katalogow `app/`, `core/`, `features/`, `shared/`,
- dodanie podstawowych podkatalogow w `core/`,
- dodanie placeholderow dla glownych feature'ow,
- dodanie pliku ze stalymi aplikacyjnymi,
- dodanie pliku z env placeholders,
- dodanie pliku z konfiguracja `RAWG` bez implementacji requestow,
- aktualizacja testu widgetowego po usunieciu demo app.

### Out of scope

- theme i design tokens,
- routing i mapa tras,
- splash UI i animacje,
- shell aplikacji,
- klient HTTP i endpointy,
- inicjalizacja local storage,
- logika feature'ow i ekrany docelowe.

## 6. Docelowa struktura po implementacji

```text
lib/
  main.dart
  app/
    app.dart
  core/
    config/
      app_env.dart
    constants/
      app_constants.dart
    navigation/
      .gitkeep
    network/
      rawg_config.dart
    storage/
      .gitkeep
    theme/
      .gitkeep
  features/
    splash/
      .gitkeep
    home/
      .gitkeep
    library/
      .gitkeep
  shared/
    .gitkeep
```

Uwagi:

- `main.dart` ma byc cienkim bootstrapem,
- `app/app.dart` ma byc jedynym miejscem dla root widgetu,
- `core/` ma przygotowac grunt pod theme, navigation, network i storage,
- `features/` na tym etapie ma tylko zakotwiczyc modulowa strukture projektu.

## 7. Plan implementacji krok po kroku

### Step 1. Usunac Flutter Demo z `lib/main.dart`

Cel:

- zastapic demo counter app minimalnym bootstrapem.

Do zrobienia:

- usunac `MyApp`, `MyHomePage`, counter i wszystkie powiazane widgety,
- zostawic tylko `main()` i wywolanie `runApp`,
- importowac docelowy widget aplikacji z `lib/app/app.dart`.

Rezultat:

- `lib/main.dart` nie zawiera logiki UI poza uruchomieniem aplikacji.

### Step 2. Dodac `lib/app/app.dart`

Cel:

- wydzielic root widget aplikacji z entry pointu.

Do zrobienia:

- utworzyc `App extends StatelessWidget`,
- dodac minimalny `MaterialApp`,
- ustawic `title` na podstawie constants,
- ustawic prosty placeholder `home`, bez routingu i bez danych.

Rezultat:

- start aplikacji jest czytelny i gotowy do dalszej rozbudowy.

### Step 3. Dodac stale aplikacyjne

Plik:

- `lib/core/constants/app_constants.dart`

Cel:

- zebrac podstawowe stale w jednym miejscu.

Do zrobienia:

- dodac `appName`,
- dodac ewentualny placeholder `appTagline` albo `appVersion`, jesli bedzie potrzebny do startowego placeholdera,
- trzymac tylko stale globalne, nie ekranowe.

Rezultat:

- nazwa aplikacji nie jest wpisywana bezposrednio w widgetach.

### Step 4. Dodac env placeholders

Plik:

- `lib/core/config/app_env.dart`

Cel:

- przewidziec jeden sposob dostarczania konfiguracji srodowiskowej.

Do zrobienia:

- dodac odczyt `RAWG_API_KEY` przez `String.fromEnvironment`,
- dodac helper typu `hasRawgApiKey`,
- nie hardcodowac zadnych sekretow w repo.

Rezultat:

- projekt ma przygotowany punkt wejscia dla `--dart-define`.

### Step 5. Dodac podstawowa konfiguracje `RAWG`

Plik:

- `lib/core/network/rawg_config.dart`

Cel:

- przygotowac miejsce na parametry API bez budowy klienta HTTP.

Do zrobienia:

- dodac `baseUrl`,
- podlaczyc `apiKey` z `AppEnv`,
- utrzymac plik jako czysta konfiguracje, bez requestow.

Rezultat:

- `ISSUE-4` bedzie moglo zaczac od gotowej konfiguracji bazowej.

### Step 6. Utworzyc folder structure pod feature-based architecture

Cel:

- przygotowac porzadny szkielet pod dalsze moduly.

Do zrobienia:

- utworzyc `app/`, `core/`, `features/`, `shared/`,
- utworzyc podkatalogi `core/theme/`, `core/navigation/`, `core/network/`, `core/storage/`, `core/config/`, `core/constants/`,
- utworzyc placeholdery dla `features/splash/`, `features/home/`, `features/library/`,
- dodac `.gitkeep` tam, gdzie katalog na razie pozostaje pusty.

Rezultat:

- struktura jest gotowa do rozwijania bez dalszego przemeblowywania katalogow.

### Step 7. Zaktualizowac test startowy

Plik:

- `test/widget_test.dart`

Cel:

- usunac test zalezn y od Flutter Demo i zastapic go smoke testem nowego bootstrapu.

Do zrobienia:

- przestac testowac licznik i ikone `+`,
- renderowac `App`,
- sprawdzic obecny placeholder startowy albo inny stabilny element root widoku.

Rezultat:

- test potwierdza, ze nowy bootstrap dziala po usunieciu demo kodu.

## 8. Kolejnosc wykonania

Najbezpieczniejsza kolejnosc wdrozenia:

1. `main.dart`,
2. `app/app.dart`,
3. `core/constants/app_constants.dart`,
4. `core/config/app_env.dart`,
5. `core/network/rawg_config.dart`,
6. katalogi i `.gitkeep`,
7. `test/widget_test.dart`,
8. szybki sanity check.

Taka kolejnosc ogranicza chaos i pozwala najpierw ustabilizowac bootstrap, a dopiero potem rozbudowac strukture.

## 9. Kryteria akceptacji

Issue uznajemy za zamkniete, jesli:

- aplikacja uruchamia sie bez Flutter counter demo,
- `lib/main.dart` jest cienkim bootstrapem,
- root widget znajduje sie w `lib/app/app.dart`,
- istnieja katalogi `app`, `core`, `features`, `shared`,
- istnieje centralny plik ze stalymi aplikacji,
- istnieje centralny plik z env placeholders,
- istnieje plik konfiguracyjny `RAWG` z `baseUrl` i miejscem na `apiKey`,
- test widgetowy nie zalezy juz od demo counter app,
- kod jest gotowy pod `ISSUE-2`, `ISSUE-3` i `ISSUE-4` bez kolejnej reorganizacji.

## 10. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter pub get`,
- `flutter analyze`,
- `flutter test`.

Opcjonalnie:

- `flutter run --dart-define=RAWG_API_KEY=dummy` jako prosty smoke run.

## 11. Ryzyka i decyzje implementacyjne

- Obecny `lib/main.dart` zawiera domyslny boilerplate, wiec najbezpieczniej wymienic go w calosci.
- Nie warto teraz wprowadzac pelnej struktury `data/presentation/state` w kazdym feature, bo to sztucznie napompuje zakres.
- Na tym etapie wystarcza same placeholdery katalogow; prawdziwe ekrany pojawia sie w kolejnych issues.
- `RAWG_API_KEY` powinien od poczatku byc czytany z `--dart-define`, nawet jesli jeszcze nie jest realnie uzywany.

## 12. Rekomendacja wykonawcza

To issue powinno byc traktowane jako czysty groundwork. Celem nie jest jeszcze budowa funkcji, tylko usuniecie przypadkowego startowego kodu i przygotowanie porzadnego fundamentu, na ktorym kolejne issues beda mogly pracowac bez przepinek strukturalnych.
