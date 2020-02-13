import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';

Pomodoro pomodoroReducer(Pomodoro state, dynamic action) {
  if (action is StartWorkingAction) {
    return state.copyWith(state: PomodoroState.work);
  }

  if (action is StartShortBreakAction) {
    return state.copyWith(
      state: PomodoroState.shortBreak,
      checkmarks: state.checkmarks + 1,
    );
  }

  if (action is StartLongBreakAction) {
    return state.copyWith(
      state: PomodoroState.longBreak,
      checkmarks: 0,
    );
  }

  if (action is StopAction) {
    return state.copyWith(
      state: PomodoroState.none,
      checkmarks: 0,
    );
  }

  if (action is PauseAction) {
    return state.copyWith(
      state: PomodoroState.pause,
    );
  }

  return state;
}
