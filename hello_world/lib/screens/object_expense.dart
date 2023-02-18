import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';


class ObjectExpenseScreen extends StatefulWidget {
  const ObjectExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ObjectExpenseScreen> createState() => _ObjectExpenseScreenState();
}

class _ObjectExpenseScreenState extends State<ObjectExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expense(creator: "Pranav", description: "Service", amount: 500, isPaid: false),
        Expense(creator: "Akshat", description: "Repair", amount: 1000, isPaid: false),
        Expense(creator: "Deepika", description: "Speaker", amount: 750, isPaid: false),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
              "Resolved Payments",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
          ),
        ),
        Expense(creator: "Aditya", description: "Display", amount: 900, isPaid: true),
      ],
    );
  }
}
