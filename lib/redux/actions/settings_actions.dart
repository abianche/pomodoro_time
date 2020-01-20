class SetSettingsAction {
  final int work;
  final int shortBreak;
  final int longBreak;

  SetSettingsAction({
    this.work,
    this.shortBreak,
    this.longBreak,
  });

  @override
  String toString() =>
      "work: $work, shortBreak : $shortBreak, longBreak: $longBreak";
}

class ResetSettingsAction {}

class LoadSettingsAction {}
