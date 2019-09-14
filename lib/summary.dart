import 'package:expense_manager/smsData.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class Summary extends StatefulWidget {
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // new SmsData()
    //     .sms(Provider.of<Model>(context).contacts)
    //     .then((filteredSms) => {new Model().addSms(filteredSms)});
    return MaterialApp(
        home: Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              topBar(context),
              amountSummary(context),
              dateFilter(),
              transactions(),
            ],
          ),
        ),
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
    });
  }

  Widget transactions() {
    return Flexible(
        child: Column(children: <Widget>[
      Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: 30,
            itemBuilder: /*1*/ (context, i) {
              return _buildRow("Stanbic");
            }),
      )
    ]));
  }

  Widget _buildRow(String contact) {
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
                          Text("Stanbic",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          Text("Ozone cinemas cinemas sdsd sjdghskdjhgsk",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Text(
                            "21/02/22",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text("₦5000",
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
        Icon(Icons.settings, color: Colors.lightBlueAccent)
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
            Icon(Icons.date_range, color: Colors.grey),
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

  Widget amountSummary(BuildContext context) {
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
              "₦320,000,000.00",
              style: TextStyle(color: Colors.black, fontSize: 25),
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    );
  }
}
