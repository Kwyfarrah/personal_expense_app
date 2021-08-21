import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    // return:[{day: Sat, amount: 2000}, {day: Fri, amount: 0}, {day: Thu, amount: 0}, {day: Wed, amount: 0}, {day: Tue, amount: 0}, {day: Mon, amount: 0}, {day: Sun, amount: 0}]
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );  //index will from 0 ~ 6 , so days:0 (today), days: 1 (tomorrow)...
      int totalSum = 0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date!.day == weekDay.day &&
            recentTransactions[i].date!.month == weekDay.month &&
            recentTransactions[i].date!.year == weekDay.year) {
          totalSum += recentTransactions[i].amount!.toInt();
        }
      }
      print(DateFormat.E().format(weekDay)); //ABBR_WEEKDAY = .E() = Today's weekday
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay), // return Wed,Thurs...
        'amount': totalSum.toString(), // return amount
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: <Widget>[],
      ),
    );
  }
}
