// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pomodoro_time/main.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/middleware.dart';
import 'package:pomodoro_time/redux/reducer.dart';
import 'package:redux/redux.dart';

final Store<AppState> appStore = Store<AppState>(
  appStateReducer,
  middleware: createAppStateMiddleware(),
  initialState: AppState.initialState(),
);

void main() {
  testWidgets('App has title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      StoreProvider(store: appStore, child: App()),
    );

    // Verify that our counter starts at 0.
    expect(find.text('Pomodoro Time'), findsOneWidget);
  });
}
