# Cycle 2 Discovery Core Breakdown

## Status

To jest plan dla `Cycle 2`. Ten cykl nie powinien byc robiony jako pelny one-shot. Najlepszy balans dla tego repo to `2 wieksze issues`, z ktorych kazdy dostarcza czytelny wynik produktowy.

## 1. Cel dokumentu

Dokument rozbija `Cycle 2 - Discovery Core` na praktyczny plan implementacji. Celem jest przejscie od placeholderowego UI do pierwszego realnego przeplywu odkrywania gier opartego o `RAWG API`.

## 2. Cel cyklu

Po zakonczeniu tego cyklu aplikacja powinna:

- wyswietlac realne dane na ekranie `Home`,
- pozwalac wyszukiwac gry po nazwie,
- pozwalac wejsc z list do `Game Details`,
- pobierac szczegoly wybranej gry,
- obslugiwac podstawowe stany `loading`, `empty`, `error`,
- byc gotowa do budowy `Cycle 3` bez przepisywania discovery flow.

## 3. Dlaczego 2 issues zamiast one-shot

Ten cykl dotyka jednoczesnie:

- warstwy danych,
- stanu ekranow,
- nawigacji miedzy ekranami,
- trzech glownych widokow produktu.

Zrobienie tego jako jeden duzy one-shot zwieksza ryzyko rozjazdu miedzy dokumentacja, kodem i faktycznie dowiezionym zakresem. Z kolei rozbijanie tego na wiele drobnych issue nie daje duzej wartosci. Dlatego ten plan grupuje `Cycle 2` w dwa wieksze, latwe do zweryfikowania bloki.

## 4. Aktualny stan repo przed Cycle 2

Repo ma juz foundation z `Cycle 1`:

- theme i routing sa gotowe,
- istnieje splash i app shell,
- istnieje klient `RAWG` oraz DTO,
- istnieja placeholderowe ekrany `Home`, `Search` i `Game Details`,
- istnieje lokalny storage, ale nie jest jeszcze podlaczony do realnego flow discovery.

Brakuje przede wszystkim podpiecia realnych danych do ekranu glownego, wyszukiwania i szczegolow.

## 5. Zakres cyklu

Cycle 2 obejmuje:

- `ISSUE-C2-1 Build discovery lists and search flow`
- `ISSUE-C2-2 Build game details and connect discovery navigation`

## 6. Szczegolowe zadania

### TASK-1 Uporzadkowac feature structure dla discovery

Powiazanie:

- wspiera `ISSUE-C2-1` i `ISSUE-C2-2`.

Cel:

- przygotowac czytelny podzial na `data`, `state` i `presentation` dla feature'ow discovery.

Do zrobienia:

- dodac brakujace katalogi dla `features/home/`, `features/search/` i `features/game_details/`,
- wydzielic miejsce na repozytoria, datasource i stan ekranow,
- ograniczyc logike sieciowa w widgetach.

### TASK-2 Dodac warstwe repository dla discovery

Powiazanie:

- wspiera `ISSUE-C2-1` i `ISSUE-C2-2`.

Cel:

- przestac laczyc UI bezposrednio z klientem API.

Do zrobienia:

- zbudowac repozytorium dla list i szczegolow gier,
- oprzec je na istniejacym `RawgApiClient`,
- przygotowac prosty kontrakt pod dalszy reuzyt.

### TASK-3 Dodac prosty model stanow asynchronicznych

Powiazanie:

- wspiera `ISSUE-C2-1` i `ISSUE-C2-2`.

Cel:

- miec spojna obsluge `loading`, `success`, `empty`, `error`.

Do zrobienia:

- przygotowac prosty stan ekranu lub kontroler,
- unikac rozsianych booli po widgetach,
- zapewnic latwe retry i refresh.

### TASK-4 Zaimplementowac pierwszy realny `Home`

Powiazanie:

- wspiera `ISSUE-C2-1`.

Cel:

- pokazac realne listy gier na ekranie glownym.

Do zrobienia:

- pobrac co najmniej jedna lub dwie sekcje gier z `RAWG`,
- zastapic placeholder cards realnymi kartami,
- dodac loading, error i refresh.

### TASK-5 Zbudowac reuzywalna karte gry dla discovery

Powiazanie:

- wspiera `ISSUE-C2-1` i `ISSUE-C2-2`.

Cel:

- miec jeden wspolny komponent do list na `Home` i `Search`.

Do zrobienia:

- pokazac tytul, okladke lub tlo, rating i podstawowe meta,
- przewidziec klikniecie do szczegolow,
- utrzymac wyglad zgodny z theme.

### TASK-6 Zaimplementowac realne wyszukiwanie

Powiazanie:

- wspiera `ISSUE-C2-1`.

Cel:

- umozliwic wyszukiwanie gier po nazwie.

Do zrobienia:

- podpiac pole wyszukiwania do requestow API,
- dodac debounce lub inny prosty mechanizm ograniczania nadmiarowych requestow,
- pokazac wyniki, pusty stan i blad.

### TASK-7 Podpiac nawigacje z list do szczegolow gry

Powiazanie:

- wspiera `ISSUE-C2-2`.

Cel:

- domknac discovery flow end-to-end.

Do zrobienia:

- przechodzic z kart `Home` i wynikow `Search` do `Game Details`,
- przekazywac `gameId`,
- upewnic sie, ze flow dziala z routerem i shellem.

### TASK-8 Zaimplementowac realny ekran `Game Details`

Powiazanie:

- wspiera `ISSUE-C2-2`.

Cel:

- zastapic placeholder szczegolow realnymi danymi z API.

Do zrobienia:

- pobrac szczegoly gry po `id`,
- pokazac nazwe, grafike, opis, rating, date premiery, gatunki i platformy,
- obsluzyc loading i error,
- dodac prosty retry.

### TASK-9 Dodac dodatkowe media lub fallback wizualny dla details

Powiazanie:

- wspiera `ISSUE-C2-2`.

Cel:

- sprawic, by ekran szczegolow nie byl suchy wizualnie.

Do zrobienia:

- wykorzystac `background_image` jako hero,
- jesli scope pozwoli, dodac screenshoty lub dodatkowe grafiki,
- zapewnic sensowny fallback, gdy API nie zwroci obrazu.

### TASK-10 Spiac loading, empty i error states w discovery flow

Powiazanie:

- domyka caly cykl.

Cel:

- upewnic sie, ze glowny flow nie dziala tylko w scenariuszu happy path.

Do zrobienia:

- sprawdzic `Home`, `Search` i `Game Details`,
- dopilnowac czytelnych komunikatow i retry,
- usunac martwe placeholdery po wdrozeniu realnych widokow.

## 7. Proponowany podzial na issues

### ISSUE-C2-1 Build discovery lists and search flow

Obejmuje:

- `TASK-1`
- `TASK-2`
- `TASK-3`
- `TASK-4`
- `TASK-5`
- `TASK-6`

Rezultat:

- `Home` i `Search` dzialaja na realnych danych,
- discovery ma wspolne komponenty i podstawowa obsluge stanow.

### ISSUE-C2-2 Build game details and connect discovery navigation

Obejmuje:

- `TASK-1`
- `TASK-2`
- `TASK-3`
- `TASK-5`
- `TASK-7`
- `TASK-8`
- `TASK-9`
- `TASK-10`

Rezultat:

- uzytkownik moze przejsc z discovery do realnego ekranu szczegolow,
- flow `Home/Search -> Game Details` jest gotowy pod dalsze funkcje `Cycle 3`.

## 8. Kolejnosc realizacji

Najlepsza kolejnosc prac:

1. uporzadkowac structure i repository,
2. domknac `Home`,
3. domknac `Search`,
4. podpiac nawigacje do details,
5. domknac `Game Details`,
6. sprawdzic loading, empty i error states,
7. wykonac szybki sanity check.

## 9. Definition of done dla Cycle 2

Cycle 2 jest zamkniety, jesli:

- `Home` pokazuje realne listy gier,
- `Search` zwraca realne wyniki z API,
- uzytkownik moze wejsc do `Game Details` z elementow discovery,
- `Game Details` pokazuje realne dane gry,
- `Home`, `Search` i `Game Details` obsluguja `loading`, `empty` i `error`,
- nie ma juz technicznych placeholderow w glownym discovery flow,
- architektura nie miesza widgetow z logika requestow.

## 10. Verify po implementacji

Po zakonczeniu zmian nalezy uruchomic:

- `flutter analyze`,
- `flutter test`,
- manualny smoke run z `RAWG_API_KEY`,
- manualne sprawdzenie `Home -> Details`,
- manualne sprawdzenie `Search -> Details`,
- manualne sprawdzenie zachowania przy braku internetu lub bledzie API.

## 11. Rekomendacja koncowa

Najwazniejsze w tym cyklu jest dostarczenie pierwszego prawdziwego przeplywu produktowego, a nie perfekcyjnej architektury. Jesli trzeba wybierac, priorytet ma dzialajacy `Home`, `Search` i `Game Details` z sensownymi stanami, a nie rozbudowany framework stanu czy nadmiar abstrakcji.
