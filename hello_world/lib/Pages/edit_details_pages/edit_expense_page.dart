import 'package:flutter/material.dart';
import 'package:hello_world/screens/add_screens/resolve_expense_service.dart';
import '../../screens/add_screens/edit_expense.dart';
import '../../screens/add_screens/add_service.dart';
import 'package:hello_world/components/expense.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class EditExpensePage extends StatefulWidget {


  final Expense expense;
  EditExpensePage({Key? key, required this.expense}) : super(key: key);

  @override
  State<EditExpensePage> createState() => _EditFromObjectPageData();
}

class _EditFromObjectPageData extends State<EditExpensePage> {

  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return DefaultTabController(
      length: 3,

      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Row(
            children: <Widget>[
              Image.asset(
                '${providerCommunity.extractCommunityImagePathByName(widget.expense.communityName)}',
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(widget.expense.communityName),
            ],
          ) ,
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(90.0),
              child: Container(
                margin: EdgeInsets.only(left: 90),
                child: Column(
                    children:[
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 13.0,),
                            child: Text('↳ ',
                              style: TextStyle(
                                fontSize: 30.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0,top: 3),
                            child: Image.asset(
                              '${providerCommunity.extractObjectImagePathByName(widget.expense.objectName)}',
                              width: 40,
                              height: 40,
                            ),
                          ),

                          Text(' ${widget.expense.objectName}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                          children:[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0,top: 3, left: 75),
                              child: Icon(Icons.currency_rupee_outlined, color: Colors.white),
                            ),
                          ]
                      )
                    ]
                ),
              )
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



