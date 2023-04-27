import 'dart:math';

import 'package:flutter/material.dart';

class Member extends StatefulWidget {
  Member({Key? key, required this.name,required this.isCreator, required this.phone}) : super(key: key);
  final String name;
  final String phone;
  bool isCreator;
  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  final GlobalKey widgetKey = GlobalKey();
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5,right: 5,left: 5),
      padding: const EdgeInsets.all(0),
      child: Row(
        children: [
          Expanded(
              child :  ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green[100],
                  child: Text(widget.name[0]),
                ),
                title: Text(widget.name),
                subtitle: Text(widget.phone),
                trailing:  widget.isCreator ? const Text('Creator', style: TextStyle(fontSize: 15, color: Colors.blue),) : const Text('Member', style: TextStyle(fontSize: 15, color: Colors.grey),),
              )
          ),
        ],
      )
    );
  }
}