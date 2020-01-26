import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/pomodoro_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:quiver/async.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static CountdownTimer timer;
  int elapsedSec = 0;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PomodoroViewModel>(
        converter: (store) => PomodoroViewModel.create(store),
        builder: (context, vm) {
          return Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularPercentIndicator(
                    radius: 150.0,
                    lineWidth: 15.0,
                    percent: getCurrentPercentage(vm, elapsedSec / 60),
                    center: Text("$elapsedSec s"),
                    progressColor: Theme.of(context).primaryColor,
                    circularStrokeCap: CircularStrokeCap.round,
                    animation: true,
                    animateFromLastPercent: true,
                    header: Column(
                      children: <Widget>[
                        Text(
                            "State: ${vm.state.toString().split('.').last.toUpperCase()}"),
                        Text(
                            "Checkmarks: ${vm.checkmarks} of ${vm.totalCheckmarks}"),
                      ],
                    ),
                    startAngle: 0.0,
                    reverse: false,
                  ),
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
                      vm.setState(PomodoroState.none);
                      timer?.cancel();
                      setState(() {
                        elapsedSec = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  double getCurrentPercentage(PomodoroViewModel vm, double current) {
    switch (vm.state) {
      case PomodoroState.none:
        return 1.0;
      case PomodoroState.work:
        return (1 - ((100 * current) / vm.work) / 100).toDouble();
      case PomodoroState.shortBreak:
        return (1 - ((100 * current) / vm.shortBreak) / 100).toDouble();
      case PomodoroState.longBreak:
        return (1 - ((100 * current) / vm.longBreak) / 100).toDouble();
    }
    return 0.0;
  }

  void _startWork(PomodoroViewModel vm) {
    timer?.cancel();
    setState(() {
      timer = CountdownTimer(
        Duration(minutes: appStore.state.settings.work),
        Duration(seconds: 1),
      );
      elapsedSec = 0;
    });

    timer.listen((duration) {
      if (appStore.state.pomodoro.state == PomodoroState.none) {
        timer?.cancel();
        return;
      }
      setState(() {
        elapsedSec = duration.elapsed.inSeconds;
      });
    }, onDone: () {
      timer?.cancel();
      if (appStore.state.pomodoro.state == PomodoroState.work) {
        if (appStore.state.pomodoro.checkmarks <
            appStore.state.settings.checkmarks) {
          _startShortBreak(vm);
        } else {
          _startLongBreak(vm);
        }
      }
    });

    vm.setState(PomodoroState.work);
  }

  void _startShortBreak(PomodoroViewModel vm) {
    timer?.cancel();

    setState(() {
      timer = CountdownTimer(
        Duration(minutes: appStore.state.settings.shortBreak),
        Duration(seconds: 1),
      );
      elapsedSec = 0;
    });

    timer.listen((duration) {
      if (appStore.state.pomodoro.state == PomodoroState.none) {
        timer?.cancel();
        return;
      }
      setState(() {
        elapsedSec = duration.elapsed.inSeconds;
      });
    }, onDone: () {
      timer?.cancel();
      if (appStore.state.pomodoro.state == PomodoroState.shortBreak) {
        _startWork(vm);
      }
    });

    vm.setState(PomodoroState.shortBreak);
  }

  void _startLongBreak(PomodoroViewModel vm) {
    timer?.cancel();

    setState(() {
      timer = CountdownTimer(
        Duration(minutes: appStore.state.settings.longBreak),
        Duration(seconds: 1),
      );
      elapsedSec = 0;
    });

    timer.listen((duration) {
      if (appStore.state.pomodoro.state == PomodoroState.none) {
        timer?.cancel();
        return;
      }
      setState(() {
        elapsedSec = duration.elapsed.inSeconds;
      });
    }, onDone: () {
      timer?.cancel();
      if (appStore.state.pomodoro.state == PomodoroState.longBreak) {
        _startWork(vm);
      }
    });

    vm.setState(PomodoroState.longBreak);
  }
}
