import 'package:flutter/material.dart';
import 'package:pomodoro_time/views/settings_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SettingsView(),
    );
  }
}
