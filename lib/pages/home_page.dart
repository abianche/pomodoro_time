import 'package:flutter/material.dart';
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
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.settings),
          )
        ],
      ),
      body: Center(
        child: Text("HOME"),
      ),
    );
  }
}
