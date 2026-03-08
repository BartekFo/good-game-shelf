# MVP User Stories And Cycles

## 1. Cel dokumentu

Dokument przeklada MVP aplikacji `Game Explorer` na praktyczny plan realizacji w stylu `Linear`: user stories, epiki, issues, zadania i cykle. Celem jest takie rozbicie pracy, zeby projekt dalo sie prowadzic iteracyjnie i bez chaosu.

## 2. Jak myslec o pracy w stylu Linear

Podejscie `Linear method` mozna uproscic do kilku zasad:

- pracujemy w malych cyklach,
- kazdy cykl ma jasny cel produktowy,
- duze funkcje dzielimy na epiki,
- epiki dzielimy na issues,
- issue powinno byc na tyle male, zeby dalo sie je zamknac bez rozlewania zakresu,
- kazde issue powinno miec jasny rezultat i definicje done.

W praktyce dla projektu studenckiego wystarczy:

- `epic` jako wiekszy obszar funkcjonalny,
- `issue` jako pojedynczy kawalek pracy,
- `subtasks` jako techniczne kroki wykonania.

## 3. Proponowana struktura backlogu MVP

### Epiki MVP

- `EPIC-1 Foundations and Project Setup`
- `EPIC-2 Splash and App Shell`
- `EPIC-3 Home and RAWG Integration`
- `EPIC-4 Search`
- `EPIC-5 Game Details`
- `EPIC-6 My Library`
- `EPIC-7 Progress Tracker`
- `EPIC-8 Polish, Error States and Demo Readiness`

To jest wystarczajaco malo, zeby backlog byl czytelny, i wystarczajaco duzo, zeby nie mieszac wszystkiego w jednym worku.

## 4. User stories MVP

### US1. Ekran startowy

Jako uzytkownik chce zobaczyc estetyczny, animowany ekran startowy, aby aplikacja od poczatku robila dobre wrazenie i plynnie wprowadzala mnie do glownego widoku.

Akceptacja:

- po uruchomieniu widze splash screen,
- animacja trwa krotko i nie blokuje wejscia do aplikacji,
- po animacji przechodze do home.

### US2. Przegladanie popularnych gier

Jako uzytkownik chce przegladac popularne i aktualne gry, aby szybko odkrywac ciekawe tytuly.

Akceptacja:

- home pokazuje co najmniej kilka sekcji gier,
- kazda sekcja laduje dane z API,
- moge kliknac gre i przejsc do szczegolow.

### US3. Wyszukiwanie gry

Jako uzytkownik chce wyszukac konkretna gre po nazwie, aby szybko znalezc interesujacy mnie tytul.

Akceptacja:

- moge wpisac fraze w wyszukiwarce,
- widze wyniki wyszukiwania,
- widze stan pusty, gdy nic nie znaleziono.

### US4. Podglad szczegolow gry

Jako uzytkownik chce zobaczyc szczegoly wybranej gry, aby sprawdzic, czy chce dodac ja do swojej biblioteki.

Akceptacja:

- ekran pokazuje podstawowe informacje o grze,
- ekran pokazuje grafiki lub screenshoty,
- mam dostep do akcji dodania do biblioteki lub ulubionych.

### US5. Budowanie swojej biblioteki

Jako uzytkownik chce dodawac gry do swojej biblioteki, aby miec swoje tytuly w jednym miejscu.

Akceptacja:

- moge dodac gre do biblioteki,
- moge usunac gre z biblioteki,
- po restarcie aplikacji dane nadal sa zapisane.

### US6. Zarzadzanie statusem gry

Jako uzytkownik chce ustawic status gry, aby wiedziec, czy planuje w nia zagrac, aktualnie gram, ukonczylem ja czy mam ja na `100%`.

Akceptacja:

- moge zmienic status gry,
- status jest widoczny w bibliotece,
- status jest zapisany lokalnie.

### US7. Sledzenie progresu gry

Jako uzytkownik chce prowadzic checkliste dla gry, aby sledzic, co zostalo mi jeszcze do zrobienia.

Akceptacja:

- moge dodawac punkty checklisty,
- moge oznaczac je jako zrobione,
- widze procent ukonczenia.

### US8. Filtrowanie swojej biblioteki

Jako uzytkownik chce filtrowac biblioteke po statusach, aby szybko zobaczyc, w co aktualnie gram albo co ukonczylem.

Akceptacja:

- moge filtrowac biblioteke po statusie,
- lista aktualizuje sie zgodnie z filtrem,
- kazda pozycja pokazuje podstawowe informacje i progres.

### US9. Stabilne dzialanie przy bledach API

Jako uzytkownik chce widziec czytelne stany bledu i ladowania, aby aplikacja byla zrozumiala nawet przy problemach z internetem lub API.

Akceptacja:

- ekrany danych obsluguja loading,
- ekrany danych obsluguja error,
- aplikacja nie psuje sie przy nieudanym zapytaniu.

## 5. Epiki i przypisane user stories

### EPIC-1 Foundations and Project Setup

Zakres:

- przygotowanie struktury projektu,
- podstawowy theme,
- routing,
- networking,
- local storage,
- konfiguracja srodowiska i klucza API.

Powiazane user stories:

- wspiera wszystkie pozostale historie jako baza techniczna.

### EPIC-2 Splash and App Shell

Zakres:

- splash screen,
- glowne scaffoldy,
- nawigacja,
- podstawowy app shell.

Powiazane user stories:

- `US1`.

### EPIC-3 Home and RAWG Integration

Zakres:

- integracja z listami gier,
- sekcje home,
- karty gier,
- loading i refresh.

Powiazane user stories:

- `US2`, `US9`.

### EPIC-4 Search

Zakres:

- ekran search,
- obsluga inputu,
- wyniki,
- pusty stan,
- stany loading i error.

Powiazane user stories:

- `US3`, `US9`.

### EPIC-5 Game Details

Zakres:

- ekran szczegolow,
- mapowanie szczegolow gry,
- screenshoty,
- CTA do biblioteki i ulubionych.

Powiazane user stories:

- `US4`, czesc `US5`, `US9`.

### EPIC-6 My Library

Zakres:

- lokalna biblioteka,
- dodawanie i usuwanie,
- statusy,
- filtry,
- persystencja danych.

Powiazane user stories:

- `US5`, `US6`, `US8`.

### EPIC-7 Progress Tracker

Zakres:

- checklista,
- dodawanie zadan,
- oznaczanie wykonania,
- procent progresu,
- powiazanie z gra w bibliotece.

Powiazane user stories:

- `US7`, czesc `US8`.

### EPIC-8 Polish, Error States and Demo Readiness

Zakres:

- polishing UI,
- animacje i przejscia,
- stany bledu i puste stany,
- test scenariusza demo,
- przygotowanie projektu do prezentacji.

Powiazane user stories:

- `US1`, `US2`, `US3`, `US4`, `US9`.

## 6. Rozbicie na issues

Ponizej znajduje sie przykladowy backlog issues w stylu Linear.

### EPIC-1 Foundations and Project Setup

#### ISSUE-1 Configure project structure for feature-based Flutter app

Rezultat:

- projekt ma katalogi `app`, `core`, `features`, `shared`.

Subtasks:

- utworzyc docelowy uklad folderow,
- przeniesc entry point do sensownej struktury,
- przygotowac miejsce na feature modules.

#### ISSUE-2 Add app theme and shared design tokens

Rezultat:

- aplikacja ma podstawowy system kolorow, typografii i spacingu.

Subtasks:

- zdefiniowac palete kolorow,
- dodac theme data,
- przygotowac podstawowe style tekstowe.

#### ISSUE-3 Setup navigation and route map

Rezultat:

- aplikacja umie przechodzic miedzy glowymi ekranami.

Subtasks:

- dodac routing,
- zdefiniowac sciezki ekranow,
- przygotowac przejscie do details i library.

#### ISSUE-4 Setup RAWG API client and configuration

Rezultat:

- aplikacja ma klienta API i podstawowe endpointy.

Subtasks:

- dodac pakiet HTTP,
- przygotowac klienta API,
- przygotowac konfiguracje klucza API,
- dodac podstawowe modele odpowiedzi.

#### ISSUE-5 Setup local storage for library and progress data

Rezultat:

- aplikacja moze zapisywac dane lokalnie.

Subtasks:

- wybrac storage,
- przygotowac repozytorium lokalnych danych,
- dodac mapowanie modeli lokalnych.

### EPIC-2 Splash and App Shell

#### ISSUE-6 Build animated splash screen

Rezultat:

- po starcie aplikacji pojawia sie animowany splash.

Subtasks:

- przygotowac layout splasha,
- dodac animacje,
- dodac automatyczne przejscie do home.

#### ISSUE-7 Create app shell with bottom navigation or primary navigation

Rezultat:

- uzytkownik moze przechodzic miedzy glownymi sekcjami aplikacji.

Subtasks:

- przygotowac glowne scaffoldy,
- dodac punkty nawigacyjne,
- osadzic placeholdery ekranow.

### EPIC-3 Home and RAWG Integration

#### ISSUE-8 Fetch and display home game sections from RAWG

Rezultat:

- home pokazuje sekcje gier z API.

Subtasks:

- podpiac endpointy do sekcji,
- wyrenderowac poziome listy,
- obsluzyc loading.

#### ISSUE-9 Build reusable game card component

Rezultat:

- karty gier sa spojne w calej aplikacji.

Subtasks:

- zbudowac komponent karty,
- obsluzyc obraz, tytul i meta,
- dodac klikniecie przechodzace do details.

#### ISSUE-10 Add refresh and error state handling on home

Rezultat:

- home poprawnie reaguje na brak danych i blad sieci.

Subtasks:

- dodac empty state,
- dodac error state,
- dodac retry lub refresh.

### EPIC-4 Search

#### ISSUE-11 Create search screen layout and interaction

Rezultat:

- istnieje ekran search z inputem i lista wynikow.

Subtasks:

- przygotowac pole wyszukiwania,
- przygotowac ekran wynikow,
- dodac obsluge pustego stanu.

#### ISSUE-12 Connect search screen to RAWG search endpoint

Rezultat:

- wpisanie frazy zwraca wyniki z API.

Subtasks:

- dodac search repository method,
- podpiac request,
- obsluzyc debounce lub sensowny trigger wyszukiwania.

### EPIC-5 Game Details

#### ISSUE-13 Build game details screen UI

Rezultat:

- ekran szczegolow pokazuje kluczowe dane gry.

Subtasks:

- przygotowac hero section,
- wyswietlic opis i metadane,
- wyswietlic screenshoty.

#### ISSUE-14 Connect details screen to game details endpoint

Rezultat:

- ekran szczegolow laduje dane konkretnej gry.

Subtasks:

- podpiac endpoint details,
- zmapowac response,
- obsluzyc loading i error.

#### ISSUE-15 Add actions for favorite and add-to-library on details screen

Rezultat:

- z poziomu szczegolow mozna zapisac gre lokalnie.

Subtasks:

- dodac przyciski CTA,
- zapisac stan lokalnie,
- odswiezyc UI po akcji.

### EPIC-6 My Library

#### ISSUE-16 Build my library screen from local storage

Rezultat:

- biblioteka pokazuje zapisane gry.

Subtasks:

- pobrac dane z local storage,
- zbudowac liste kart,
- dodac empty state.

#### ISSUE-17 Add status management for saved games

Rezultat:

- uzytkownik moze zmieniac status gry.

Subtasks:

- przygotowac liste statusow,
- dodac UI zmiany statusu,
- zapisac zmiane lokalnie.

#### ISSUE-18 Add filters in library by game status

Rezultat:

- biblioteka moze byc filtrowana po statusie.

Subtasks:

- przygotowac UI filtrow,
- zaimplementowac filtrowanie,
- sprawdzic zachowanie przy pustych wynikach.

#### ISSUE-19 Allow removing games from library

Rezultat:

- uzytkownik moze usunac gre z biblioteki.

Subtasks:

- dodac akcje usuniecia,
- odswiezyc liste,
- upewnic sie, ze cleanup obejmuje powiazany progres.

### EPIC-7 Progress Tracker

#### ISSUE-20 Build progress tracker screen for saved game

Rezultat:

- istnieje ekran trackera progresu dla wybranej gry.

Subtasks:

- przygotowac layout ekranu,
- wyswietlic checkliste,
- wyswietlic progress bar.

#### ISSUE-21 Add checklist item creation and editing

Rezultat:

- uzytkownik moze tworzyc punkty checklisty.

Subtasks:

- dodac formularz nowego punktu,
- zapisac punkt lokalnie,
- dodac mozliwosc edycji nazwy.

#### ISSUE-22 Add checklist completion toggle and progress calculation

Rezultat:

- checklista liczy procent ukonczenia.

Subtasks:

- dodac toggle wykonania,
- wyliczac progres,
- odswiezac widok biblioteki po zmianie.

### EPIC-8 Polish, Error States and Demo Readiness

#### ISSUE-23 Add polished loading, empty and error states across app

Rezultat:

- kazdy kluczowy ekran ma dopracowane stany systemowe.

Subtasks:

- przeglad wszystkich ekranow,
- uzupelnienie placeholderow,
- uzupelnienie retry i komunikatow.

#### ISSUE-24 Improve transitions and visual polish for demo

Rezultat:

- aplikacja sprawia lepsze wrazenie na prezentacji.

Subtasks:

- dopracowac przejscia miedzy ekranami,
- dopracowac spacing i typografie,
- dopracowac progress bar i hero section.

#### ISSUE-25 Prepare demo checklist and final QA pass

Rezultat:

- aplikacja jest gotowa do pokazania.

Subtasks:

- sprawdzic glowny flow demo,
- sprawdzic dane testowe,
- sprawdzic crash-paths i edge cases,
- spisac scenariusz prezentacji.

## 7. Proponowane cykle MVP

Przyjmijmy 4 cykle. Dla projektu studenckiego to daje dobra prostote.

### Cycle 1 - Foundation and Navigation

Cel cyklu:

- postawic fundament projektu i uruchomic podstawowy przeplyw ekranow.

Zakres:

- `ISSUE-1`
- `ISSUE-2`
- `ISSUE-3`
- `ISSUE-4`
- `ISSUE-5`
- `ISSUE-6`
- `ISSUE-7`

Exit criteria:

- aplikacja ma splash,
- aplikacja ma routing,
- aplikacja ma theme,
- aplikacja ma klienta API i lokalny storage gotowe do uzycia.

### Cycle 2 - Discovery Core

Cel cyklu:

- dostarczyc odkrywanie gier i podstawowe pobieranie danych z API.

Zakres:

- `ISSUE-8`
- `ISSUE-9`
- `ISSUE-10`
- `ISSUE-11`
- `ISSUE-12`
- `ISSUE-13`
- `ISSUE-14`

Exit criteria:

- dziala home,
- dziala search,
- dziala details,
- aplikacja obsluguje loading i podstawowe error states.

### Cycle 3 - Personal Library and Progress

Cel cyklu:

- dodac wartosc osobista, czyli biblioteke i tracker progresu.

Zakres:

- `ISSUE-15`
- `ISSUE-16`
- `ISSUE-17`
- `ISSUE-18`
- `ISSUE-19`
- `ISSUE-20`
- `ISSUE-21`
- `ISSUE-22`

Exit criteria:

- uzytkownik moze zapisac gre,
- biblioteka dziala,
- statusy dzialaja,
- tracker progresu dziala,
- progres pokazuje sie w bibliotece.

### Cycle 4 - Polish and Demo Readiness

Cel cyklu:

- dopracowac aplikacje tak, zeby dobrze wygladala i byla gotowa do oddania.

Zakres:

- `ISSUE-23`
- `ISSUE-24`
- `ISSUE-25`

Exit criteria:

- aplikacja ma spojne stany,
- prezentacja wyglada dobrze,
- glowny flow jest stabilny,
- projekt jest gotowy do pokazania na studiach.

## 8. Jak pisac issue w praktyce

Kazde issue w narzedziu typu Linear warto zapisywac w prostym formacie:

### Tytul

- konkretny i zorientowany na rezultat,
- np. `Build animated splash screen` zamiast `Do splash`.

### Opis

- co ma powstac,
- dlaczego to jest potrzebne,
- co nie wchodzi w zakres.

### Akceptacja

- 2-5 punktow typu done,
- konkretne, testowalne.

### Subtasks

- techniczne kroki wykonania,
- tylko jesli pomagaja utrzymac porzadek.

## 9. Priorytety MVP

Jesli czasu bedzie malo, priorytet jest taki:

- najpierw `splash + home + details + search`,
- potem `library`,
- potem `progress tracker`,
- na koncu polishing.

Jesli trzeba cos uciac, najlatwiej ograniczyc:

- screenshot carousel,
- zaawansowane filtry,
- edycje checklisty,
- dodatkowe animacje poza splashem i detalem.

## 10. Rekomendacja koncowa

Najzdrowszy sposob prowadzenia MVP to:

- trzymac male epiki,
- dzielic je na zamykalne issues,
- planowac 4 cykle,
- na koncu kazdego cyklu miec cos, co dziala i daje sie pokazac.

To podejscie pozwoli Ci pracowac jak nad prawdziwym produktem, ale bez przesadnego procesu.
