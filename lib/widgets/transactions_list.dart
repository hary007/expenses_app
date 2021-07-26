import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  late final List<Transaction> transactions;
  late final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
        ),
      ),
      height: 400,
      width: double.infinity,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "No transactions added yet",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "DancingScript",
                    fontSize: 30,
                  ),
                ),
                Container(
                    child: Image.asset("images/waiting.png"), height: 320),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  color: Colors.grey[200],
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[700],
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text(
                                "\$${transactions[index].amount.toStringAsFixed(0)}")),
                      ),
                    ),
                    title: Text("${transactions[index].title}",
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                      "${DateFormat.yMMMEd().format(transactions[index].date)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        deleteTx(transactions[index].id);
                      },
                      color: Colors.deepOrange,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}




/*
//as much as i can get and i know no limits is a bad combination.
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 5,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          child: Text(
                            "\$${transactions[index].amount.toStringAsFixed(2)}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.purple,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(transactions[index].title,
                                style: Theme.of(context).textTheme.headline6),
                            Text(
                              DateFormat.yMMMEd()
                                  .format(transactions[index].date),
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
              },
              itemCount: transactions.length,
            ),
*/