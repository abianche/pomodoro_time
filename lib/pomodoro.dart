import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/pages/settings_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  Timer timer;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
      converter: (store) => SettingsViewModel.create(store),
      builder: (context, vm) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Time"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                    icon: Icon(Icons.play_arrow),
                    label: Text(vm.work.toString()),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_outline),
                    label: Text(vm.shortBreak.toString()),
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_filled),
                    label: Text(vm.longBreak.toString()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
