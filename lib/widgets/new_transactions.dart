import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData(){
    if (_amountController.text.isEmpty){
    return;
   }
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop(); //close automatically
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
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
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              style: Theme.of(context).textTheme.bodyText1,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   amountInput = val;
              // },
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date:  ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Choose Date',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  onPressed: _presentDatePicker,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: OutlinedButton(
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      StadiumBorder()),
                  side: MaterialStateProperty.resolveWith<BorderSide>(
                      (Set<MaterialState> states) {
                    final Color color = states.contains(MaterialState.pressed)
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColor;
                    return BorderSide(color: color, width: 1);
                  }),
                ),
                onPressed: _submitData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
