import 'package:flutter/material.dart';
import 'dart:math';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double spendingPercentage;
  ChartBar(this.label, this.amount, this.spendingPercentage);
  @override
  Widget build(BuildContext context) {
    return 
    LayoutBuilder(builder: (ctx,constraints){
      return  Container(
      child: Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight*0.15,
            child: FittedBox(
              child: Text("\$" + amount.toStringAsFixed(0)),
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(
            height: constraints.maxHeight*0.6,
            width: 20,
            child: Transform(
              transform: Matrix4.rotationX(pi),
              alignment: Alignment.center,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPercentage,
                    child: Container(
                      decoration: BoxDecoration(
                      
                    
                        gradient:spendingPercentage<0.4? LinearGradient(end: Alignment.bottomCenter,begin: Alignment.topCenter,colors: [Colors.cyan,Colors.indigo]):
                         spendingPercentage < 0.7? LinearGradient(end: Alignment.bottomCenter,begin: Alignment.topCenter,colors: [Colors.cyan,Colors.amber]) :
                         LinearGradient(end: Alignment.bottomCenter,begin: Alignment.topCenter,colors: [Colors.indigo,Colors.purple,Colors.redAccent]),
                        //color: spendingPercentage<0.3?Colors.green:spendingPercentage<0.7? Colors.amber:Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: constraints.maxHeight*0.05),
          Container(child: FittedBox(child: Text(label)),height: constraints.maxHeight*0.15),
        ],
      ),
    );
   
    });
   
  }
}
