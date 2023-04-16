import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';
import 'package:provider/provider.dart';

import '../Pages/add_from_pages/add_from_object_page.dart';
import '../provider/data_provider.dart';
import 'community.dart';
import 'dart:math';

class Object extends StatefulWidget {
  final String name;
  final String communityName;
  const Object({Key? key, required this.name, required this.communityName})
      : super(key: key);

  @override
  State<Object> createState() => _ObjectState();
}

class _ObjectState extends State<Object> {

  Future<bool> showDeleteDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${widget.name} object?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
    return confirmDelete ?? false;
  }

  Choice selectedOption = choices[0];
  handleSelect(Choice choice) async {
    if(choice.name=="Delete Object"){
      Future<bool> returnValue= showDeleteDialog(context);
      bool alertResponse = await returnValue;
      if(alertResponse==true){
        if( await Provider.of<DataProvider>(context, listen: false).isAdmin(widget.communityName)==true){
          Provider.of<DataProvider>(context, listen: false).deleteObject(widget.communityName, widget.name);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('You are not an admin of this community'),
            ),
          );
          return;
        }
      }
      else{
        return;
      }
    }
  }
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjectPage(
                      objectName: widget.name,
                      communityName: widget.communityName,
                    )));
      },
      child: Container(
        // width: 150,
        // height: 100,
        // margin: const EdgeInsets.all(5.0),
        // padding: const EdgeInsets.only(left: 20.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(35.0),
        //   color: Colors.white,
        //   boxShadow: const [
        //     BoxShadow(
        //       color: Colors.grey,
        //       blurRadius: 15.0, // soften the shadow
        //       spreadRadius: 1.0, //extend the shadow
        //       offset: Offset(
        //         1.0, // Move to right 5  horizontally
        //         1.0, // Move to bottom 5 Vertically
        //       ),
        //     )
        //   ],
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.only(right: 12.0),
                      child: Image.asset(
                        '${providerCommunity.extractObjectImagePathByName(widget.name)}',
                        width: 60,
                        height: 60,
                      ),
                  )),
                  Flexible(
                      child: Container(
                        child: Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                  PopupMenuButton<Choice>(
                    itemBuilder: (BuildContext context) {
                      return choices.skip(0).map((Choice choice) {
                        return PopupMenuItem<Choice>(
                          value: choice,
                          child: Text(choice.name),
                        );
                      }).toList();
                    },
                    onSelected: handleSelect,
                  ),
                ]),
            Row(
              children: [
                Icon(Icons.person),
                Text(" = "),
                Text(
                  "₹ ${providerCommunity.myExpenseInObject(widget.communityName, widget.name)}",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.group),
                Text(" = "),
                Text(
                    "₹ ${providerCommunity.objectTotalExpense(widget.communityName, widget.name)}",
                    style: TextStyle(color: Colors.blue)),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.only(bottom: 5.0, right: 5.0),
                height: 30.0,
                width: 30.0,
                child: new FloatingActionButton(
                  heroTag: "${random.nextInt(1000000)}",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddFromObjectPage(
                              selectedPage: 0,
                              communityName: widget.communityName,
                              objectName: widget.name)),
                    );
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(Icons.add),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

const List<Choice> choices = <Choice>[Choice(name: 'Delete Object')];
