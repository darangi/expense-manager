import 'package:expense_manager/sms.dart';
import 'package:flutter/foundation.dart';

class Model extends ChangeNotifier {
  List<String> _contacts = [];
  List<Sms> _sms = [];
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

  addSms(List<Sms> sms) {
    _sms.addAll(sms);
    notifyListeners();
  }

  setSum(double sum) {
    _sum = sum;
    notifyListeners();
  }
}
