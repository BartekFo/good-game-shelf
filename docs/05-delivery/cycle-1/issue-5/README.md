# ISSUE-C1-5 Setup RAWG API foundation

## Status

Status po przegladzie repo: `zaimplementowane z drobnymi punktami do weryfikacji`.

## Co jest juz zrobione

Dowody w repo:

- zaleznosc HTTP istnieje w `pubspec.yaml` jako `dio`,
- podstawowa abstrakcja klienta istnieje w `lib/core/network/api_client.dart`,
- klient domenowy `RAWG` istnieje w `lib/core/network/rawg_api_client.dart`,
- endpointy sa zebrane w `lib/core/network/rawg_endpoints.dart`,
- konfiguracja `baseUrl` i `apiKey` istnieje w `lib/core/network/rawg_config.dart`,
- odczyt sekretu przez `String.fromEnvironment('RAWG_API_KEY')` istnieje w `lib/core/config/app_env.dart`,
- podstawowe DTO dla listy gry i szczegolow gry istnieja w `lib/core/models/rawg_game_summary_dto.dart` i `lib/core/models/rawg_game_details_dto.dart`.

## Co jeszcze zostalo

- wykonac realny lub smoke request lokalnie z ustawionym `RAWG_API_KEY`,
- sprawdzic, czy obecne fail-fast zachowanie przy braku klucza jest akceptowalne przed `Cycle 2`,
- jesli potrzeba, dodac bardziej przyjazny fallback lub komunikat UI dla braku klucza.

## Ocena

Foundation API jest gotowy do dalszej pracy. To issue nie blokuje `Cycle 2`, o ile lokalna weryfikacja requestow nie ujawni problemu.
