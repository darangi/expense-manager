// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:sms/sms.dart';

void main() async {
  runApp(MyApp());
  List<Sms> messages = await readSms();
  //use a set so unique sender addresses can be returned;
  Set contacts = new Set.from(messages.map((e) => e.sender));
  log(contacts.toList().toString());
}

Future<List<Sms>> readSms() async {
  SmsQuery query = new SmsQuery();
  List<SmsMessage> messages =
      await query.querySms(kinds: [SmsQueryKind.Inbox], address: "UnityBank");
  List<Sms> filteredMessages = [];

  for (final msg in messages) {
    var sms = new Sms();
    sms.sender = msg.address;
    sms.text = msg.body;
    sms.dateTime = msg.dateSent;
    filteredMessages.add(sms);
  }

  return filteredMessages;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Startup Name Generator',
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Welcome to Flutter'),
          ),
          body: const Center(
            child: const Text('Hello World'),
          ),
        ));
  }
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class Sms {
  String text;
  DateTime dateTime;
  String sender;
}
