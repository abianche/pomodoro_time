import 'package:quiver/async.dart';

import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:redux/redux.dart';

Middleware<AppState> pomodoroTimer() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    CountdownTimer timer = PomodoroTimer().timer;
    if (action is StartWorkingAction) {
      timer?.cancel();
      timer = CountdownTimer(
        Duration(seconds: appStore.state.settings.work),
        Duration(seconds: 1),
      );

      timer.listen(null, onDone: () {
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
      timer = CountdownTimer(
        Duration(seconds: appStore.state.settings.shortBreak),
        Duration(seconds: 1),
      );

      timer.listen(null, onDone: () {
        timer?.cancel();
        if (appStore.state.pomodoro.state == PomodoroState.shortBreak) {
          store.dispatch(StartWorkingAction());
        }
      });
    }

    if (action is StartLongBreakAction) {
      timer?.cancel();
      timer = CountdownTimer(
        Duration(seconds: appStore.state.settings.longBreak),
        Duration(seconds: 1),
      );

      timer.listen(null, onDone: () {
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
  CountdownTimer timer;

  factory PomodoroTimer() {
    return _pomodoroTimer;
  }

  PomodoroTimer._internal();
}
