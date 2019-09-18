class Patterns {
  List<Matcher> matchers = new List();
  Patterns() {
    matchers.addAll([
      new Matcher()
        ..setAmountPattern("CREDIT:|DEBIT:")
        ..setDescriptionPattern("DETAILS:"),
      new Matcher()
        ..setAmountPattern("AMT:")
        ..setDescriptionPattern("desc:")
    ]);
  }
}

class Matcher {
  String _description;
  String _amount;

  String get description => _description;

  String get amount => _amount;

  void setDescriptionPattern(String description) {
    this._description = description;
  }

  void setAmountPattern(String amount) {
    this._amount = amount;
  }
}
