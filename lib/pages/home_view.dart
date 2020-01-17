import 'package:flutter/material.dart';
import 'package:pomodoro_time/pages/settings_view.dart';

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
          )
        ],
      ),
      body: SettingsPage(),
    );
  }
}
