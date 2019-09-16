import 'package:expense_manager/data/filter.dart';
import 'package:expense_manager/helpers/smsData.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../helpers/formatter.dart';
import '../data/model.dart';
import '../data/sms.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  SmsData data = new SmsData();
  Model model = new Model();
  Filter filter = new Filter();
  int selectedIndex = 0;
  List<String> contacts = [];
  bool isLoading = true;
  @override
  void initState() {
    SharedPreferences.getInstance().then((instance) {
      contacts = instance.getStringList("contacts");
      if (contacts == null || contacts.length == 0) {
        //take to the settings page
        Navigator.of(context).pushNamedAndRemoveUntil(
            "/contacts", (Route<dynamic> route) => false);
        return;
      }
      contacts.forEach((contact) => model.addContact(contact));

      data.sms(contacts).then((sms) => {
            setState(() {
              isLoading = false;
              model.sms = sms;
            })
          });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: isLoading
                ? Center(
                    child: Text("Welcome human..."),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      topBar(),
                      amountSummary(model.sum),
                      dateFilter(),
                      transactions(model.sms),
                    ],
                  )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_drop_up,
                color: Colors.redAccent,
              ),
              title: Text(
                "Debit",
                style: TextStyle(
                    fontSize: 12,
                    color: selectedIndex == 0 ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold),
              )),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.lightGreen,
              ),
              title: Text(
                "Credit",
                style: TextStyle(
                    fontSize: 12,
                    color: selectedIndex == 1 ? Colors.black : Colors.grey,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
    ));
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      model.filter(isCredit: index == 1, from: filter.from, to: filter.to);
    });
  }

  Widget transactions(List<Sms> sms) {
    return Flexible(
        child: Column(children: <Widget>[
      sms.length > 0
          ? Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: sms.length,
                  itemBuilder: /*1*/ (context, i) {
                    return _buildRow(sms.elementAt(i));
                  }),
            )
          : Expanded(
              child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Text(
                "No" +
                    (selectedIndex == 1 ? " credit " : " debit ") +
                    "transaction found within this period",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ))
    ]));
  }

  Widget description(Sms sms) {
    return AlertDialog(
      content: Container(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(sms.sender,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                Text(
                  Formatter.toHumanReadableDate(sms.date),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            Divider(),
            Text(
              sms.description != null ? sms.description : "No description",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(Formatter.toNaira(sms.amount),
                    style: TextStyle(
                        fontSize: 12,
                        color: selectedIndex == 0 ? Colors.red : Colors.green))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Sms sms) {
    return new GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return description(sms);
              });
        },
        child: Card(
            child: new Container(
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(sms.sender,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                width: (50 / 100) *
                                    MediaQuery.of(context).size.width,
                                child: Text(
                                  sms.description != null
                                      ? sms.description
                                      : "",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  softWrap: false,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                Formatter.toHumanReadableDate(sms.date),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(Formatter.toNaira(sms.amount),
                            style: TextStyle(
                                fontSize: 12,
                                color: selectedIndex == 0
                                    ? Colors.red
                                    : Colors.green))
                      ],
                    )
                  ],
                ))));
  }

  Widget topBar() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Row(
          children: <Widget>[
            Text("Balance: ",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            Text(Formatter.toNaira(model.balance),
                style: TextStyle(color: Colors.green, fontSize: 15))
          ],
        )),
        IconButton(
          icon: Icon(Icons.settings),
          color: Colors.lightBlueAccent,
          onPressed: () {
            Navigator.pushNamed(context, "/contacts");
          },
        )
      ],
    );
  }

  Widget dateFilter() {
    return GestureDetector(
        onTap: () async {
          final List<DateTime> picked = await DateRagePicker.showDatePicker(
            context: context,
            initialFirstDate: filter.from,
            initialLastDate: filter.to,
            firstDate: new DateTime(2000),
            lastDate: new DateTime(new DateTime.now().year + 1),
          );
          if (picked != null && picked.length > 0) {
            setState(() {
              filter
                ..setFrom(picked.elementAt(0))
                ..setTo(picked.elementAt(1));
            });
            //filter transaction by date
            model.filter(
                from: filter.from, to: filter.to, isCredit: selectedIndex == 1);
          }
        },
        child: Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.date_range,
                  color: Colors.grey,
                ),
                Text(
                  (filter.from != null && filter.to != null)
                      ? Formatter.toFilterWidgetDate(filter.from) +
                          "-" +
                          Formatter.toFilterWidgetDate(filter.to)
                      : "Last 30 days",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )));
  }

  Widget amountSummary(double sum) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            selectedIndex == 0 ? "Spent this period" : "Received this period",
            style: TextStyle(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: <Widget>[
            Text(
              Formatter.toNaira(sum),
              style: TextStyle(color: Colors.black, fontSize: 25),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}
