import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/pomodoro_viewmodel.dart';
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
    return StoreConnector<AppState, PomodoroViewModel>(
      converter: (store) => PomodoroViewModel.create(store),
      builder: (context, vm) => Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Time " + kDebugMode.toString()),
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
