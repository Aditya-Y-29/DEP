import 'package:flutter/material.dart';
import '../../screens/add_screens/add_expense.dart';
import '../../screens/add_screens/add_object.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

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
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return DefaultTabController(
      length: 2,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Image.asset(
                '${providerCommunity.extractCommunityImagePathByName(widget.communityName)}',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(widget.communityName),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              // Tab(icon: Icon(Icons.person_add),),
              Tab(icon: Icon(Icons.grid_view),),
              Tab(icon: Icon(Icons.currency_rupee_outlined),),
              // Tab(icon: Icon(Icons.home_repair_service),),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            // ResolveScreen(isFromObjectPage: false, communityName: widget.communityName, objectName: "",),
            ObjectScreen(isFromCommunityPage: true, communityName: widget.communityName),
            ExpenseScreen(isFromCommunityPage: true, isFromObjectPage: false, communityName: widget.communityName, objectName: "",),
            // ServiceScreen(isFromCommunityPage: true, isFromObjectPage: false, communityName: widget.communityName, objectName: "",),
          ],
        ),
      ),
    );
  }
}

