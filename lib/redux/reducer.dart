import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/reducers/pomodoro_reducer.dart';
import 'package:pomodoro_time/redux/reducers/settings_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    settings: settingsReducer(state.settings, action),
    pomodoro: pomodoroReducer(state.pomodoro, action),
  );
}
