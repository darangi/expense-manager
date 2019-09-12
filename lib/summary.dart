import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Expense Manager'),
              backgroundColor: Colors.lightBlue,
            ),
            body: new Container(height: double.infinity, child: Summary())));
  }
}
