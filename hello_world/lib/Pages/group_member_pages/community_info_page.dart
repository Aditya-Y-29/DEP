import 'package:flutter/material.dart';
import 'package:hello_world/Pages/group_member_pages/add_member_page.dart';
import 'package:provider/provider.dart';

import '../../components/member.dart';
import '../../provider/data_provider.dart';

class CommunityInfo extends StatefulWidget {
  const CommunityInfo({Key? key, required this.communityName}) : super(key: key);
  final String communityName;

  @override
  State<CommunityInfo> createState() => _CommunityInfoState();
}

class _CommunityInfoState extends State<CommunityInfo> {
  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.communityName} Info'),
      ),
      body: Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers(communityName: widget.communityName)));
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
                  children: List.of(providerCommunity.communityMembersMap[widget.communityName] as Iterable<Widget>)
                )
            )
          ],
        )
      )
    );
  }
}
