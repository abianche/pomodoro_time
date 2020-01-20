import 'package:flutter/material.dart';
import 'package:pomodoro_time/models/settings.dart';
import 'package:pomodoro_time/models/pomodoro.dart';

@immutable
class AppState {
  final Settings settings;
  final Pomodoro pomodoro;

  AppState({
    this.settings,
    this.pomodoro,
  });

  AppState.initialState()
      : settings = Settings.initialState(),
        pomodoro = Pomodoro.initialState();

  AppState copyWith({
    Settings settings,
    Pomodoro pomodoro,
  }) {
    return AppState(
      settings: settings ?? this.settings,
      pomodoro: pomodoro ?? this.pomodoro,
    );
  }

  @override
  int get hashCode => settings.hashCode ^ pomodoro.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          settings == other.settings &&
          pomodoro == other.pomodoro;
}
