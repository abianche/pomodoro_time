import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';

Pomodoro pomodoroReducer(Pomodoro state, action) {
  if (action is StartWorkingAction) {
    return state.copyWith(state: State.work);
  }

  if (action is StartShortBreakAction) {
    return state.copyWith(state: State.shortBreak);
  }

  if (action is StartLongBreakAction) {
    return state.copyWith(state: State.longBreak);
  }

  if (action is StopAction) {
    return state.copyWith(state: State.none);
  }

  return state;
}
