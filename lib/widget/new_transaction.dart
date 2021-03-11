import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInputController = TextEditingController();

  final _amountInputController = TextEditingController();

  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Container(
        height: 500.0,
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleInputController,
                  decoration: InputDecoration(
                    labelText: 'Titile',
                  ),
                  onSubmitted: (_) => _submitData(),
                  // onChanged: (value) {
                  //   titleInput =
                  //       value; //set the input to what the user inputs
                  // },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _amountInputController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                  ),
                  onSubmitted: (_) => _submitData(),
                  keyboardType: TextInputType.number,
                  // onChanged: (value) {
                  //   amountInput =
                  //       value; //set the input to what the user inputs
                  // },
                ),
                Container(
                  height: 70.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'No data Chosen'
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose a date',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitData();
                  },
                  child: Text(
                    'Add Transaction',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitData() {
    if (_amountInputController.text.isEmpty == null) {
      return;
    }
    final enteredTitle = _titleInputController.text;
    final eneteredAmount = double.parse(_amountInputController.text);

    if (enteredTitle.isEmpty || eneteredAmount <= 0 || _selectedDate == null) {
      // print('please input an amount');
      return;
    }
    widget.addTx(
      enteredTitle,
      eneteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((_pickedDate) {
      if (_pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = _pickedDate;
      });
    });
  }
}
