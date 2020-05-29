class PlayTime {
  int timeVal;
  PlayTime({this.timeVal});

  int get seconds {
    return timeVal % 60;
  }

  int get minutes {
    return (timeVal - seconds) ~/ 60;
  }

  String getStringFormat() {
    int seconds = timeVal % 60;
    int minutes = (timeVal - seconds) ~/ 60;

    String secString = seconds < 10 ? '0$seconds' : seconds.toString();
    String minString = minutes < 10 ? '0$minutes' : minutes.toString();

    String retVal = '$minString:$secString';

    return retVal;
  }
}
