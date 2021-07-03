import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/newtransactions.dart';
import './widgets/usertransitions.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Paisa',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.indigoAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              button: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,

                // color: Colors.white,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 20,
                      color: Colors.white)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transaction = [
    Transaction(id: 't1', name: 'Shoes', amount: 44.9, date: DateTime.now()),
    Transaction(id: 't2', name: 'Groceries', amount: 14.5, date: DateTime.now())
  ];

  List<Transaction> get _recenttransaction {
    return transaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addtransaction(String txtitle, double amount, DateTime selectdate) {
    final addtx = Transaction(
        id: DateTime.now().toString(),
        name: txtitle,
        amount: amount,
        date: selectdate);

    setState(() {
      transaction.add(addtx);
    });
  }

  void addnewtransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bcntx) {
          return NewTransactions(_addtransaction);
        });
  }

  void _deletetransaction(String id) {
    setState(() {
      return transaction.removeWhere((element) => element.id == id);
    });
  }

  bool _chartshower = false;

  @override
  Widget build(BuildContext context) {
    final mediaq = MediaQuery.of(context);
    final devicestateland = mediaq.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Paisa"),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => addnewtransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (devicestateland)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Chart Bar'),
                  Switch(
                    value: _chartshower,
                    onChanged: (value) {
                      setState(() {
                        _chartshower = value;
                      });
                    },
                  ),
                ],
              ),
            if (!devicestateland)
              Container(
                  height: (mediaq.size.height -
                          appBar.preferredSize.height -
                          mediaq.padding.top) *
                      0.3,
                  child: Chart(_recenttransaction)),
            if (!devicestateland)
              Container(
                  height: (mediaq.size.height -
                          appBar.preferredSize.height -
                          mediaq.padding.top) *
                      0.7,
                  child: UserTransitions(transaction, _deletetransaction)),
            if (devicestateland)
              _chartshower
                  ? Container(
                      height: (mediaq.size.height -
                              appBar.preferredSize.height -
                              mediaq.padding.top) *
                          0.6,
                      child: Chart(_recenttransaction))
                  : Container(
                      height: (mediaq.size.height -
                              appBar.preferredSize.height -
                              mediaq.padding.top) *
                          0.7,
                      child: UserTransitions(transaction, _deletetransaction)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => addnewtransaction(context),
      ),
    );
  }
}
