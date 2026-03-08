import 'package:flutter_test/flutter_test.dart';

import 'package:good_game_shelf/app/app.dart';

void main() {
  testWidgets('App shows splash branding', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('GoodGameShelf'), findsOneWidget);
  });
}
