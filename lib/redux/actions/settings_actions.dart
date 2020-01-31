class SetSettingsAction {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;
  final bool playSounds;
  final bool vibration;
  final bool darkTheme;

  SetSettingsAction({
    this.work,
    this.shortBreak,
    this.longBreak,
    this.checkmarks,
    this.playSounds,
    this.vibration,
    this.darkTheme,
  });

  @override
  String toString() =>
      "work: $work, shortBreak : $shortBreak, longBreak: $longBreak, checkmarks: $checkmarks, playSounds: $playSounds, vibration: $vibration, darkTheme: $darkTheme";
}

class ResetSettingsAction {}

class LoadSettingsAction {}
