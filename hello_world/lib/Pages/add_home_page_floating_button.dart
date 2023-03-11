import 'package:flutter/material.dart';
import '../screens/add_community.dart';
import '../screens/add_expense.dart';
import '../screens/add_service.dart';
import '../screens/add_object.dart';


class AddExpenseServiceCommunity extends StatefulWidget {
  int selectedPage = 0;
  AddExpenseServiceCommunity({Key? key, required this.selectedPage}) : super(key: key);

  @override
  State<AddExpenseServiceCommunity> createState() => _AddExpenseServiceCommunityData();
}

class _AddExpenseServiceCommunityData extends State<AddExpenseServiceCommunity> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              Tab(icon: Icon(Icons.home_repair_service),),
              Tab(icon: Icon(Icons.home_work),),
              Tab(icon: Icon(Icons.data_object),)
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            ExpenseScreen(),
            ServiceScreen(),
            CommunityScreen(),
            ObjectScreen(),
          ],
        ),
      ),
    );
  }
}

