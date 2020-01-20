import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pomodoro_time/models/settings.dart';
import 'package:pomodoro_time/redux/app_state.dart';
import 'package:pomodoro_time/pages/settings_viewmodel.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _workSliderValue = Settings.default_work.toDouble();
  double _shortBreakSliderValue = Settings.default_short_break.toDouble();
  double _longBreakSliderValue = Settings.default_long_break.toDouble();
  int _checkmarksValue = Settings.default_checkmarks;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SettingsViewModel>(
      distinct: true,
      converter: (store) => SettingsViewModel.create(store),
      onInitialBuild: (vm) {
        setState(() {
          _workSliderValue = vm.work.toDouble();
          _shortBreakSliderValue = vm.shortBreak.toDouble();
          _longBreakSliderValue = vm.longBreak.toDouble();
          _checkmarksValue = vm.checkmarks;
        });
      },
      onDidChange: (vm) {
        setState(() {
          _workSliderValue = vm.work.toDouble();
          _shortBreakSliderValue = vm.shortBreak.toDouble();
          _longBreakSliderValue = vm.longBreak.toDouble();
          _checkmarksValue = vm.checkmarks;
        });
      },
      builder: (context, vm) => Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: <Widget>[
              Slider.adaptive(
                value: _workSliderValue,
                min: Settings.min_work_length.toDouble(),
                max: Settings.max_work_length.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _workSliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  if (value == vm.work) return;

                  vm.setWorkTime(value.toInt());
                },
                divisions: Settings.max_work_length - Settings.min_work_length,
                label: _workSliderValue.toInt().toString(),
              ),
              Slider.adaptive(
                value: _shortBreakSliderValue,
                min: Settings.min_short_break_length.toDouble(),
                max: Settings.max_short_break_length.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _shortBreakSliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  if (value == vm.shortBreak) return;

                  vm.setShortBreakTime(value.toInt());
                },
                divisions: Settings.max_short_break_length -
                    Settings.min_short_break_length,
                label: _shortBreakSliderValue.toInt().toString(),
              ),
              Slider.adaptive(
                value: _longBreakSliderValue,
                min: Settings.min_long_break_length.toDouble(),
                max: Settings.max_long_break_length.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _longBreakSliderValue = value;
                  });
                },
                onChangeEnd: (value) {
                  if (value == vm.longBreak) return;

                  vm.setLongBreakTime(value.toInt());
                },
                divisions: Settings.max_long_break_length -
                    Settings.min_long_break_length,
                label: _longBreakSliderValue.toInt().toString(),
              ),
              NumberPicker.horizontal(
                initialValue: _checkmarksValue,
                minValue: 1,
                maxValue: 10,
                onChanged: (value) {
                  if (value == vm.checkmarks) return;

                  setState(() => _checkmarksValue = value);
                  vm.setCheckmarks(value.toInt());
                },
              ),
              SizedBox(
                height: 100,
              ),
              Text(
                "W ${vm.work}   S ${vm.shortBreak}   L ${vm.longBreak}",
                style: TextStyle(
                  fontSize: 32.0,
                ),
              ),
              Text(
                "Checkmarks: ${vm.checkmarks}",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
