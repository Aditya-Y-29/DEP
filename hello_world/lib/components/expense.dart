import 'package:flutter/material.dart';
import 'package:hello_world/Pages/edit_details_pages/edit_expense_page.dart';

class Expense extends StatefulWidget {
  final String creator;
  final String description;
  final int amount;
  final String date;
  final bool isPaid;
  final String objectName;
  final String communityName;
  const Expense({Key? key, required this.objectName, required this.creator, required this.description, required this.amount,required this.date, required this.isPaid, required this.communityName}) : super(key: key);

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
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
                  date:widget.date.substring(0, 10),
                  isPaid: false,
                  objectName: widget.objectName,
                  communityName: widget.communityName,
                );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditExpensePage(expense: expense),

                    ),
                  );

              },
              child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.edit, color: Colors.green, size: 25,),
                    Text(
                      widget.date.substring(0, 10),
                      style: const TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ]
              ),
              //const Icon(Icons.edit, color: Colors.green, size: 35,),
            )
        ],
      ),
    );
  }
}
