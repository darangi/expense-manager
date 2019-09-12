class Sms {
  String text;
  DateTime date;
  String sender;
  Sms setText(String text) {
    this.text = text;
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
