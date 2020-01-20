import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  return [
    if (kDebugMode)
      LoggingMiddleware.printer(
        formatter: customLineFormatter,
      ),
  ];
}

String customLineFormatter(
  dynamic _state,
  dynamic action,
  DateTime timestamp,
) {
  return "\n" +
      "  Action     ${action.runtimeType.toString()},\n" +
      "  Payload    {${action.toString()}},\n" +
      "  Timestamp  ${DateTime.now()}\n" +
      "";
}
