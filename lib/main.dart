import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/reducer.dart';
import 'package:pomodoro_time/routes.dart';
import 'package:redux/redux.dart';

// TODO: load settings
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
        initialRoute: AppRoutes.home,
        onGenerateRoute: buildOnGenerateRuoute,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            elevation: 0.0,
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
