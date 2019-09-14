import 'package:expense_manager/sms.dart';
import 'package:flutter/foundation.dart';

class Model extends ChangeNotifier {
  List<String> _contacts = [];
  List<Sms> _sms = [];
  List<Sms> _allSms = [];
  double _sum = 0;

  List<String> get contacts => _contacts;

  List<Sms> get sms => _sms;

  double get sum => _sum;

  addContact(String contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  removeContact(String contact) {
    _contacts.remove(contact);
    notifyListeners();
  }

  filter({DateTime from, DateTime to, String sender, bool isCredit = false}) {
    _sms = _allSms.where((sms) => sms.isCredit == isCredit).toList();
    calculateSum();
  }

  set sms(List<Sms> sms) {
    _allSms = sms;
    notifyListeners();
  }

  void calculateSum() {
    _sum = _sms.map((s) => s.amount).reduce((a, b) => a + b);
    notifyListeners();
  }
}
