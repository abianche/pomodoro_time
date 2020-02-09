import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/widgets/pomodoro_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/extensions.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);
  static AudioCache player = AudioCache(prefix: 'sounds/');

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  static Stopwatch stopwatch = Stopwatch();

  Duration remainingTime(PomodoroViewModel vm) {
    if (vm.pomodoro.isWorking()) {
      return Duration(seconds: vm.work) - stopwatch?.elapsed;
    }
    if (vm.pomodoro.isShortBreak()) {
      return Duration(seconds: vm.shortBreak) - stopwatch?.elapsed;
    }
    if (vm.pomodoro.isLongBreak()) {
      return Duration(seconds: vm.longBreak) - stopwatch?.elapsed;
    }

    return Duration.zero;
  }

  Duration currentTime(PomodoroViewModel vm) {
    if (vm.pomodoro.isWorking()) {
      return Duration(seconds: vm.work);
    }
    if (vm.pomodoro.isShortBreak()) {
      return Duration(seconds: vm.shortBreak);
    }
    if (vm.pomodoro.isLongBreak()) {
      return Duration(seconds: vm.longBreak);
    }

    return Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PomodoroViewModel>(
        converter: (store) => PomodoroViewModel.create(store),
        builder: (context, vm) {
          PomodoroState next;
          if (vm.pomodoro.isWorking() && vm.checkmarks < vm.totalCheckmarks) {
            next = PomodoroState.shortBreak;
          }
          if (vm.pomodoro.isWorking() && vm.checkmarks == vm.totalCheckmarks) {
            next = PomodoroState.longBreak;
          }
          if (vm.pomodoro.isBreak()) {
            next = PomodoroState.work;
          }

          if (stopwatch.elapsed >= currentTime(vm)) {
            stopwatch.stop();
            stopwatch.reset();
            vm.setState(next);
          }

          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50.0),
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.height / 2.5,
                  lineWidth: 30.0,
                  percent: getCurrentPercentage(
                      vm, stopwatch?.elapsed?.inSeconds ?? 0 / 60),
                  header: AutoSizeText(
                    getStateName(vm.pomodoro.state),
                    maxLines: 1,
                    maxFontSize: 32.0,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  center: SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          remainingTime(vm).printDuration(),
                          maxLines: 1,
                          maxFontSize: 64.0,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 64.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  footer: Column(
                    children: <Widget>[
                      stopwatch?.isRunning ?? false
                          ? FlatButton(
                              child: Text(
                                "Pause",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () => pausePomodoro(vm))
                          : FlatButton(
                              child: Text(
                                "Start",
                                style: TextStyle(fontSize: 28),
                              ),
                              onPressed: () => startPomodoro(vm)),
                      SizedBox(height: 18.0),
                      if (next != null) Text("Next up: ${getStateName(next)}"),
                      if (next == null) Text(""),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animateFromLastPercent: true,
                  startAngle: 0.0,
                  reverse: false,
                ),
              ],
            ),
          );
        });
  }

  double getCurrentPercentage(PomodoroViewModel vm, num current) {
    switch (vm.pomodoro.state) {
      case PomodoroState.none:
        return 1.0;
      case PomodoroState.work:
        return (1 - ((100 * current) / vm.work) / 100)
            .clamp(0.0, 1.0)
            .toDouble();
      case PomodoroState.shortBreak:
        return (1 - ((100 * current) / vm.shortBreak) / 100)
            .clamp(0.0, 1.0)
            .toDouble();
      case PomodoroState.longBreak:
        return (1 - ((100 * current) / vm.longBreak) / 100)
            .clamp(0.0, 1.0)
            .toDouble();
      default:
        return 0.0;
    }
  }

  void pausePomodoro(PomodoroViewModel vm) {
    stopwatch.stop();
  }

  void startPomodoro(PomodoroViewModel vm) {
    stopwatch.start();

    // setState(() {
    //   timer = CountdownTimer(
    //     Duration(seconds: appStore.state.settings.work),
    //     Duration(seconds: 1),
    //   );
    //   elapsed = Duration.zero;
    //   remaining = Duration(seconds: appStore.state.settings.work) -
    //       Duration(seconds: 1);
    // });

    // timer.listen((duration) {
    //   if (appStore.state.pomodoro.state != PomodoroState.work) {
    //     timer?.cancel();
    //     return;
    //   }
    //   setState(() {
    //     elapsed = duration.elapsed;
    //     remaining = duration.remaining;
    //   });
    // }, onDone: () {
    //   timer?.cancel();
    //   if (appStore.state.pomodoro.state == PomodoroState.work) {
    //     if (appStore.state.pomodoro.checkmarks <
    //         appStore.state.settings.checkmarks) {
    //       _startShortBreak(vm);
    //     } else {
    //       _startLongBreak(vm);
    //     }
    //   }
    //   if (appStore.state.pomodoro.state != PomodoroState.none) {
    //     if (appStore.state.settings.playSounds) {
    //       Pomodoro.player.play('tone1.mp3');
    //     }
    //     if (appStore.state.settings.vibration) {
    //       Vibration.vibrate(pattern: [50, 200, 50, 200]);
    //     }
    //   }
    // });

    vm.setState(PomodoroState.work);
  }

  // void _startShortBreak(PomodoroViewModel vm) {
  //   stopTimers();

  //   setState(() {
  //     timer = CountdownTimer(
  //       Duration(seconds: appStore.state.settings.shortBreak),
  //       Duration(seconds: 1),
  //     );
  //     elapsed = Duration.zero;
  //     remaining = Duration(seconds: appStore.state.settings.shortBreak) -
  //         Duration(seconds: 1);
  //   });

  //   timer.listen((duration) {
  //     if (appStore.state.pomodoro.state != PomodoroState.shortBreak) {
  //       timer?.cancel();
  //       return;
  //     }
  //     setState(() {
  //       elapsed = duration.elapsed;
  //       remaining = duration.remaining;
  //     });
  //   }, onDone: () {
  //     timer?.cancel();
  //     if (appStore.state.pomodoro.state == PomodoroState.shortBreak) {
  //       _startWork(vm);
  //     }
  //     if (appStore.state.pomodoro.state != PomodoroState.none) {
  //       if (appStore.state.settings.playSounds) {
  //         Pomodoro.player.play('tone2.mp3');
  //       }
  //       if (appStore.state.settings.vibration) {
  //         Vibration.vibrate(pattern: [50, 200, 50, 200]);
  //       }
  //     }
  //   });

  //   vm.setState(PomodoroState.shortBreak);
  // }

  // void _startLongBreak(PomodoroViewModel vm) {
  //   stopTimers();

  //   setState(() {
  //     timer = CountdownTimer(
  //       Duration(seconds: appStore.state.settings.longBreak),
  //       Duration(seconds: 1),
  //     );
  //     elapsed = Duration.zero;
  //     remaining = Duration(seconds: appStore.state.settings.longBreak) -
  //         Duration(seconds: 1);
  //   });

  //   timer.listen((duration) {
  //     if (appStore.state.pomodoro.state != PomodoroState.longBreak) {
  //       timer?.cancel();
  //       return;
  //     }
  //     setState(() {
  //       elapsed = duration.elapsed;
  //       remaining = duration.remaining;
  //     });
  //   }, onDone: () {
  //     timer?.cancel();
  //     if (appStore.state.pomodoro.state == PomodoroState.longBreak) {
  //       _startWork(vm);
  //     }
  //     if (appStore.state.pomodoro.state != PomodoroState.none) {
  //       if (appStore.state.settings.playSounds) {
  //         Pomodoro.player.play('tone3.mp3');
  //       }
  //       if (appStore.state.settings.vibration) {
  //         Vibration.vibrate();
  //       }
  //     }
  //   });

  //   vm.setState(PomodoroState.longBreak);
  // }
}
