import 'package:flutter/material.dart';
import 'package:pomodoro_time/constants.dart';
import 'package:pomodoro_time/models/settings.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

Middleware<AppState> saveSettings() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
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
      if (action.checkmarks != null) {
        await preferences.setInt(setting_checkmarks, action.checkmarks);
      }
      if (action.playSounds != null) {
        await preferences.setBool(setting_play_sounds, action.playSounds);
      }
      if (action.vibration != null) {
        await preferences.setBool(setting_vibration, action.vibration);
      }
      if (action.themeMode != null) {
        await preferences.setInt(setting_dark_theme, action.themeMode.index);
      }
    }

    next(action);
  };
}

Middleware<AppState> loadSettings() {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is LoadSettingsAction) {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      int work = preferences.getInt(setting_work) ?? Settings.default_work;
      int shortBreak = preferences.getInt(setting_short_break) ??
          Settings.default_short_break;
      int longBreak =
          preferences.getInt(setting_long_break) ?? Settings.default_long_break;
      int checkmarks =
          preferences.getInt(setting_checkmarks) ?? Settings.default_checkmarks;
      bool playSounds = preferences.getBool(setting_play_sounds) ?? true;
      bool vibration = preferences.getBool(setting_vibration) ?? true;
      ThemeMode themeMode = ThemeMode.values
          .elementAt(preferences.getInt(setting_dark_theme) ?? 0);

      store.dispatch(
        SetSettingsAction(
          work: work,
          shortBreak: shortBreak,
          longBreak: longBreak,
          checkmarks: checkmarks,
          playSounds: playSounds,
          vibration: vibration,
          themeMode: themeMode,
          isLoading: false,
        ),
      );
    }

    next(action);
  };
}
