import 'package:expense_manager/data/patterns.dart';

class Filter {
  String text;
  RegExp exp;
  Patterns patterns;
  Filter(text) {
    this.text = text;
    patterns = new Patterns();
  }

  bool isCredit() {
    return new RegExp(r"(cr|credit)", caseSensitive: false).hasMatch(this.text);
  }

  String extractDescription() {
    /**
         * Extract the description for every alert
         */
    var matchers = patterns.matchers.map((matcher) {
      return matcher.description;
    }).join("|");

    exp = new RegExp(r"(" + matchers + ")(\\w{1,}.+)", caseSensitive: false);
    var description = exp.stringMatch(text);

    return description;
  }

  double extractAmount() {
    /**
         * if you have around a billion naira in any of your transaction, I am sorry this app is not for you.
         * Improve regex in the future, serious help
         */
    String matchers = patterns.matchers.map((matcher) {
      return matcher.amount;
    }).join("|");
    String regexString = "r(" +
        matchers +
        ")(\\d{1,}[,\\.]\\d{1,}[,\\.]\\d{1,}[,\\.]\\d{1,})|(" +
        matchers +
        ")(\\d{1,}[,\\.])\\d{1,}[,\\.]\\d{1,}|(" +
        matchers +
        ")(\\d{1,}[,\\.])\\d{1,}|(" +
        matchers +
        ")(\\d{1,})";
    var amount =
        new RegExp(regexString, caseSensitive: false).stringMatch(text);

    double result = amount != null
        ? double.tryParse(amount.replaceAllMapped(
            new RegExp("(" + matchers + "|,)", caseSensitive: false), (m) {
            return "";
          }))
        : 0;
    return result;
  }
}
