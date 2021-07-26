import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  late final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>>
      get groupedTransactionValues //returns transaction values grouped by weekday
  {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(
        Duration(
          days: index,
        ),
      );

      var totalSum = 0.0;

      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == date.day &&
            recentTransactions[i].date.month == date.month &&
            recentTransactions[i].date.year == date.year)
          totalSum += recentTransactions[i].amount;
      }

      // print(DateFormat.E().format(date));
      // print(totalSum);

      return {'day': DateFormat.E().format(date), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return ((item['amount'] as double) + sum);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  (data['day'] as String),
                  (data['amount'] as double),
                  totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
