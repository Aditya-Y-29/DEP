import 'package:flutter/material.dart';
import '../../screens/add_screens/add_expense.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

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
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return DefaultTabController(
      length: 1,
      initialIndex: widget.selectedPage,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
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
                          '${providerCommunity.extractObjectImagePathByName(widget.objectName)}',
                          width: 40,
                          height: 40,
                        ),
                      ),

                      Text(' ${widget.objectName}',
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
            ExpenseScreen(isFromCommunityPage: false, isFromObjectPage: true, communityName: widget.communityName, objectName: widget.objectName,),
          ],
        ),
      ),
    );
  }
}