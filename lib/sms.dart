class Sms {
  String text;
  DateTime date;
  String sender;
  String description;
  double amount;
  bool isCredit;
  
  Sms setTransactionType(bool isCredit) {
    this.isCredit = isCredit;
    return this;
  }

  Sms setAmount(double amount) {
    this.amount = amount;
    return this;
  }

  Sms setText(String text) {
    this.text = text;
    return this;
  }

  Sms setDescription(String description) {
    this.description = description;
    return this;
  }

  Sms setDate(DateTime date) {
    this.date = date;
    return this;
  }

  Sms setSender(String sender) {
    this.sender = sender;
    return this;
  }
}
