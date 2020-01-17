import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/reducer.dart';
import 'package:pomodoro_time/views/home_view.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Store<AppState> appStore = Store<AppState>(
      appStateReducer,
      initialState: AppState.initialState(),
    );

    return StoreProvider(
      store: appStore,
      child: MaterialApp(
        title: 'Pomodoro Time',
        home: HomePage(),
      ),
    );
  }
}
