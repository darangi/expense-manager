import 'package:expense_manager/summary.dart';
import 'package:flutter/material.dart';
import 'contacts.dart';

class SelectContacts extends StatefulWidget {
  @override
  SelectContactsState createState() => SelectContactsState();
}

class SelectContactsState extends State<SelectContacts> {
  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Flexible(fit: FlexFit.tight, child: Contacts()),
        new Container(
          width: double.maxFinite,
          height: 48,
          margin: EdgeInsets.all(8),
          child: new FlatButton(
            color: Colors.lightBlue,
            child: new Text(
              "Continue",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              //dispatch an action to the store
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Summary()));
            },
          ),
        ),
      ],
    );
  }
}
