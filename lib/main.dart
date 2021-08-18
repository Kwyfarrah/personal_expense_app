import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // String? titleInput;
  // String? amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expense'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                  child: Text('CHART'),
                  elevation: 5,
                ),
              ),
              Card(
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: titleController,
                        // onChanged: (val) {
                        //   titleInput = val;
                        // },
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        controller: amountController,
                        // onChanged: (val) {
                        //   amountInput = val;
                        // },
                      ),
                      FlatButton(
                        child: Text('Add Transaction'),
                        textColor: Colors.purple,
                        onPressed: () {
                          print(titleController.text);
                          print(amountController.text);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              TransactionList(),
            ],
          ),
        ),
      ),
    );
  }
}
