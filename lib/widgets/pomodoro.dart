import 'package:audioplayers/audio_cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_time/models/pomodoro.dart';
import 'package:pomodoro_time/theme.dart';
import 'package:pomodoro_time/widgets/pomodoro_viewmodel.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/extensions.dart';

class Pomodoro extends StatefulWidget {
  const Pomodoro({Key key}) : super(key: key);
  static AudioCache player = AudioCache(prefix: 'sounds/');
  static Stopwatch stopwatch = Stopwatch();

  @override
  _PomodoroState createState() => _PomodoroState();
}

class _PomodoroState extends State<Pomodoro> {
  PomodoroState previousState = PomodoroState.none;

  Duration remainingTime(PomodoroViewModel vm) {
    PomodoroState currentState = vm.pomodoro.state;
    if (vm.pomodoro.isPaused()) {
      currentState = previousState;
    }

    if (currentState == PomodoroState.work) {
      return Duration(minutes: vm.work) - Pomodoro.stopwatch?.elapsed;
    }
    if (currentState == PomodoroState.shortBreak) {
      return Duration(minutes: vm.shortBreak) - Pomodoro.stopwatch?.elapsed;
    }
    if (currentState == PomodoroState.longBreak) {
      return Duration(minutes: vm.longBreak) - Pomodoro.stopwatch?.elapsed;
    }

    return Duration.zero;
  }

  Duration currentTime(PomodoroViewModel vm) {
    if (vm.pomodoro.isWorking()) {
      return Duration(minutes: vm.work);
    }
    if (vm.pomodoro.isShortBreak()) {
      return Duration(minutes: vm.shortBreak);
    }
    if (vm.pomodoro.isLongBreak()) {
      return Duration(minutes: vm.longBreak);
    }

    return Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PomodoroViewModel>(
        converter: (store) => PomodoroViewModel.create(store),
        builder: (context, vm) {
          PomodoroState next = PomodoroState.work;
          if (vm.pomodoro.isWorking() && vm.checkmarks < vm.totalCheckmarks) {
            next = PomodoroState.shortBreak;
          }
          if (vm.pomodoro.isWorking() && vm.checkmarks == vm.totalCheckmarks) {
            next = PomodoroState.longBreak;
          }
          if (vm.pomodoro.isBreak()) {
            next = PomodoroState.work;
          }

          if (vm.pomodoro.isWorking() || vm.pomodoro.isBreak()) {
            if (Pomodoro.stopwatch.elapsed >= currentTime(vm)) {
              Pomodoro.stopwatch.stop();
              Pomodoro.stopwatch.reset();

              vm.setState(next);
              Pomodoro.stopwatch.start();
            }
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
                      vm, Pomodoro.stopwatch?.elapsed?.inMinutes ?? 0 / 60),
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
                      vm.pomodoro.state == PomodoroState.pause
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Continue",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  onPressed: () => continuePomodoro(vm),
                                ),
                                FlatButton(
                                  child: Text(
                                    "Stop",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  onPressed: () => stopPomodoro(vm),
                                ),
                              ],
                            )
                          : vm.pomodoro.state == PomodoroState.none
                              ? FlatButton(
                                  child: Text(
                                    "Start",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  onPressed: () => startPomodoro(vm),
                                )
                              : FlatButton(
                                  child: Text(
                                    "Pause",
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  onPressed: () => pausePomodoro(vm),
                                ),
                      SizedBox(height: 18.0),
                      next != null
                          ? Text("Next up: ${getStateName(next)}")
                          : Text(""),
                      SizedBox(height: 18.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (var i = 0; i < vm.totalCheckmarks; i++)
                            i < vm.checkmarks
                                ? Icon(Icons.radio_button_checked)
                                : Icon(Icons.radio_button_unchecked)
                        ],
                      )
                    ],
                  ),
                  progressColor:
                      vm.pomodoro.isPaused() ? Colors.grey : Palette.blood_red,
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
      case PomodoroState.pause:
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
    Pomodoro.stopwatch.stop();

    setState(() {
      previousState = vm.pomodoro.state;
    });

    vm.setState(PomodoroState.pause);
  }

  void continuePomodoro(PomodoroViewModel vm) {
    Pomodoro.stopwatch.start();

    vm.setState(previousState);
  }

  void startPomodoro(PomodoroViewModel vm) {
    Pomodoro.stopwatch.start();

    vm.setState(PomodoroState.work);
  }

  void stopPomodoro(PomodoroViewModel vm) async {
    Pomodoro.stopwatch.stop();

    bool confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Stop Pomodoro?"),
            content: Text("Do you want to stop the current Pomodoro time?"),
            actions: [
              FlatButton(
                child:
                    Text(MaterialLocalizations.of(context).cancelButtonLabel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(MaterialLocalizations.of(context).okButtonLabel),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });

    if (confirmed == null || !confirmed) {
      return;
    }

    Pomodoro.stopwatch.reset();

    vm.setState(PomodoroState.none);
  }
}
