# Game Explorer Concept

## 1. Pomysl aplikacji

`Game Explorer` to mobilna aplikacja we Flutterze do przegladania gier wideo i sledzenia wlasnego progresu przechodzenia gier. Aplikacja pobiera dane o grach z zewnetrznego API `RAWG`, a lokalnie zapisuje ulubione gry, status przejscia i wlasna checkliste do zrobienia gry na 100%.

Nie jest to launcher ani tracker polaczony z kontem Steam lub PlayStation. To lekka aplikacja do odkrywania gier i recznego zarzadzania swoim postepem.

## 2. Glowny cel projektu

Projekt ma pokazac:

- ladny interfejs mobilny,
- animowany ekran startowy,
- obsluge kilku ekranow,
- komunikacje z zewnetrznym API,
- lokalne zapisywanie danych uzytkownika,
- sensowna logike aplikacji bez potrzeby pisania backendu.

## 3. Grupa docelowa

Aplikacja jest skierowana do osob, ktore:

- lubia gry i chca odkrywac nowe tytuly,
- chca zapisywac ulubione gry,
- chca sledzic, co aktualnie przechodza,
- chca recznie zaznaczac progres gry, np. fabula, zadania poboczne, wszystkie osiagniecia.

## 4. Zrodlo danych

Glowne zrodlo danych zewnetrznych:

- `RAWG API` - lista gier, wyszukiwanie, szczegoly gry, gatunki, platformy, screenshoty, ratingi, daty premier.

Dane lokalne w aplikacji:

- ulubione gry,
- status gry, np. `plan to play`, `playing`, `completed`, `100%`,
- wlasna checklista progresu,
- procent ukonczenia liczony na podstawie checklisty.

## 5. Glowne ekrany aplikacji

### E1. Splash screen

Cel:

- zrobic dobre pierwsze wrazenie i spelnic wymaganie animowanego ekranu startowego.

Zawartosc:

- logo aplikacji,
- animowane tlo inspirowane swiatem gier,
- plynne wejscie do glownego ekranu.

Pomysly na animacje:

- fade in logo,
- delikatny zoom tla,
- przesuwajace sie karty gier w tle,
- animowane gradienty lub swiatla neonowe.

### E2. Home

Cel:

- pokazac uzytkownikowi najciekawsze gry i pozwolic szybko wejsc dalej.

Zawartosc:

- sekcja `Trending Games`,
- sekcja `New Releases`,
- sekcja `Top Rated`,
- szybkie kafelki gatunkow,
- pole przejscia do wyszukiwarki.

### E3. Search

Cel:

- pozwolic wyszukiwac gry po nazwie.

Zawartosc:

- pasek wyszukiwania,
- lista wynikow,
- stan pusty przy braku wynikow,
- loader podczas pobierania danych.

Opcjonalnie:

- ostatnie wyszukiwania zapisywane lokalnie,
- filtrowanie po gatunku lub platformie.

### E4. Game Details

Cel:

- pokazac szczegoly wybranej gry.

Zawartosc:

- okladka lub grafika hero,
- nazwa gry,
- data premiery,
- rating,
- Metacritic,
- platformy,
- gatunki,
- opis gry,
- screenshoty,
- przyciski `Add to Favorites` i `Add to Library`.

### E5. My Library

Cel:

- zebrac gry zapisane przez uzytkownika.

Zawartosc:

- zakladki lub filtry:
  - `Favorites`,
  - `Playing`,
  - `Completed`,
  - `100%`.

Kazda karta gry moze pokazywac:

- obrazek,
- tytul,
- status,
- procent progresu.

### E6. Progress Tracker

Cel:

- pozwolic recznie odznaczac, co zostalo juz zrobione w danej grze.

Zawartosc:

- lista punktow checklisty,
- mozliwosc dodawania wlasnych punktow,
- oznaczanie pozycji jako wykonane lub niewykonane,
- pasek progresu procentowego,
- szybka zmiana statusu gry.

Przyklady checklisty dla gry:

- ukoncz fabule,
- zrob wszystkie misje poboczne,
- odblokuj wszystkie zakonczenia,
- znajdz wszystkie sekrety,
- zdobadz wszystkie osiagniecia.

## 6. Glowny flow uzytkownika

1. uzytkownik otwiera aplikacje i widzi animowany splash screen,
2. przechodzi do home i przeglada popularne gry,
3. wyszukuje konkretna gre, np. `Cyberpunk 2077`,
4. otwiera szczegoly gry,
5. dodaje gre do swojej biblioteki,
6. ustawia status gry,
7. tworzy lub uzupelnia checkliste progresu,
8. wraca do biblioteki i widzi procent ukonczenia.

## 7. Co robi aplikacja, a czego nie robi

### Aplikacja robi

- pobiera dane o grach z RAWG,
- wyswietla listy i szczegoly gier,
- pozwala budowac lokalna biblioteke,
- pozwala sledzic progres przejscia,
- zapisuje dane lokalnie na urzadzeniu.

### Aplikacja nie robi w MVP

- nie loguje sie do Steam, Xbox ani PlayStation,
- nie pobiera prawdziwych osiagniec uzytkownika z kont platformowych,
- nie ma wlasnego backendu,
- nie synchronizuje danych miedzy urzadzeniami,
- nie ma kont uzytkownikow.

## 8. Elementy, ktore dadza efekt wow

- mocny splash screen z animacja,
- duze karty gier z obrazami,
- plynne przejscie z listy do szczegolow gry,
- karuzela screenshotow,
- gradientowe tlo dopasowane do klimatu gry,
- elegancki progress bar w trackerze ukonczenia.

## 9. Minimalny zakres MVP

Do pierwszej wersji wystarczy:

- splash screen,
- home z listami z API,
- search,
- game details,
- my library,
- progress tracker,
- lokalne zapisywanie ulubionych i checklisty.

To juz daje kompletny i atrakcyjny projekt na studia.
