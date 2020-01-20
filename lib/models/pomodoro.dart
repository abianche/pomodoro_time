import 'package:flutter/material.dart';

enum PomodoroState { none, work, shortBreak, longBreak }

class Pomodoro {
  final PomodoroState state;
  final int checkmarks;

  Pomodoro({
    @required this.state,
    @required this.checkmarks,
  });

  Pomodoro.initialState()
      : state = PomodoroState.none,
        checkmarks = 0;

  Pomodoro copyWith({
    PomodoroState state,
    int checkmarks,
  }) =>
      Pomodoro(
        state: state ?? this.state,
        checkmarks: checkmarks ?? this.checkmarks,
      );

  @override
  int get hashCode => state.hashCode ^ checkmarks.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pomodoro &&
          runtimeType == other.runtimeType &&
          checkmarks == other.checkmarks &&
          state == other.state;
}
