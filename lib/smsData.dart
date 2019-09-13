import 'package:sms/sms.dart';
import 'filter.dart';
import 'sms.dart';

class SmsData {
  SmsQuery query = new SmsQuery();

  Future<List<Sms>> sms(List<String> contacts) async {
    List<SmsMessage> messages = [];
    List<Sms> filteredMessages = [];

    for (final address in contacts) {
      messages.addAll(
          await query.querySms(kinds: [SmsQueryKind.Inbox], address: address));
    }

    for (final msg in messages) {
      Filter filter = new Filter(msg.body);
      filter.extractDescription();
      var sms = new Sms()
          .setSender(msg.sender)
          .setText(msg.body)
          .setDate(msg.date)
          .setDescription(filter.extractDescription())
          .setAmount(filter.extractAmount())
          .setTransactionType(filter.isCredit());
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
