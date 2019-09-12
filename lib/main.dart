// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'selectContacts.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Expense Manager',
        home: Scaffold(
            appBar: AppBar(
              title: Text('Expense Manager'),
              backgroundColor: Colors.lightBlue,
            ),
            body: new Container(
                height: double.infinity,child: SelectContacts())));
  }
}
