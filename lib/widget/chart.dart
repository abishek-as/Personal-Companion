import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../model/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  double _totalSpending = 0.0;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    final today = DateTime.now();
    List<double> weekSums = List<double>.filled(7, 0);

    for (Transaction txn in _recentTransactions) {
      weekSums[txn.txnDateTime!.weekday - 1] += txn.txnAmount!;
      _totalSpending += txn.txnAmount!;
    }

    return List.generate(7, (index) {
      final dayOfPastWeek = today.subtract(
        Duration(days: index),
      );

      return {
        'day': DateFormat('E').format(dayOfPastWeek)[0],
        'amount': weekSums[dayOfPastWeek.weekday - 1],
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((value) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                value['day'] as String?,
                value['amount'] as double?,
                _totalSpending == 0.0
                    ? 0.0
                    : (value['amount'] as double) / _totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
