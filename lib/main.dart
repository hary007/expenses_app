import 'package:flutter/material.dart';

import './widgets/new_transactions.dart';
import './widgets/chart.dart';
import './widgets/transactions_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal expenses",
      home: MyHomePage(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          primarySwatch: Colors.grey,
          primaryColor: Colors.grey,
          fontFamily: 'Abel',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: "Abel",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: "OtomanopeeOne",
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: "t1",
    //   amount: 49.99,
    //   title: "Something new",
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: "t2",
    //   amount: 99.99,
    //   title: "Another Something new",
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(
      String txTitle, String txAmount, DateTime chosenDate) {
    final txNew = Transaction(
      amount: double.parse(txAmount),
      title: txTitle,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(txNew);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        backgroundColor: Colors.grey[850],
        builder: (bCtx) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        }); //builder is a function that should return the widget which is inside the modal bottom sheet.
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text(
          "Expenses App",
          style: TextStyle(color: Colors.white70),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(
              Icons.add,
            ),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chart(_recentTransactions),
            SizedBox(
              height: 10,
            ),
            TransactionList(_userTransactions, deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey[600],
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    ));
  }
}
