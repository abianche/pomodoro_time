import 'package:flutter/material.dart';

class Settings {
  static const int default_work = 25;
  static const int default_short_break = 5;
  static const int default_long_break = 20;

  static const int min_work_length = 10;
  static const int min_short_break_length = 2;
  static const int min_long_break_length = 15;
  static const int max_work_length = 60;
  static const int max_short_break_length = 10;
  static const int max_long_break_length = 30;

  final int work;
  final int shortBreak;
  final int longBreak;

  Settings({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
  });

  Settings.initialState()
      : work = default_work,
        shortBreak = default_short_break,
        longBreak = default_long_break;

  Settings copyWith({
    int work,
    int shortBreak,
    int longBreak,
  }) =>
      Settings(
        work: work ?? this.work,
        shortBreak: shortBreak ?? this.shortBreak,
        longBreak: longBreak ?? this.longBreak,
      );

  @override
  int get hashCode => work.hashCode ^ shortBreak.hashCode ^ longBreak.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Settings &&
          runtimeType == other.runtimeType &&
          work == other.work &&
          shortBreak == other.shortBreak &&
          longBreak == other.longBreak;
}
