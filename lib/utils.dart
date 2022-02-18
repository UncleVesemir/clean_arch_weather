class Utils {
  static String getWeekdayName(int num) {
    switch (num) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return 'error';
    }
  }

  static String toUpperCase(String value) {
    String result = '';
    for (var i = 0; i < value.length; i++) {
      if (i == 0) {
        result += value[i].toUpperCase();
      } else if (value[i] == ' ') {
        result += ' ' + value[i + 1].toUpperCase();
      } else if (value[i - 1] != ' ') {
        result += value[i];
      }
    }
    return result;
  }

  static String getMonthName(int num) {
    switch (num) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return 'error';
    }
  }
}
