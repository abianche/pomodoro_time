import 'package:flutter/material.dart';

@immutable
class Settings {
  static const int default_work = 25;
  static const int default_short_break = 5;
  static const int default_long_break = 20;
  static const int default_checkmarks = 4;

  static const int min_work_length = 10;
  static const int min_short_break_length = 2;
  static const int min_long_break_length = 15;
  static const int max_work_length = 60;
  static const int max_short_break_length = 10;
  static const int max_long_break_length = 30;

  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;

  final bool playSounds;
  final bool vibration;
  final ThemeMode themeMode;

  final bool isLoading;

  Settings({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
    @required this.checkmarks,
    @required this.playSounds,
    @required this.vibration,
    @required this.themeMode,
    @required this.isLoading,
  });

  Settings.initialState()
      : work = default_work,
        shortBreak = default_short_break,
        longBreak = default_long_break,
        checkmarks = default_checkmarks,
        playSounds = true,
        vibration = true,
        themeMode = ThemeMode.system,
        isLoading = false;

  Settings copyWith({
    int work,
    int shortBreak,
    int longBreak,
    int checkmarks,
    bool playSounds,
    bool vibration,
    ThemeMode themeMode,
    bool isLoading,
  }) =>
      Settings(
        work: work ?? this.work,
        shortBreak: shortBreak ?? this.shortBreak,
        longBreak: longBreak ?? this.longBreak,
        checkmarks: checkmarks ?? this.checkmarks,
        playSounds: playSounds ?? this.playSounds,
        vibration: vibration ?? this.vibration,
        themeMode: themeMode ?? this.themeMode,
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  int get hashCode =>
      work.hashCode ^
      shortBreak.hashCode ^
      longBreak.hashCode ^
      checkmarks.hashCode ^
      playSounds.hashCode ^
      vibration.hashCode ^
      themeMode.hashCode ^
      isLoading.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Settings &&
          runtimeType == other.runtimeType &&
          work == other.work &&
          shortBreak == other.shortBreak &&
          longBreak == other.longBreak &&
          checkmarks == other.checkmarks &&
          playSounds == other.playSounds &&
          vibration == other.vibration &&
          themeMode == other.themeMode &&
          isLoading == other.isLoading;
}
