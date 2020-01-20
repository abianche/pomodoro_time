import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/constants.dart';
import 'package:pomodoro_time/models/settings.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Middleware<AppState>> createAppStateMiddleware() {
  return [
    if (kDebugMode)
      LoggingMiddleware.printer(
        formatter: customLineFormatter,
      ),
    loadSettings(),
    saveSettings(),
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

Middleware<AppState> saveSettings() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is SetSettingsAction) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      if (action.work != null) {
        await preferences.setInt(setting_work, action.work);
      }
      if (action.shortBreak != null) {
        await preferences.setInt(setting_short_break, action.shortBreak);
      }
      if (action.longBreak != null) {
        await preferences.setInt(setting_long_break, action.longBreak);
      }
    }

    next(action);
  };
}

Middleware<AppState> loadSettings() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoadSettingsAction) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      int work = preferences.getInt(setting_work) ?? Settings.default_work;
      int shortBreak = preferences.getInt(setting_short_break) ??
          Settings.default_short_break;
      int longBreak =
          preferences.getInt(setting_long_break) ?? Settings.default_long_break;

      store.dispatch(
        SetSettingsAction(
          work: work,
          shortBreak: shortBreak,
          longBreak: longBreak,
        ),
      );
    }

    next(action);
  };
}
