import 'package:expense_manager/data/model.dart';
import 'package:sms/sms.dart';
import 'filter.dart';
import 'package:expense_manager/data/sms.dart';

class SmsData {
  SmsQuery query = new SmsQuery();
  Model model;

  Future sms(List<String> contacts) async {
    List<SmsMessage> messages = [];
    List<Sms> filteredMessages = [];
    for (final address in contacts) {
      messages.addAll(
          await query.querySms(kinds: [SmsQueryKind.Inbox], address: address));
    }

    for (final msg in messages) {
      Filter filter = new Filter(msg.body);
      var amount = filter.extractAmount();
      //We only need transactions with amount greater than 1 to be be displayed
      if (amount < 1) {
        continue;
      }
      var sms = new Sms()
          ..setSender(msg.sender)
          ..setText(msg.body)
          ..setDate(msg.date)
          ..setDescription(filter.extractDescription())
          ..setAmount(amount)
          ..setTransactionType(filter.isCredit());
      filteredMessages.add(sms);
    }
    return filteredMessages;
  }

  Future<List<String>> contacts() async {
    var messages = await query.querySms(sort: true);
    //use a set so unique sender addresses can be returned;
    final contacts =
        (new Set.from(messages.map((e) => e.sender))).toList().cast<String>();

    return contacts;
  }
}
