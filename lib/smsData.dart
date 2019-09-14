import 'package:expense_manager/model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sms/sms.dart';
import 'filter.dart';
import 'sms.dart';

class SmsData {
  SmsQuery query = new SmsQuery();
  Model model;

  Future sms(BuildContext context) async {
    model = Provider.of<Model>(context);
    List<SmsMessage> messages = [];
    List<Sms> filteredMessages = [];
    List<String> contacts = Provider.of<Model>(context).contacts;
    for (final address in contacts) {
      messages.addAll(
          await query.querySms(kinds: [SmsQueryKind.Inbox], address: address));
    }

    double amount = 0.00;
    double sum = 0.00;
    for (final msg in messages) {
      Filter filter = new Filter(msg.body);
      amount = filter.extractAmount();
      var sms = new Sms()
          .setSender(msg.sender)
          .setText(msg.body)
          .setDate(msg.date)
          .setDescription(filter.extractDescription())
          .setAmount(amount);
          sum = sum + amount;
      filteredMessages.add(sms);
    }
    model.addSms(filteredMessages);
    model.setSum(sum);
  }

  Future<List<String>> contacts() async {
    var messages = await query.querySms(sort: true);
    //use a set so unique sender addresses can be returned;
    final contacts =
        (new Set.from(messages.map((e) => e.sender))).toList().cast<String>();

    return contacts;
  }
}
