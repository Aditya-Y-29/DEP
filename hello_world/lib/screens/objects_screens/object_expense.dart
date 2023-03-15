import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider.dart';


class ObjectExpenseScreen extends StatefulWidget {
  const ObjectExpenseScreen({Key? key, required this.objectName}) : super(key: key);
  final String objectName;

  @override
  State<ObjectExpenseScreen> createState() => _ObjectExpenseScreenState();
}

class _ObjectExpenseScreenState extends State<ObjectExpenseScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, objectDataProvider, child) {

        return Column(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.of(objectDataProvider.objectUnresolvedExpenseMap[widget.objectName] as Iterable<Widget>)
              ),
              Container (
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Resolved Expenses",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.of(objectDataProvider.objectResolvedExpenseMap[widget.objectName] as Iterable<Widget>)
              ),
            ]
        );
      },
    );
  }
}
