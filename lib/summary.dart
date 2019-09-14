import 'package:expense_manager/smsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';
import 'sms.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  SmsData data = new SmsData();
  Model model = new Model();
  int selectedIndex = 0;
  List<String> contacts = [];
  bool isLoading = true;
  @override
  void initState() {
    SharedPreferences.getInstance().then((instance) {
      contacts = instance.getStringList("contacts");
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
                      topBar(context),
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
      model.filter(isCredit: index == 1);
    });
  }

  Widget transactions(List<Sms> sms) {
    return Flexible(
        child: Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: sms.length,
            itemBuilder: /*1*/ (context, i) {
              return _buildRow(sms.elementAt(i));
            }),
      )
    ]));
  }

  Widget _buildRow(Sms sms) {
    return Card(
        child: new Container(
            width: MediaQuery.of(context).size.width,
            padding:
                new EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
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
                            width:
                                (50 / 100) * MediaQuery.of(context).size.width,
                            child: Text(
                              sms.description != null ? sms.description : "",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            sms.date.toLocal().toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text("₦" + sms.amount.toString(),
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                selectedIndex == 0 ? Colors.red : Colors.green))
                  ],
                )
              ],
            )));
  }

  Widget topBar(context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text("Summary",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))),
        IconButton(
          icon: Icon(Icons.settings),
          color: Colors.lightBlueAccent,
          onPressed: () {
            Navigator.pushNamed(context, "/");
          },
        )
      ],
    );
  }

  Widget dateFilter() {
    return Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.filter_list, color: Colors.grey),
            Text(
              "21/02/22 - 21/02/22",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ));
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
              "₦" + sum.toString(),
              style: TextStyle(color: Colors.black, fontSize: 25),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}
