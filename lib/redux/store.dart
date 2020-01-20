import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/middleware.dart';
import 'package:pomodoro_time/redux/reducer.dart';
import 'package:redux/redux.dart';

final Store<AppState> appStore = Store<AppState>(
  appStateReducer,
  middleware: createAppStateMiddleware(),
  initialState: AppState.initialState(),
);
