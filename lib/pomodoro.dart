import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/pomodoro_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:pomodoro_time/extensions.dart';
import 'package:quiver/async.dart';
import 'package:vibration/vibration.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);
  static AudioCache player = AudioCache(prefix: 'sounds/');

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static CountdownTimer workTimer;
  static CountdownTimer shortBreakTimer;
  static CountdownTimer longBreakTimer;

  Duration elapsed = Duration.zero;
  Duration remaining = Duration.zero;

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
                    percent: getCurrentPercentage(vm, elapsed.inSeconds / 60),
                    center: Text(getStateName(vm.state)),
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
                    footer: Text(remaining.printDuration()),
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

                      stopTimers();

                      setState(() {
                        elapsed = Duration.zero;
                        remaining = Duration.zero;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void stopTimers() {
    workTimer?.cancel();
    shortBreakTimer?.cancel();
    longBreakTimer?.cancel();

    workTimer = null;
    shortBreakTimer = null;
    longBreakTimer = null;
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
      default:
        return 0.0;
    }
  }

  void _startWork(PomodoroViewModel vm) {
    stopTimers();

    setState(() {
      workTimer = CountdownTimer(
        Duration(minutes: appStore.state.settings.work),
        Duration(seconds: 1),
      );
      elapsed = Duration.zero;
      remaining = Duration(minutes: appStore.state.settings.work) -
          Duration(seconds: 1);
    });

    workTimer.listen((duration) {
      if (appStore.state.pomodoro.state != PomodoroState.work) {
        workTimer?.cancel();
        return;
      }
      setState(() {
        elapsed = duration.elapsed;
        remaining = duration.remaining;
      });
    }, onDone: () {
      // workTimer?.cancel();
      // if (appStore.state.pomodoro.state == PomodoroState.work) {
      //   if (appStore.state.pomodoro.checkmarks <
      //       appStore.state.settings.checkmarks) {
      //     _startShortBreak(vm);
      //   } else {
      //     _startLongBreak(vm);
      //   }
      // }
      if (appStore.state.pomodoro.state != PomodoroState.none) {
        if (appStore.state.settings.playSounds) {
          Pomodoro.player.play('tone1.mp3');
        }
        if (appStore.state.settings.vibration) {
          Vibration.vibrate(pattern: [50, 200, 50, 200]);
        }
      }
    });

    vm.setState(PomodoroState.work);
  }

  void _startShortBreak(PomodoroViewModel vm) {
    stopTimers();

    setState(() {
      shortBreakTimer = CountdownTimer(
        Duration(minutes: appStore.state.settings.shortBreak),
        Duration(seconds: 1),
      );
      elapsed = Duration.zero;
      remaining = Duration(minutes: appStore.state.settings.shortBreak) -
          Duration(seconds: 1);
    });

    shortBreakTimer.listen((duration) {
      if (appStore.state.pomodoro.state != PomodoroState.shortBreak) {
        shortBreakTimer?.cancel();
        return;
      }
      setState(() {
        elapsed = duration.elapsed;
        remaining = duration.remaining;
      });
    }, onDone: () {
      // shortBreakTimer?.cancel();
      // if (appStore.state.pomodoro.state == PomodoroState.shortBreak) {
      //   _startWork(vm);
      // }
      if (appStore.state.pomodoro.state != PomodoroState.none) {
        if (appStore.state.settings.playSounds) {
          Pomodoro.player.play('tone2.mp3');
        }
        if (appStore.state.settings.vibration) {
          Vibration.vibrate(pattern: [50, 200, 50, 200]);
        }
      }
    });

    vm.setState(PomodoroState.shortBreak);
  }

  void _startLongBreak(PomodoroViewModel vm) {
    stopTimers();

    setState(() {
      longBreakTimer = CountdownTimer(
        Duration(minutes: appStore.state.settings.longBreak),
        Duration(seconds: 1),
      );
      elapsed = Duration.zero;
      remaining = Duration(minutes: appStore.state.settings.longBreak) -
          Duration(seconds: 1);
    });

    longBreakTimer.listen((duration) {
      if (appStore.state.pomodoro.state != PomodoroState.longBreak) {
        longBreakTimer?.cancel();
        return;
      }
      setState(() {
        elapsed = duration.elapsed;
        remaining = duration.remaining;
      });
    }, onDone: () {
      //   longBreakTimer?.cancel();
      //   if (appStore.state.pomodoro.state == PomodoroState.longBreak) {
      //     _startWork(vm);
      //   }
      if (appStore.state.pomodoro.state != PomodoroState.none) {
        if (appStore.state.settings.playSounds) {
          Pomodoro.player.play('tone3.mp3');
        }
        if (appStore.state.settings.vibration) {
          Vibration.vibrate();
        }
      }
    });

    vm.setState(PomodoroState.longBreak);
  }
}
