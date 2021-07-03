import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class UserTransitions extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deletetx;
  UserTransitions(this.transaction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        //height: ,
        child: transaction.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'There Exist No Transaction',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: constraints.maxHeight * 0.6,
                          child: Image.asset(
                            'assets/images/waiting.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text(
                              '\$${transaction[index].amount}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        '${transaction[index].name}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMEd().format(transaction[index].date)),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? FlatButton.icon(
                              onPressed: () {
                                deletetx(transaction[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              label: Text('Delete'),
                              textColor: Colors.red,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                deletetx(transaction[index].id);
                              },
                            ),
                    ),
                    elevation: 5,
                  );
                },
                itemCount: transaction.length,
              ),
      ),
    );
  }
}
