import 'package:intl/intl.dart';

class DateParser{

  static String parseDate(DateTime date){

    String formattedDate = DateFormat("dd.MM.yyyy").format(date);
    

    return formattedDate;

  }
}