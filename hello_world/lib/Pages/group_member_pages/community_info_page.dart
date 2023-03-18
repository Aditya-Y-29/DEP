import 'package:flutter/material.dart';
import 'package:hello_world/Pages/group_member_pages/add_member_page.dart';

import '../../components/member.dart';

class CommunityInfo extends StatefulWidget {
  const CommunityInfo({Key? key}) : super(key: key);

  @override
  State<CommunityInfo> createState() => _CommunityInfoState();
}

class _CommunityInfoState extends State<CommunityInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Info'),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddMembers()));
              },
              child: Container(
                color: Colors.green.shade100,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                        radius: 25,
                        child:  Icon(Icons.person_add),
                    ),
                    SizedBox(width: 10,),
                    Text('Add Member', style: TextStyle(fontSize: 20),)
                  ],
                ),
              )
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: const Text('Members', style: TextStyle(fontSize: 20),)
            ),
            Expanded(
              child:
                ListView(
                  children: [
                      Member(name: "Pranav", phone: "1234567890", isCreator: true)
                  ],
                )
            )
          ],
        )
      )
    );
  }
}
