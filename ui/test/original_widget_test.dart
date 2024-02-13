// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/ui/original/original_view.dart';

void main() {
  testWidgets('오리지널 유저 가져오기 ing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(ProviderScope(child: OriginalView()));

    // Verify that our counter starts at 0.
    expect(find.text('wait'), findsOneWidget);

    // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.text('유저 가져오기'));
    // await tester.pump();
    //
    // Verify that our counter has incremented.
    // expect(find.text('wait'), findsNothing);
    // expect(find.text('사용자 데이터를 가져오는 중입니다.'), findsOneWidget);
  });
}
