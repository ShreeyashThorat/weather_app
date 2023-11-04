import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDateTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    final dateFormat = DateFormat('EEEE, h:mm a');
    String formattedDateTime = dateFormat.format(dateTime);

    return formattedDateTime;
  }

  static String formatTime(String date) {
    DateTime dateTime = DateTime.parse(date);
    final timeFormat = DateFormat('h a');
    String formattedTime = timeFormat.format(dateTime);

    return formattedTime;
  }

  static String formatDay(String date) {
    DateTime dateTime = DateTime.parse(date);
    final timeFormat = DateFormat('EEE');
    String formattedDay = timeFormat.format(dateTime);

    return formattedDay;
  }
}
