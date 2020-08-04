import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transaction;
  final Function deleteTransaction;
  TransactionList(this._transaction, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: _transaction.isEmpty
          ? LayoutBuilder(builder: (ctx,constraints){
            return Column(
              children: <Widget>[
                Text(
                  "There is no transactions yet !",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight*0.6,
                    child: Image.asset(
                      "assets/images/waiting.png",
                      fit: BoxFit.cover,
                    ))
              ],
            ); 
          }) 
          : ListView.builder(
              itemCount: _transaction.length,
              itemBuilder: (context, index) {
                return Card(
                    margin: EdgeInsets.symmetric(vertical: 7, horizontal: 3),
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                              child: Text(
                            "\$${_transaction[index].amount}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                      title: Text(
                        _transaction[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                          DateFormat.yMMMd().format(_transaction[index].date)),
                      trailing: 
                      MediaQuery.of(context).size.width > 450 ?
                      FlatButton.icon( 
                        icon: Icon(Icons.delete),
                        label: Text('Delete'),
                        textColor: Theme.of(context).errorColor,
                        onPressed: () =>
                            deleteTransaction(_transaction[index].id),)
                      :
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () =>
                            deleteTransaction(_transaction[index].id),
                        color: Theme.of(context).errorColor,
                      ),
                    ));
              },
            ),
    );
  }
}
