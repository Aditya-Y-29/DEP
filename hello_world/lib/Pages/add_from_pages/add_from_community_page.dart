import 'package:flutter/material.dart';
import '../../screens/add_screens/add_expense.dart';
import '../../screens/add_screens/add_object.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class AddFromCommunityPage extends StatefulWidget {
  int selectedPage = 0;
  final String creatorTuple;
  AddFromCommunityPage({Key? key, required this.selectedPage, required this.creatorTuple}) : super(key: key);

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
                '${providerCommunity.extractCommunityImagePathByName(widget.creatorTuple)}',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Flexible(child: Text((widget.creatorTuple).split(":")[0], overflow: TextOverflow.ellipsis,)),
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
            ObjectScreen(isFromCommunityPage: true, creatorTuple: widget.creatorTuple),
            ExpenseScreen(isFromCommunityPage: true, isFromObjectPage: false, creatorTuple: widget.creatorTuple, objectName: "",),
          ],
        ),
      ),
    );
  }
}

