# ISSUE-C1-7 Build animated splash and transition

## Status

Status po przegladzie repo: `zaimplementowane`.

## Co jest juz zrobione

Dowody w repo:

- `lib/features/splash/presentation/splash_screen.dart` zawiera osobny ekran splasha,
- splash ma animacje `fade` i `scale`,
- po czasie nastepuje przejscie do `AppRoutes.home`,
- przejscie korzysta z `context.go(...)`, wiec splash nie powinien wracac przez standardowy back flow,
- branding splasha jest podpiety pod `AppConstants` i wspolny theme.

## Co jeszcze zostalo

- potwierdzic lokalnie plynnosc animacji i zachowanie przejscia na rzeczywistym urzadzeniu lub emulatorze.

## Ocena

Od strony zakresu `Cycle 1` to issue jest gotowe i nie blokuje `Cycle 2`.
