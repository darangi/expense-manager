import 'package:expense_manager/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'smsData.dart';

class ContactsState extends State<Contacts> {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final smsData = new SmsData();
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
            value: Provider.of<Model>(context).contacts.contains(contact),
            onChanged: (bool value) {
              setState(() {
                value
                    ? Provider.of<Model>(context).addContact(contact)
                    : Provider.of<Model>(context).removeContact(contact);
              });
            }));
  }
}

class Contacts extends StatefulWidget {
  @override
  ContactsState createState() => ContactsState();
}
