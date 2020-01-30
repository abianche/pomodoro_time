class SetSettingsAction {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;
  final bool playSounds;
  final bool vibration;

  SetSettingsAction({
    this.work,
    this.shortBreak,
    this.longBreak,
    this.checkmarks,
    this.playSounds,
    this.vibration,
  });

  @override
  String toString() =>
      "work: $work, shortBreak : $shortBreak, longBreak: $longBreak, checkmarks: $checkmarks, playSounds: $playSounds, vibration: $vibration";
}

class ResetSettingsAction {}

class LoadSettingsAction {}
