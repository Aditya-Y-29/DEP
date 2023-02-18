import 'package:flutter/material.dart';
import '../screens/add_community.dart';
import '../screens/add_expense.dart';
import '../screens/add_service.dart';


class AddExpenseServiceCommunity extends StatefulWidget {
  const AddExpenseServiceCommunity({Key? key}) : super(key: key);

  @override
  State<AddExpenseServiceCommunity> createState() => _AddExpenseServiceCommunityData();
}

class _AddExpenseServiceCommunityData extends State<AddExpenseServiceCommunity> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Expense'),
              Tab(text: 'Service',),
              Tab(text: 'Community',),
            ],
            indicatorColor: Colors.white,
          ),
          backgroundColor: const Color.fromARGB(255, 225, 135, 18),
        ),
        body: const TabBarView(
          children: [
            ExpenseScreen(),
            ServiceScreen(),
            CommunityScreen(),
          ],
        ),
      ),
    );
  }
}

