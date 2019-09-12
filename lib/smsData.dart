import 'package:sms/sms.dart';
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
      filteredMessages.add(
          new Sms().setSender(msg.sender).setText(msg.body).setDate(msg.date));
    }

    return filteredMessages;
  }

  Future<List<String>> contacts() async {
    var messages = await query.querySms(kinds: [SmsQueryKind.Inbox]);
    //use a set so unique sender addresses can be returned;
    final contacts = (new Set.from(messages.map((e) => e.sender))).toList().cast<String>();

    return contacts;
  }
}
