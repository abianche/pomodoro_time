import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';

@immutable
class PomodoroViewModel {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;
  final int totalCheckmarks;
  final Pomodoro pomodoro;

  final Function(PomodoroState) setState;

  PomodoroViewModel({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
    @required this.pomodoro,
    @required this.checkmarks,
    @required this.totalCheckmarks,
    @required this.setState,
  });

  factory PomodoroViewModel.create(Store<AppState> store) {
    // magic
    return PomodoroViewModel(
      work: store.state.settings.work,
      shortBreak: store.state.settings.shortBreak,
      longBreak: store.state.settings.longBreak,
      pomodoro: store.state.pomodoro,
      checkmarks: store.state.pomodoro.checkmarks,
      totalCheckmarks: store.state.settings.checkmarks,
      setState: (PomodoroState state) {
        switch (state) {
          case PomodoroState.none:
            store.dispatch(StopAction());
            break;
          case PomodoroState.work:
            store.dispatch(StartWorkingAction());
            break;
          case PomodoroState.shortBreak:
            store.dispatch(StartShortBreakAction());
            break;
          case PomodoroState.longBreak:
            store.dispatch(StartLongBreakAction());
            break;
          case PomodoroState.pause:
            store.dispatch(PauseAction());
            break;
        }
      },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PomodoroViewModel &&
          runtimeType == other.runtimeType &&
          work == other.work &&
          shortBreak == other.shortBreak &&
          longBreak == other.longBreak &&
          checkmarks == other.checkmarks &&
          totalCheckmarks == other.totalCheckmarks &&
          pomodoro == other.pomodoro;

  @override
  int get hashCode =>
      work.hashCode ^
      shortBreak.hashCode ^
      longBreak.hashCode ^
      pomodoro.hashCode ^
      totalCheckmarks.hashCode ^
      checkmarks.hashCode;
}
