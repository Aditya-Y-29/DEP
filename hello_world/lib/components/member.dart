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
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            child: Text(
                widget.name[0],
                style: const TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name, style: const TextStyle(fontSize: 20),),
              Text(widget.phone, style: const TextStyle(fontSize: 15),),
              widget.isCreator ? const Text('Creator', style: TextStyle(fontSize: 15, color: Colors.green),) : const Text('Member', style: TextStyle(fontSize: 15, color: Colors.red),)
            ],
          )
        ],
      ),

    );
  }
}
