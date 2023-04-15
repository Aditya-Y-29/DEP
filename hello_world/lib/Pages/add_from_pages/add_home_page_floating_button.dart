import 'package:flutter/material.dart';
import '../../screens/add_screens/add_community.dart';
import '../../screens/add_screens/add_expense.dart';
import '../../screens/add_screens/add_object.dart';


class AddFromHomePage extends StatefulWidget {
  int selectedPage = 0;
  AddFromHomePage({Key? key, required this.selectedPage}) : super(key: key);

  @override
  State<AddFromHomePage> createState() => _AddExpenseServiceCommunityData();
}

class _AddExpenseServiceCommunityData extends State<AddFromHomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_work),),
              Tab(icon: Icon(Icons.grid_view),),
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              // Tab(icon: Icon(Icons.home_repair_service),),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            CommunityScreen(),
            ObjectScreen(isFromCommunityPage: false, communityName: ""),
            ExpenseScreen(isFromCommunityPage: false, isFromObjectPage: false, communityName: "", objectName: "",),
            // ServiceScreen(isFromCommunityPage: false, isFromObjectPage: false, communityName: "", objectName: "",),
          ],
        ),
      ),
    );
  }
}

