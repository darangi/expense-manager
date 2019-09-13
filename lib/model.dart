import 'package:expense_manager/sms.dart';
import 'package:flutter/foundation.dart';

class Model extends ChangeNotifier {
  List<String> _contacts = [];
  List<Sms> _sms;

  List<String> get contacts => _contacts;

  List<Sms> get sms => _sms;

  addContact(String contact) {
    _contacts.add(contact);
    notifyListeners();
  }
  
  removeContact(String contact) {
    _contacts.remove(contact);
  }

  addSms(Sms sms) {
    _sms.add(sms);
    notifyListeners();
  }
}
