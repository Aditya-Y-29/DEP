import 'package:flutter/material.dart';
import 'package:hello_world/screens/add_screens/resolve_expense_service.dart';
import '../../screens/add_screens/edit_expense.dart';
import '../../screens/add_screens/add_service.dart';
import 'package:hello_world/components/expense.dart';

class EditExpensePage extends StatefulWidget {


  final Expense expense;
  EditExpensePage({Key? key, required this.expense}) : super(key: key);

  @override
  State<EditExpensePage> createState() => _EditFromObjectPageData();
}

class _EditFromObjectPageData extends State<EditExpensePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.expense.communityName}'),
          bottom: const TabBar(
            tabs: [
              //Tab(icon: Icon(Icons.check_circle_outline),),
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              // Tab(icon: Icon(Icons.home_repair_service),),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
           // ResolveScreen(isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
            EditExpenseScreen(isFromCommunityPage: false, isFromObjectPage: true,expense:widget.expense),
            // ServiceScreen(isFromCommunityPage: false, isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
          ],
        ),
      ),
    );
  }
}



