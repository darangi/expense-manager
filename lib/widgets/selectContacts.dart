import 'package:expense_manager/data/model.dart';
import 'package:expense_manager/helpers/smsData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectContacts extends StatefulWidget {
  @override
  SelectContactsState createState() => SelectContactsState();
}

class SelectContactsState extends State<SelectContacts> {
  final smsData = new SmsData();
  final model = new Model();
  SharedPreferences pref;
  List<String> contacts = new List<String>();
  @override
  void initState() {
    super.initState();
    smsData.contacts().then((data) {
      setState(() {
        contacts = data;
      });
    });

    SharedPreferences.getInstance().then((instance) {
      setState(() {
        pref = instance;
        final contacts = pref.getStringList("contacts");
        if (contacts != null && contacts.length > 0) {
          contacts.forEach((contact) {
            model.addContact(contact);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child: Container(
          padding: EdgeInsets.only(top: 50, left: 10, right: 10),
          margin: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                child: Text("Select your Bank(s)",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Flexible(fit: FlexFit.tight, child: contactList()),
              Container(
                width: double.maxFinite,
                height: 48,
                margin: EdgeInsets.all(8),
                child: new FlatButton(
                  color: Colors.lightBlue,
                  child: Text(
                    model.contacts.length > 0
                        ? "Continue"
                        : "Select contact(s)",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    //dispatch an action to the store
                    if (model.contacts.length == 0) {
                      return;
                    }
                    pref.setStringList("contacts", model.contacts);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        "/", (Route<dynamic> route) => false);
                    // dispose();
                  },
                ),
              ),
            ],
          )),
    )));
  }

  Widget contactList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: contacts.length,
        itemBuilder: /*1*/ (context, i) {
          return contactListRow(contacts.elementAt(i));
        });
  }

  Widget contactListRow(String contact) {
    return Column(children: <Widget>[
      ListTile(
          title: Text(contact),
          trailing: Checkbox(
              value: model.contacts.contains(contact),
              onChanged: (bool value) {
                setState(() {
                  value
                      ? model.addContact(contact)
                      : model.removeContact(contact);
                });
              })),
      Divider()
    ]);
  }
}
