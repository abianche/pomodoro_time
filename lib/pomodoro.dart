import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/pomodoro_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PomodoroViewModel>(
      converter: (store) => PomodoroViewModel.create(store),
      builder: (context, vm) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "State: ${vm.state.toString().split('.').last.toUpperCase()}"),
              Text("Checkmarks: ${vm.checkmarks} of ${vm.totalCheckmarks}"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.play_arrow),
                    label: Text(vm.work.toString()),
                    onPressed: vm.state != PomodoroState.work
                        ? () => _startWork(vm)
                        : null,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_outline),
                    label: Text(vm.shortBreak.toString()),
                    onPressed: vm.state != PomodoroState.shortBreak
                        ? () => _startShortBreak(vm)
                        : null,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_filled),
                    label: Text(vm.longBreak.toString()),
                    onPressed: vm.state != PomodoroState.longBreak
                        ? () => _startLongBreak(vm)
                        : null,
                  ),
                ],
              ),
              FlatButton.icon(
                icon: Icon(Icons.restore),
                label: Text("Reset"),
                onPressed: () {
                  timer?.cancel();
                  vm.setState(PomodoroState.none);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startWork(PomodoroViewModel vm) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: appStore.state.settings.work),
        (timer) {
      timer?.cancel();
      if (appStore.state.pomodoro.checkmarks <
          appStore.state.settings.checkmarks) {
        _startShortBreak(vm);
      } else {
        _startLongBreak(vm);
      }
    });
    vm.setState(PomodoroState.work);
  }

  void _startShortBreak(PomodoroViewModel vm) {
    timer?.cancel();
    timer = Timer.periodic(
        Duration(seconds: appStore.state.settings.shortBreak), (t) {
      timer?.cancel();
      _startWork(vm);
    });
    vm.setState(PomodoroState.shortBreak);
  }

  void _startLongBreak(PomodoroViewModel vm) {
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: appStore.state.settings.longBreak),
        (t) {
      timer?.cancel();
      _startWork(vm);
    });
    vm.setState(PomodoroState.longBreak);
  }
}
