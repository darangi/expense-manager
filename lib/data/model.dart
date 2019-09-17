import 'package:expense_manager/data/sms.dart';

class Model {
  List<String> _contacts = [];
  List<Sms> _sms = [];
  List<Sms> _allSms = [];
  double _sum = 0;
  double _balance = 0;

  List<String> get contacts => _contacts;

  List<Sms> get sms => _sms;

  double get sum => _sum;

  double get balance => _balance;

  addContact(String contact) {
    _contacts.add(contact);
  }

  removeContact(String contact) {
    _contacts.remove(contact);
  }

  filter({DateTime from, DateTime to, bool isCredit = false}) {
    _sms = _allSms
        .where((sms) =>
            sms.isCredit == isCredit &&
            sms.date.isAfter(from) &&
            sms.date.isBefore(to.add(new Duration(days: 1))))
        .toList();
    calculateSum();
    calculateBalance();
  }

  set sms(List<Sms> sms) {
    _allSms = sms;

    filter(
        to: new DateTime.now(),
        from: new DateTime.now().subtract(new Duration(days: 30)));
  }

  void calculateBalance() {
    final credit = _allSms
        .where((sms) => sms.isCredit)
        .map((sms) => sms.amount)
        .reduce((a, b) => a + b);
    final debit = _allSms
        .where((sms) => !sms.isCredit)
        .map((sms) => sms.amount)
        .reduce((a, b) => a + b);
    _balance = credit - debit;
  }

  void calculateSum() {
    _sum = _sms != null && _sms.length > 0
        ? _sms.map((s) => s.amount).reduce((a, b) => a + b)
        : 0;
  }
}
