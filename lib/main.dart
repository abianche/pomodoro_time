import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Time',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Icon(Icons.play_arrow),
          FlatButton(
            child: Text("TEST"),
            onPressed: () async {
              await showTimePicker(
                  context: context, initialTime: TimeOfDay.now());
            },
          ),
        ],
      ),
    );
  }
}
