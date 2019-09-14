// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:expense_manager/model.dart';
import 'package:expense_manager/selectContacts.dart';
import 'package:expense_manager/summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
           appBar: AppBar(
              title: Text('Expense Manager'),
              backgroundColor: Colors.lightBlue,
            ),
            body: ChangeNotifierProvider(
                builder: (context) => Model(),
                child: MaterialApp(
                  initialRoute: '/',
                  routes: {
                    "/": (context) => SelectContacts(),
                    "/summary": (context) => Summary()
                  },
                ))));
  }
}
