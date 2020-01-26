extension PrintDuration on Duration {
  String printDuration() {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(inMinutes.remainder(60));
    String seconds = twoDigits(inSeconds.remainder(60));

    if (inHours == 0) {
      return "$minutes:$seconds";
    }

    String hours = twoDigits(inHours);
    return "$hours:$minutes:$seconds";
  }
}
