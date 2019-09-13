import 'package:expense_manager/smsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class Summary extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    new SmsData().sms(Provider.of<Model>(context).contacts);
    return new Container(
      child: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
