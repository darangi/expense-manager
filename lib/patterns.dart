class Patterns {
  List<Matcher> matchers = new List();
  Patterns() {
    matchers.addAll([
      new Matcher()
          .setAmountPattern("CREDIT:NGN|DEBIT:NGN")
          .setDescriptionPattern("DETAILS:"),
      new Matcher().setAmountPattern("AMT:N").setDescriptionPattern("desc:"),
      new Matcher().setAmountPattern("AMT:NGN ").setDescriptionPattern("desc:")
    ]);
  }
}

class Matcher {
  String _description;
  String _amount;

  String get description => _description;

  String get amount => _amount;

  Matcher setDescriptionPattern(String description) {
    this._description = description;
    return this;
  }

  Matcher setAmountPattern(String amount) {
    this._amount = amount;
    return this;
  }
}
