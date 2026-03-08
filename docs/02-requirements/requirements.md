# Requirements

## 1. Cel dokumentu

Dokument opisuje wymagania funkcjonalne i niefunkcjonalne dla aplikacji `Game Explorer`.

## 2. Wymagania funkcjonalne

### FR1. Animowany ekran startowy

- aplikacja musi miec ekran startowy z animacja,
- ekran startowy powinien zawierac logo lub nazwe aplikacji,
- po zakonczeniu animacji uzytkownik przechodzi do ekranu glownego.

### FR2. Pobieranie list gier z zewnetrznego API

- aplikacja musi pobierac dane o grach z `RAWG API`,
- aplikacja powinna wyswietlac co najmniej jedna liste gier na ekranie glownym,
- aplikacja powinna obslugiwac stan ladowania i stan bledu.

### FR3. Wyswietlanie sekcji na ekranie Home

- ekran home powinien zawierac sekcje takie jak `Trending`, `New Releases` lub `Top Rated`,
- uzytkownik powinien moc kliknac gre i przejsc do jej szczegolow,
- aplikacja powinna umozliwic odswiezenie list.

### FR4. Wyszukiwanie gier

- uzytkownik musi moc wyszukac gre po nazwie,
- aplikacja powinna wyswietlac liste wynikow,
- aplikacja powinna obslugiwac przypadek pustych wynikow.

### FR5. Ekran szczegolow gry

- aplikacja musi wyswietlac szczegoly wybranej gry,
- szczegoly powinny zawierac co najmniej nazwe, okladke, opis, rating, date premiery, platformy i gatunki,
- aplikacja powinna wyswietlac screenshoty lub dodatkowe grafiki, jesli API je zwroci.

### FR6. Dodawanie gry do biblioteki

- uzytkownik musi moc dodac gre do swojej lokalnej biblioteki,
- uzytkownik musi moc usunac gre z biblioteki,
- aplikacja musi zapamietywac biblioteke po ponownym uruchomieniu.

### FR7. Zarzadzanie statusem gry

- uzytkownik musi moc ustawic status gry,
- dostepne statusy powinny obejmowac przynajmniej `plan to play`, `playing`, `completed`, `100%`,
- status musi byc widoczny w bibliotece i w szczegolach gry.

### FR8. Progress tracker i checklista

- dla gry zapisanej w bibliotece uzytkownik musi moc tworzyc checkliste progresu,
- uzytkownik musi moc dodawac wlasne punkty checklisty,
- uzytkownik musi moc oznaczac punkty jako wykonane lub niewykonane,
- aplikacja musi wyliczac procent ukonczenia na podstawie checklisty.

### FR9. Widok biblioteki uzytkownika

- aplikacja musi miec ekran `My Library`,
- ekran biblioteki powinien pokazywac zapisane gry,
- biblioteka powinna dawac mozliwosc filtrowania po statusie,
- kazda pozycja powinna pokazywac tytul, okladke i progres.

### FR10. Lokalne zapisywanie danych

- ulubione gry, statusy i checklista musza byc zapisane lokalnie,
- po restarcie aplikacji dane powinny zostac odtworzone,
- aplikacja nie wymaga logowania uzytkownika.

## 3. Wymagania niefunkcjonalne

### NFR1. Prostota projektu

- aplikacja ma byc mozliwa do wykonania bez wlasnego backendu,
- glowne dane zewnetrzne maja pochodzic z publicznego API,
- logika lokalna ma pozostac prosta i zrozumiala.

### NFR2. Uzytecznosc

- nawigacja miedzy ekranami powinna byc intuicyjna,
- kluczowe akcje powinny byc latwo dostepne,
- widok szczegolow nie powinien byc przeladowany informacjami,
- aplikacja powinna wygladac dobrze na typowym telefonie.

### NFR3. Wydajnosc

- aplikacja powinna uruchamiac sie szybko,
- listy gier powinny ladowac sie plynnie,
- przewijanie list i przejscia miedzy ekranami powinny byc plynne,
- obrazy powinny byc ladowane w sposob nieblokujacy interfejsu.

### NFR4. Niezawodnosc

- aplikacja powinna poprawnie obslugiwac brak internetu,
- aplikacja powinna wyswietlic czytelny komunikat bledu przy problemie z API,
- lokalnie zapisane dane nie powinny ginac przy ponownym uruchomieniu.

### NFR5. Estetyka i prezentacja

- aplikacja powinna miec spojny, nowoczesny wyglad,
- splash screen powinien dawac efekt wow,
- karty gier i ekran szczegolow powinny mocno wykorzystywac grafiki,
- animacje powinny byc plynne, ale nienachalne.

### NFR6. Utrzymywalnosc

- kod powinien byc podzielony na moduly lub feature'y,
- komunikacja z API powinna byc oddzielona od warstwy UI,
- logika lokalnego storage powinna byc oddzielona od ekranow.

### NFR7. Skalowalnosc na poziomie projektu studenckiego

- architektura powinna pozwalac latwo dodac nowe ekrany,
- architektura powinna pozwalac dodac kolejne filtry lub kategorie gier,
- w przyszlosci powinna byc mozliwa rozbudowa o backend, ale nie jest on wymagany teraz.

### NFR8. Zgodnosc z API

- aplikacja musi korzystac z `RAWG API` zgodnie z limitem zapytan i warunkami uzycia,
- jesli API wymaga atrybucji, aplikacja powinna uwzglednic informacje o zrodle danych,
- aplikacja nie powinna rehostowac ani redistribuowac danych poza zakresem projektu.

## 4. Zakres MVP

Do MVP wchodza:

- splash screen,
- home,
- search,
- game details,
- my library,
- progress tracker,
- integracja z RAWG,
- lokalne zapisywanie danych.

## 5. Poza MVP

Poza pierwsza wersja zostaja:

- logowanie uzytkownikow,
- synchronizacja miedzy urzadzeniami,
- prawdziwe achievementy pobierane z platform,
- backend,
- recenzje i komentarze uzytkownikow,
- rozbudowane filtrowanie wielokryterialne.
