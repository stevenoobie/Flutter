import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final amountInputController = TextEditingController();
  final titleInputController = TextEditingController();
  DateTime dateTime;
  void _submitData() {
    if (titleInputController.text == null ||
        amountInputController.text == null ||
        dateTime == null) {
      return;
    }
    if (double.parse(amountInputController.text) <= 0) {
      return;
    }

    widget.addTransaction(titleInputController.text,
        double.parse(amountInputController.text), dateTime);

    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        dateTime = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: MediaQuery.of(context).viewInsets.bottom +20 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "title"),
                controller: titleInputController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountInputController,
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Text(dateTime == null
                        ? "No date Chosen !"
                        : "Picked date: ${DateFormat.yMd().format(dateTime)}"),
                    FlatButton(
                      child: Text(
                        "Choose date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      onPressed: _datePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submitData,
                child: Text("Add transaction"),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
