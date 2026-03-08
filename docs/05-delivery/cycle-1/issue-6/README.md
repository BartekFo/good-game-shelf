# ISSUE-C1-6 Setup local storage foundation

## Status

Status po przegladzie repo: `zaimplementowane`.

## Co jest juz zrobione

Dowody w repo:

- zaleznosc `shared_preferences` jest dodana w `pubspec.yaml`,
- storage bootstrap istnieje w `lib/core/storage/app_storage.dart`,
- `lib/main.dart` wywoluje `AppStorage.init()`,
- modele lokalne istnieja w `lib/core/storage/local_saved_game.dart`, `lib/core/storage/local_game_progress.dart`, `lib/core/storage/local_game_status.dart` i `lib/core/storage/local_checklist_item.dart`,
- modele maja podstawowe mapowanie `toJson` i `fromJson`.

## Co jeszcze zostalo

- lokalnie potwierdzic, ze zapis i odczyt danych dziala poprawnie,
- opcjonalnie zdecydowac pozniej, czy `shared_preferences` pozostaje docelowym rozwiazaniem czy tylko foundation pod dalsza migracje.

## Ocena

To issue mozna uznac za zamkniete na poziomie foundation wymaganym przez `Cycle 1`.
