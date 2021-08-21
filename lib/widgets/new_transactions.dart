import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = int.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop(); //close automatically
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              style: Theme.of(context).textTheme.bodyText1,
              controller: titleController,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              style: Theme.of(context).textTheme.bodyText1,
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),

            Container(
              margin:EdgeInsets.all(20),
              child: OutlinedButton(
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.pressed)
                            ?  Theme.of(context).primaryColorDark
                            :  Theme.of(context).primaryColor;
                        return BorderSide(color: color, width: 1);
                      }
                  ),
                ),
                onPressed: submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
