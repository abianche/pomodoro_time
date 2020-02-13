import 'package:flutter/material.dart';
import 'package:pomodoro_time/models/pomodoro.dart' show PomodoroState;
import 'package:pomodoro_time/widgets/pomodoro.dart';
import 'package:pomodoro_time/redux/actions/pomodoro_actions.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:pomodoro_time/routes.dart';
import 'package:timer_builder/timer_builder.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  static Stopwatch stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pomodoro Time"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () async {
                if (appStore.state.pomodoro.state == PomodoroState.none) {
                  await Navigator.of(context).pushNamed(AppRoutes.settings);
                  return;
                }

                bool confirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Stop Pomodoro?"),
                        content: Text(
                            "To change the settings, the current Pomodoro time has to be stopped. Do you wish to continue?"),
                        actions: [
                          FlatButton(
                            child: Text(MaterialLocalizations.of(context)
                                .cancelButtonLabel),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text(MaterialLocalizations.of(context)
                                .continueButtonLabel),
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

                appStore.dispatch(StopAction());
                Pomodoro.stopwatch?.stop();
                Pomodoro.stopwatch?.reset();

                await Navigator.of(context).pushNamed(AppRoutes.settings);
              })
        ],
      ),
      body: Center(
        child: TimerBuilder.periodic(
          Duration(seconds: 1),
          builder: (context) => Pomodoro(),
        ),
      ),
    );
  }
}
