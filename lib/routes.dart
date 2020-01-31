import 'package:flutter/material.dart';
import 'package:pomodoro_time/pages/home_page.dart';
import 'package:pomodoro_time/pages/settings_page.dart';

class AppRoutes {
  static const home = "/";
  static const settings = "/settings";
}

Route<dynamic> buildOnGenerateRuoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute<void>(builder: (_) => HomePage());
    case AppRoutes.settings:
      return MaterialPageRoute<void>(builder: (_) => SettingsPage());
    default:
      return MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
