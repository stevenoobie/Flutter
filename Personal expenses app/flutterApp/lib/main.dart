import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transactionList.dart';
import './widgets/new_transaction.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Personal Expenses",
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          primaryColor: Colors.cyan,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  button: TextStyle(
                    color: Colors.white,
                  ),
                ),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [];
  void _addNewTransaction(String title, double amount, DateTime dateTime) {
    final tx = Transaction(
        title: title,
        amount: amount,
        id: DateTime.now().toString(),
        date: dateTime);

    setState(() {
      transactions.add(tx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void _openInputWindow(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get last7DaysUserTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool _showChart = false;
  @override
  Widget build(BuildContext context) {
    final appBar = GradientAppBar(
      backgroundColorStart: Colors.cyan,
      backgroundColorEnd: Colors.indigo,
      title: Text("Personal expenses"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openInputWindow(context),
        )
      ],
    );
    final mediaQuery=MediaQuery.of(context);

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.6,
      child: TransactionList(transactions, _deleteTransaction),
    );
    final bool isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if(isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Show Chart "),
              Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  }),
            ],
          ),
          if(isLandscape)
          _showChart
              ? Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.7,
                  child: Chart(last7DaysUserTransactions),
                )
              : txListWidget,
           if(!isLandscape)
               Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.4,
                  child: Chart(last7DaysUserTransactions),
                ),
            if(!isLandscape)
              txListWidget    
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openInputWindow(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
