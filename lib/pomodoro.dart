import 'package:flutter/material.dart';

class Pomodoro extends StatelessWidget {
  const Pomodoro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Time"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_arrow),
                ),
                IconButton(
                  icon: Icon(Icons.pause_circle_outline),
                ),
                IconButton(
                  icon: Icon(Icons.pause_circle_filled),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
