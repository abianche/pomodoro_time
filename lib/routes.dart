import 'package:flutter/material.dart';
import 'package:pomodoro_time/pages/home_page.dart';
import 'package:pomodoro_time/pages/settings_page.dart';

class AppRoutes {
  static const root = "/";
  static const home = "/home";
  static const settings = "/home/settings";
}

Route<dynamic> buildOnGenerateRuoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomePage());
    case AppRoutes.settings:
      return MaterialPageRoute(builder: (_) => SettingsPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
