import 'package:flutter/material.dart';
import 'package:hello_world/screens/add_screens/resolve_expense_service.dart';
import '../../screens/add_screens/add_expense.dart';
import '../../screens/add_screens/add_service.dart';

class AddFromObjectPage extends StatefulWidget {
  int selectedPage = 0;
  final String communityName;
  final String objectName;
  AddFromObjectPage({Key? key, required this.selectedPage, required this.communityName, required this.objectName}) : super(key: key);

  @override
  State<AddFromObjectPage> createState() => _AddFromObjectPageData();
}

class _AddFromObjectPageData extends State<AddFromObjectPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.objectName} (${widget.communityName})'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.check_circle_outline),),
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              // Tab(icon: Icon(Icons.home_repair_service),),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            ResolveScreen(isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
            ExpenseScreen(isFromCommunityPage: false, isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
            // ServiceScreen(isFromCommunityPage: false, isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
          ],
        ),
      ),
    );
  }
}