import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:pomodoro_time/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    appStore.dispatch(LoadSettingsAction());

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
