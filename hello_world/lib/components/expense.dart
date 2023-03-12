import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class Expense extends StatefulWidget {
  final String creator;
  final String description;
  final int amount;
  final bool isPaid;
  final String objectName;
  const Expense({Key? key, required this.objectName, required this.creator, required this.description, required this.amount, required this.isPaid}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.isPaid ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              widget.creator,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
              Text(
              widget.description,
                style: const TextStyle(
                  fontSize: 15,
              ),
              ),
            ]
          ),
          Text(
           '₹${widget.amount}',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          if(!widget.isPaid)
            GestureDetector(
              onTap: () {
                Expense expense = Expense(
                  creator: widget.creator,
                  description: widget.description,
                  amount: widget.amount,
                  isPaid: false,
                  objectName: widget.objectName,
                );
                providerCommunity.resolveExpense(expense);
              },
              child: const Icon(Icons.check_circle_outline, color: Colors.green, size: 35,),
            )
        ],
      ),
    );
  }
}
