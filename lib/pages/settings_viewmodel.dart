import 'package:flutter/foundation.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:redux/redux.dart';

class SettingsViewModel {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;
  final bool playSounds;
  final bool vibration;

  final Function(int) setWorkTime;
  final Function(int) setShortBreakTime;
  final Function(int) setLongBreakTime;
  final Function(int) setCheckmarks;
  final Function(bool) setPlaySounds;
  final Function(bool) setVibration;

  SettingsViewModel({
    @required this.work,
    @required this.shortBreak,
    @required this.longBreak,
    @required this.checkmarks,
    @required this.playSounds,
    @required this.vibration,
    @required this.setWorkTime,
    @required this.setShortBreakTime,
    @required this.setLongBreakTime,
    @required this.setCheckmarks,
    @required this.setPlaySounds,
    @required this.setVibration,
  });

  factory SettingsViewModel.create(Store<AppState> store) {
    // magic
    return SettingsViewModel(
      work: store.state.settings.work,
      shortBreak: store.state.settings.shortBreak,
      longBreak: store.state.settings.longBreak,
      checkmarks: store.state.settings.checkmarks,
      playSounds: store.state.settings.playSounds,
      vibration: store.state.settings.vibration,
      setWorkTime: (int time) => store.dispatch(
        SetSettingsAction(work: time),
      ),
      setShortBreakTime: (int time) => store.dispatch(
        SetSettingsAction(shortBreak: time),
      ),
      setLongBreakTime: (int time) => store.dispatch(
        SetSettingsAction(longBreak: time),
      ),
      setCheckmarks: (int value) => store.dispatch(
        SetSettingsAction(checkmarks: value),
      ),
      setPlaySounds: (bool enabled) => store.dispatch(
        SetSettingsAction(playSounds: enabled),
      ),
      setVibration: (bool enabled) => store.dispatch(
        SetSettingsAction(vibration: enabled),
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
          longBreak == other.longBreak &&
          checkmarks == other.checkmarks &&
          playSounds == other.playSounds &&
          vibration == other.vibration;

  @override
  int get hashCode =>
      work.hashCode ^
      shortBreak.hashCode ^
      longBreak.hashCode ^
      checkmarks.hashCode ^
      playSounds.hashCode ^
      vibration.hashCode;
}
