import 'package:flutter/material.dart';

enum PomodoroState { none, work, shortBreak, longBreak, pause }

/// FIXME: check where to place it
String getStateName(PomodoroState state) {
  switch (state) {
    case PomodoroState.none:
      return "-";
    case PomodoroState.work:
      return "Working";
    case PomodoroState.shortBreak:
      return "Short break";
    case PomodoroState.longBreak:
      return "Long break";
    case PomodoroState.pause:
      return "Paused";
    default:
      return "";
  }
}

@immutable
class Pomodoro {
  final PomodoroState state;
  final int checkmarks;

  Pomodoro({
    @required this.state,
    @required this.checkmarks,
  });

  bool isNone() => this.state == PomodoroState.none;
  bool isWorking() => this.state == PomodoroState.work;
  bool isShortBreak() => this.state == PomodoroState.shortBreak;
  bool isLongBreak() => this.state == PomodoroState.longBreak;
  bool isBreak() =>
      this.state == PomodoroState.shortBreak ||
      this.state == PomodoroState.longBreak;
  bool isPaused() => this.state == PomodoroState.pause;

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
