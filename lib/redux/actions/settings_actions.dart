class SetSettingsAction {
  final int work;
  final int shortBreak;
  final int longBreak;
  final int checkmarks;

  SetSettingsAction({
    this.work,
    this.shortBreak,
    this.longBreak,
    this.checkmarks,
  });

  @override
  String toString() =>
      "work: $work, shortBreak : $shortBreak, longBreak: $longBreak, checkmarks: $checkmarks";
}

class ResetSettingsAction {}

class LoadSettingsAction {}
