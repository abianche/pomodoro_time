import 'package:pomodoro_time/models/settings.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';

Settings settingsReducer(Settings state, action) {
  if (action is SetSettingsAction) {
    // copy only if specified
    return state.copyWith(
      work: action.work ?? state.work,
      shortBreak: action.shortBreak ?? state.shortBreak,
      longBreak: action.longBreak ?? state.longBreak,
      checkmarks: action.checkmarks ?? state.checkmarks,
      playSounds: action.playSounds ?? state.playSounds,
      vibration: action.vibration ?? state.vibration,
    );
  }

  if (action is ResetSettingsAction) {
    return Settings.initialState();
  }

  return state;
}
