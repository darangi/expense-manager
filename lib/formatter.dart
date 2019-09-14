import 'package:intl/intl.dart';

class Formatter {
  static String toHumanReadableDate(date) {
    return DateFormat.yMMMd().format(date);
  }

  static String toNaira(amount) {
    return NumberFormat.currency(symbol: "₦").format(amount).toString();
  }
}
