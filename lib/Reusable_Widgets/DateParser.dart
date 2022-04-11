import 'package:intl/intl.dart';

class DateParser{

  static String parseDate(DateTime date){

    String formattedDate = DateFormat("dd.MM.yyyy").format(date);
    
    return formattedDate;
  }

  static bool isSameDay(DateTime dateTime1, DateTime dateTime2) {
    // ignore hour,minute,second..
    final dateFormat = DateFormat("yyyy-MM-dd");
    final date1 = dateFormat.format(dateTime1);
    final date2 = dateFormat.format(dateTime2);
    return date1 == date2;
  }
}