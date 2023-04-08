import 'package:flutter/material.dart';

class Member extends StatefulWidget {
  const Member({Key? key, required this.name,required this.isCreator, required this.phone}) : super(key: key);
  final String name;
  final String phone;
  final bool isCreator;
  @override
  State<Member> createState() => _MemberState();
}

class _MemberState extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 2.0,
        ),
      ),
      margin: const EdgeInsets.only(top: 5,right: 5,left: 5),
      padding: const EdgeInsets.all(0),
      child: Expanded(
          child :  ListTile(
            leading: CircleAvatar(
              child: Text(widget.name[0]),
            ),
            title: Text(widget.name),
            subtitle: Text(widget.phone),
            trailing:  widget.isCreator ? const Text('Creator', style: TextStyle(fontSize: 15, color: Colors.blue),) : const Text('Member', style: TextStyle(fontSize: 15, color: Colors.grey),),
          )
      ),
    );
  }
}