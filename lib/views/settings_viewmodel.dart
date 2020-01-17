import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';

class SettingsViewModel {
  final int work;
  final int shortBreak;
  final int longBreak;

  final Function(int) setWorkTime;
  final Function(int) setShortBreakTime;
  final Function(int) setLongBreakTime;

  SettingsViewModel({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
    @required this.setWorkTime,
    @required this.setShortBreakTime,
    @required this.setLongBreakTime,
  });

  factory SettingsViewModel.create(Store<AppState> store) {
    // magic
    return SettingsViewModel(
      work: store.state.settings.work,
      shortBreak: store.state.settings.shortBreak,
      longBreak: store.state.settings.longBreak,
      setWorkTime: (int time) => store.dispatch(
        SetSettingsAction(work: time),
      ),
      setShortBreakTime: (int time) => store.dispatch(
        SetSettingsAction(shortBreak: time),
      ),
      setLongBreakTime: (int time) => store.dispatch(
        SetSettingsAction(longBreak: time),
      ),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsViewModel &&
          runtimeType == other.runtimeType &&
          work == other.work &&
          shortBreak == other.shortBreak &&
          longBreak == other.longBreak;

  @override
  int get hashCode => work.hashCode ^ shortBreak.hashCode ^ longBreak.hashCode;
}
