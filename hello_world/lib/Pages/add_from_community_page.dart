import 'package:flutter/material.dart';
import 'package:hello_world/screens/resolve_expense_service.dart';
import '../screens/add_community.dart';
import '../screens/add_expense.dart';
import '../screens/add_service.dart';
import '../screens/add_object.dart';


class AddFromCommunityPage extends StatefulWidget {
  int selectedPage = 0;
  final String communityName;
  AddFromCommunityPage({Key? key, required this.selectedPage, required this.communityName}) : super(key: key);

  @override
  State<AddFromCommunityPage> createState() => _AddFromCommunityPageData();
}

class _AddFromCommunityPageData extends State<AddFromCommunityPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.check_circle_outline),),
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              Tab(icon: Icon(Icons.home_repair_service),),
              Tab(icon: Icon(Icons.data_object),)
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ResolveScreen(communityName: widget.communityName),
            ExpenseScreen(),
            ServiceScreen(),
            ObjectScreen(),
          ],
        ),
      ),
    );
  }
}

