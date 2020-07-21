import 'package:intl/intl.dart';

class Date {

  static DateTime getCurrentDay() {
    var today = DateTime.now();
    return today;
  }

  static DateTime getPrevoiusDay() {
    var today = getCurrentDay();
    var yesterday = today.add(Duration(days: -1));
    return yesterday;
  }

  static String getFormatDate(DateTime date) {
    var formatter = DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return formatted;
  }


  static String checkDate(String date) {
    if(date == getFormatDate(getCurrentDay())) {
      return 'Today';
    }
    else if(date == getFormatDate(getPrevoiusDay())) {
      return 'Yesterday';
    }
    else {
      return getDescriptionDate(date);
    }
  }

  static getDescriptionDate(String date) {
    var year = date.substring(0, 4);
    var month = getMonth(int.parse(date.substring(5,7)));
    var day = date.substring(8, date.length);


    String result = '$day $month $year';
    return result;
  }

  static getMonth(int number) {
    switch (number) {
      case 1:
        return 'January';
      case 2:
        return 'Febuary';
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
    }
    return '';
  }

  static getShortMonthName(int number) {
    switch (number) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
    }
    return '';
  }

  static getShortWeekDay(int number) {
    switch (number) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tu';
      case 3:
        return 'Wed';
      case 4:
        return 'Th';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
    }
    return '';
  }

  static getFullDateForNewWeightCard(DateTime now) {
    DateTime now = DateTime.now();
    String result = '${now.day} ${getMonth(now.month)} ${now.year}';
    return result;
  }
}