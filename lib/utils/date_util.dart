import 'package:intl/intl.dart';

class DateUtil {
  final MILLIS_IN_SECOND = 1000;
  final MILLIS_IN_MINUTE = 60 * 1000;
  final MILLIS_IN_HOUR = 60 * (60 * 1000);
  final MILLIS_IN_DAY = 24 * (60 * (60 * 1000));

  static const SlashShortDateFormat = "dd/MM/yyyy";
  static const dashLongDateFormatWithMsZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const dashLongDateFormatWithZ = "yyyy-MM-dd'T'HH:mm:ss'Z'";
  static const dashLongDateFormat = "yyyy-MM-dd'T'HH:mm:ss";
  static const dashLongDateTimeFormat = "yyyy-MM-dd hh:mm aaa";
  static const dashLongDateTimeFormatMS = "yyyy-MM-dd hh:mm:ss";
  static const fullDateFormat = "EEEE, d MMM 'at' hh:mm aaa";
  static const dayMonthDateFormat = "dd/MM/yyyy";
  static const MonthYearDateFormat = "MM/yy";
  static const YearMonthDateFormat = "yy/MM";

  static DateTime parseStringToDate(String inputStr, String inputPattern) {
    if (!inputStr.contains('.')) {
      inputStr = inputStr.replaceAll('+', '.48+');
    } else if (inputStr.contains('.')) {
      var split = inputStr.split('.');
      if (split.isNotEmpty && split[1].length > 3) {
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
