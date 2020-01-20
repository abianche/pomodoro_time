import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
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
                        ? () {
                            timer?.cancel();
                            timer = Timer.periodic(Duration(seconds: vm.work),
                                (timer) {
                              timer?.cancel();
                              print("WORK DONE");
                            });
                            vm.setState(PomodoroState.work);
                          }
                        : null,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_outline),
                    label: Text(vm.shortBreak.toString()),
                    onPressed: vm.state != PomodoroState.shortBreak
                        ? () {
                            timer?.cancel();
                            timer = Timer.periodic(
                                Duration(seconds: vm.shortBreak), (t) {
                              timer?.cancel();
                              print("SHORTBREAK DONE");
                            });
                            vm.setState(PomodoroState.shortBreak);
                          }
                        : null,
                  ),
                  FlatButton.icon(
                    icon: Icon(Icons.pause_circle_filled),
                    label: Text(vm.longBreak.toString()),
                    onPressed: vm.state != PomodoroState.longBreak
                        ? () {
                            timer?.cancel();
                            timer = Timer.periodic(
                                Duration(seconds: vm.longBreak), (t) {
                              timer?.cancel();
                              print("LONBREAK DONE");
                            });
                            vm.setState(PomodoroState.longBreak);
                          }
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
}
