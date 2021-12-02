import 'package:intl/intl.dart';

class DateUtil {
  final MILLIS_IN_SECOND = 1000;
  final MILLIS_IN_MINUTE = 60 * 1000;
  final MILLIS_IN_HOUR = 60 * (60 * 1000);
  final MILLIS_IN_DAY = 24 * (60 * (60 * 1000));

  static final SlashShortDateFormat = "dd/MM/yyyy";
  static final dashLongDateFormatWithMsZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static final dashLongDateFormatWithZ = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static final dashLongDateFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static final dashLongDateTimeFormat = "yyyy-MM-dd hh:mm aaa";
  static final dashLongDateTimeFormatMS = "yyyy-MM-dd hh:mm:ss";
  static final fullDateFormat = "EEEE, d MMM 'at' hh:mm aaa";
  static final dayMonthDateFormat = "dd/MM/yyyy";
  static final MonthYearDateFormat = "MM/yy";
  static final YearMonthDateFormat = "yy/MM";

  static DateTime parseStringToDate(String inputStr, String inputPattern) {
    if (!inputStr.contains('.')) {
      inputStr = inputStr.replaceAll('+', '.48+');
    } else if (inputStr.contains('.')) {
      var split = inputStr.split('.');
      if (split.length > 0 && split[1].length > 3) {
        inputStr = "${split[0]}.${split[0].substring(0, 3)}";
      }
    }

    if (inputStr.contains('+')) {
      inputStr = inputStr.replaceAll('+', ' ').split(' ').first;
    }

    if (!inputStr.endsWith('Z')) {
      inputStr += 'Z';
    }

    final formatter = DateFormat(inputPattern, 'en');

    var dateTimeFromStr = formatter.parse(inputStr);
    return dateTimeFromStr;
  }

  static String formatDate(String outputPattern, DateTime inputDate) {
    return DateFormat(outputPattern, 'en').format(inputDate);
  }

  static String getDateformatted(
      {String? inputStr, String? outputFormat, String? inputFormat}) {
    var dateTime = parseStringToDate(inputStr ?? "", inputFormat ?? "");
    return formatDate(outputFormat ?? "", dateTime);
  }
}
