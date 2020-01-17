import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/reducers/settings_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    settings: settingsReducer(state.settings, action),
  );
}
