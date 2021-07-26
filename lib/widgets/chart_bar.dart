import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  late final String label;
  late final double spendingAmount;
  late final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text("\$${spendingAmount.toStringAsFixed(0)}"),
          ),
        ),
        Container(
          height: 80,
          width: 20,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black54,
                    width: 3,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.lightBlue,
                  ),
                ),
              )
            ],
          ),
        ),
        Text(label.substring(0, 2)),
      ],
    );
  }
}
