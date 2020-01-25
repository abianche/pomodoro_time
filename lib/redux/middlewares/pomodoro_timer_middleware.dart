import 'dart:async';

import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:redux/redux.dart';

Middleware<AppState> pomodoroTimer() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    Timer timer = PomodoroTimer().timer;
    if (action is StartWorkingAction) {
      timer?.cancel();
      timer = Timer.periodic(Duration(seconds: appStore.state.settings.work),
          (timer) {
        timer?.cancel();
        if (appStore.state.pomodoro.state == PomodoroState.work) {
          if (appStore.state.pomodoro.checkmarks <
              appStore.state.settings.checkmarks) {
            store.dispatch(StartShortBreakAction());
          } else {
            store.dispatch(StartLongBreakAction());
          }
        }
      });
    }

    if (action is StartShortBreakAction) {
      timer?.cancel();
      timer = Timer.periodic(
          Duration(seconds: appStore.state.settings.shortBreak), (t) {
        timer?.cancel();
        if (appStore.state.pomodoro.state == PomodoroState.shortBreak) {
          store.dispatch(StartWorkingAction());
        }
      });
    }

    if (action is StartLongBreakAction) {
      timer?.cancel();
      timer = Timer.periodic(
          Duration(seconds: appStore.state.settings.longBreak), (t) {
        timer?.cancel();
        if (appStore.state.pomodoro.state == PomodoroState.longBreak) {
          store.dispatch(StartWorkingAction());
        }
      });
    }

    next(action);
  };
}

class PomodoroTimer {
  static final PomodoroTimer _pomodoroTimer = PomodoroTimer._internal();
  Timer timer;

  factory PomodoroTimer() {
    return _pomodoroTimer;
  }

  PomodoroTimer._internal();
}
