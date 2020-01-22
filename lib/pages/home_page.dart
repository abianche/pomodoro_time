import 'package:flutter/material.dart';
import 'package:pomodoro_time/models/pomodoro.dart' show PomodoroState;
import 'package:pomodoro_time/pomodoro.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:pomodoro_time/routes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

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
                  Navigator.of(context).pushNamed(AppRoutes.settings);
                  return;
                }

                bool confirmed = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("title"),
                        content: Text("asd"),
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

                /// TODO: stop timer
                Navigator.of(context).pushNamed(AppRoutes.settings);
              })
        ],
      ),
      body: Center(
        child: Pomodoro(),
      ),
    );
  }
}
