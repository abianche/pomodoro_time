import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';

class PomodoroViewModel {
  final int work;
  final int shortBreak;
  final int longBreak;

  PomodoroViewModel({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
  });

  factory PomodoroViewModel.create(Store<AppState> store) {
    // magic
    return PomodoroViewModel(
      work: store.state.settings.work,
      shortBreak: store.state.settings.shortBreak,
      longBreak: store.state.settings.longBreak,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroViewModel &&
          runtimeType == other.runtimeType &&
          work == other.work &&
          shortBreak == other.shortBreak &&
          longBreak == other.longBreak;

  @override
  int get hashCode => work.hashCode ^ shortBreak.hashCode ^ longBreak.hashCode;
}
