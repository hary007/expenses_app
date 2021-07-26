import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  late final Function helper;

  NewTransaction(this.helper);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  late DateTime selectedDate = DateTime(2018);

  void submit() {
    final txTitle = titleController.text;
    final txAmount = amountController.text;

    if (txTitle.isEmpty ||
        double.parse(txAmount) <= 0 ||
        selectedDate == DateTime(2018)) return;

    print(titleController.text);
    print(amountController.text);
    widget.helper(txTitle, txAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void saveSelectedDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null)
        return;
      else
        setState(() {
          selectedDate = pickedDate;
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 20,
          ),
          Card(
            child: TextField(
              // textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: "Title",
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              ),
              controller: titleController,
              onSubmitted: (_) => submit(),
              // onChanged: (val) => titleInput = val,
            ),
          ),
          Card(
            child: TextField(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                hintText: "Amount",
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
              // onChanged: (am) => amountInput = am,
            ),
          ),
          Container(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: saveSelectedDate,
                      child: Text(
                        "Choose a date",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "OtomanopeeOne",
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      )),
                  Text(
                    selectedDate == DateTime(2018)
                        ? "No date chosen!"
                        : DateFormat.yMd().format(selectedDate),
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Abel", fontSize: 18),
                  ),
                ],
              )),
          ElevatedButton(
            onPressed: submit,
            child: Text("Add Transaction",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ],
      ),
    );
  }
}
