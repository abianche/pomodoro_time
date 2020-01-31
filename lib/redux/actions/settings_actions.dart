import 'package:flutter/material.dart';

class SetSettingsAction {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;
  final bool playSounds;
  final bool vibration;
  final ThemeMode themeMode;

  final bool isLoading;

  SetSettingsAction({
    this.work,
    this.shortBreak,
    this.longBreak,
    this.checkmarks,
    this.playSounds,
    this.vibration,
    this.themeMode,
    this.isLoading,
  });

  @override
  String toString() => """

      work        $work
      shortBreak  $shortBreak
      longBreak   $longBreak
      checkmarks  $checkmarks
      playSounds  $playSounds
      vibration   $vibration
      themeMode   $themeMode
      isLoading   $isLoading
      """;
}

class ResetSettingsAction {}

class LoadSettingsAction {}
