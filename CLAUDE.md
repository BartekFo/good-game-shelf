# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Run Commands

```bash
flutter pub get                                    # Install dependencies
flutter run --dart-define=RAWG_API_KEY=<key>       # Run with API key
flutter analyze                                    # Static analysis (linting)
flutter test                                       # Run all tests
flutter test test/widget_test.dart                 # Run a single test file
dart format lib/ test/                             # Format code
flutter clean && flutter pub get                   # Clean rebuild
```

The app requires a RAWG.io API key passed via `--dart-define=RAWG_API_KEY=...` at build/run time.

## Architecture

**Flutter app** (Dart 3.11+, Material Design 3) for tracking and discovering video games. Uses RAWG.io as the game database API.

### Feature-first structure under `lib/`

- **`app/`** — MaterialApp setup (`app.dart`) and bottom navigation shell (`app_shell.dart`)
- **`core/`** — Shared infrastructure: networking (Dio-based API client), navigation (go_router), theme system, async state, local storage
- **`features/`** — Each feature has up to three layers: `presentation/`, `state/`, `data/`
- **`shared/widgets/`** — Reusable UI components (e.g., `game_card.dart`)

### Key patterns

- **State management:** `ChangeNotifier` subclasses (`*_notifier.dart`) consumed via `ListenableBuilder` — no Provider package
- **Async state:** Sealed class `AsyncState<T>` with four variants (`AsyncLoading`, `AsyncData`, `AsyncEmpty`, `AsyncError`). UI handles all variants via `switch` expressions
- **Navigation:** `go_router` with `StatefulShellRoute` maintaining separate stacks per bottom tab. Routes defined in `app_routes.dart`
- **Networking:** `ApiClient` (Dio wrapper) → `RawgApiClient` → feature repositories
- **Local storage:** `AppStorage` wraps `SharedPreferences`, initialized in `main.dart` before app start
- **DTOs:** `*_dto.dart` models for API responses with `fromJson` factories

### Theme system (`core/theme/`)

Custom design tokens: `AppColors`, `AppSpacing`, `AppRadius`, `AppShadows` — used directly throughout widgets rather than through ThemeData extensions.

## Documentation

Project docs are in `docs/` (written in Polish): concept, requirements, architecture decisions, product strategy, and delivery cycles with user stories.
