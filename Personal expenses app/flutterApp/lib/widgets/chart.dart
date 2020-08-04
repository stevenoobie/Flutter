import 'package:flutter/material.dart';
import 'package:flutterApp/widgets/chartBar.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _transactions;
  Chart(this._transactions);

  List<Map<String, Object>> get transactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (int i = 0; i < _transactions.length; i++) {
        if (_transactions[i].date.day == weekDay.day &&
            _transactions[i].date.month == weekDay.month &&
            _transactions[i].date.year == weekDay.year)
          totalAmount += _transactions[i].amount;
      }
      return {
        "day": DateFormat.E().format(weekDay).substring(0, 1),
        "amount": totalAmount,
      };
    }).reversed.toList();
  }

  double get spendingAmount {
    return transactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: transactionValues.map((data) {
                return Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        data['day'],
                        data['amount'],
                        spendingAmount == 0.0
                            ? 0.0
                            : (data['amount'] as double) / spendingAmount));
              }).toList()),
        ));
  }
}
