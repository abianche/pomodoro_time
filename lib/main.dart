import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:pomodoro_time/pages/settings_viewmodel.dart';
import 'package:pomodoro_time/redux/actions/settings_actions.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/redux/store.dart';
import 'package:pomodoro_time/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: appStore,
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
      onInit: (state) {
        appStore.dispatch(LoadSettingsAction());
      },
      converter: (store) => SettingsViewModel.create(store),
      builder: (context, vm) => MaterialApp(
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
        darkTheme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0.0,
          ),
          brightness: Brightness.dark,
        ),
        themeMode: vm.themeMode,
      ),
    );
  }
}
