import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, dynamic>> get groupedTransactionValues {
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
        'day': DateFormat.E().format(weekDay), // return Wed,Thurs... (If want to 1 charactor, try .substring(0,1))
        'amount': totalSum.toInt(), // return amount
      };
    }).reversed.toList();
  }

  int get totalSpending{
    return groupedTransactionValues.fold(0,(sum, item){
      return sum + item['amount'] as int;
    });
 }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: groupedTransactionValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['day'] as String,
                    data['amount'].toDouble(),
                    totalSpending == 0 ? 0 : (data['amount']/totalSpending) as double,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
