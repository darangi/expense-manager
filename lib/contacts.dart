import 'package:flutter/material.dart';
import 'smsData.dart';

class ContactsState extends State<Contacts> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final smsData = new SmsData();
  List<String> selectedContacts = new List<String>();
  List<String> contacts = new List<String>();
  @override
  void initState() {
    super.initState();
    smsData.contacts().then((data) {
      setState(() {
        contacts = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: contacts.length,
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/
          return _buildRow(contacts.elementAt(i));
        });
  }

  Widget _buildRow(String contact) {
    return ListTile(
        title: Text(
          contact,
          style: _biggerFont,
        ),
        trailing: Checkbox(
            value: selectedContacts.contains(contact),
            onChanged: (bool value) {
              setState(() {
                value
                    ? selectedContacts.add(contact)
                    : selectedContacts.remove(contact);
              });
            }));
  }
}

class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => ContactsState();
}
