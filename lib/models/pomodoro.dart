import 'package:flutter/material.dart';

enum State { none, work, shortBreak, longBreak }

class Pomodoro {
  final State state;

  Pomodoro({
    @required this.state,
  });

  Pomodoro.initialState() : state = State.none;

  Pomodoro copyWith({
    State state,
  }) =>
      Pomodoro(
        state: state ?? this.state,
      );

  @override
  int get hashCode => state.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pomodoro &&
          runtimeType == other.runtimeType &&
          state == other.state;
}
