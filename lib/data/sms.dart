class Sms {
  String text;
  DateTime date;
  String sender;
  String description;
  double amount;
  bool isCredit;

  setTransactionType(bool isCredit) {
    this.isCredit = isCredit;
  }

  setAmount(double amount) {
    this.amount = amount;
  }

  setText(String text) {
    this.text = text;
  }

  setDescription(String description) {
    this.description = description;
  }

  setDate(DateTime date) {
    this.date = date;
  }

  setSender(String sender) {
    this.sender = sender;
  }
}
