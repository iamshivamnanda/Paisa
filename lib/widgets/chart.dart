import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recenttransaction;
  Chart(this.recenttransaction);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map<String, Object>> get recenttransactionviewer {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalsum = 0.0;
      double totalsumoftotal = 0.0;
      for (var i = 0; i < widget.recenttransaction.length; i++) {
        if (widget.recenttransaction[i].date.day == weekday.day &&
            widget.recenttransaction[i].date.month == weekday.month &&
            widget.recenttransaction[i].date.year == weekday.year) {
          totalsum += widget.recenttransaction[i].amount;
        }
        if (widget.recenttransaction[i].date.month == weekday.month &&
            widget.recenttransaction[i].date.year == weekday.year) {
          totalsumoftotal += widget.recenttransaction[i].amount;
        }
      }
      double prcnt = totalsumoftotal == 0.0 ? 0.0 : totalsum / totalsumoftotal;
      return {
        'day': DateFormat.E().format(weekday).substring(0, 2),
        'amount': totalsum,
        'prsnt': prcnt
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      //height: 170,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: recenttransactionviewer.map((mx) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(mx['day'], mx['amount'], mx['prsnt']));
            }).toList(),
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
