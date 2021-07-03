import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addControler;
  NewTransactions(this.addControler);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final textcontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime _selecteddate;

  void submitdata() {
    if (textcontroller.text.isEmpty ||
        double.parse(amountcontroller.text) <= 0) {
      return;
    }
    if (_selecteddate == null) {
      _selecteddate = DateTime.now();
    }
    widget.addControler(textcontroller.text,
        double.parse(amountcontroller.text), _selecteddate);
    textcontroller.clear();
    amountcontroller.clear();
    Navigator.of(context).pop();
  }

  void _datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selecteddate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
            padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: textcontroller,
                      onSubmitted: (value) => submitdata(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountcontroller,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      // onSubmitted: (value) => submitdata(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(_selecteddate == null
                              ? 'No date Chosen'
                              : 'Picked Date ${DateFormat.yMEd().format(_selecteddate)}'),
                        ),
                        FlatButton(
                          child: Text(
                            'Choose Date',
                            style: Theme.of(context).textTheme.button,
                          ),
                          onPressed: _datepicker,
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).primaryColor, width: 3),
                      ),
                      child: FlatButton(
                        child: Text(
                          "Transaction",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: submitdata,
                      ),
                    )
                  ],
                );
              },
            )),
      ),
    );
  }
}
