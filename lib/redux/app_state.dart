import 'package:flutter/material.dart';
import 'package:pomodoro_time/models/settings.dart';

@immutable
class AppState {
  final Settings settings;

  AppState({
    this.settings,
  });

  AppState.initialState() : settings = Settings.initialState();

  AppState copyWith({
    Settings settings,
  }) {
    return AppState(
      settings: settings ?? this.settings,
    );
  }

  @override
  int get hashCode => settings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          settings == other.settings;
}
