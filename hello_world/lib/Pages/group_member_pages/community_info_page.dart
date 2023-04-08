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
        title: Row(
          children: <Widget>[
            Image.asset(
              '${providerCommunity.extractCommunityImagePathByName(widget.communityName)}',
              width: 40,
              height: 40,
            ),
            SizedBox(width: 10),
            Text('${widget.communityName} Info'),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers(communityName: widget.communityName)));
            //   },
            //   child: Container(
            //     color: Colors.green.shade100,
            //     padding: const EdgeInsets.all(13),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         CircleAvatar(
            //             radius: 20,
            //             child:  Icon(Icons.person_add),
            //         ),
            //         SizedBox(width: 10,),
            //         Text('Add Member', style: TextStyle(fontSize: 18),)
            //       ],
            //     ),
            //   )
            // ),
            // const SizedBox(height: 10,),
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            //     border: Border.all(color: Colors.green, width: 2),
            //   ),
            //   child: const Text('Members', style: TextStyle(fontSize: 17),)
            // ),
            Expanded(
              child: 
                ListView(
                  children: List.of(providerCommunity.communityMembersMap[widget.communityName] as Iterable<Widget>)
                )
            )

          ],
        )
      ),
      bottomNavigationBar: BottomAppBar(
      color: Colors.green.shade50,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 16.0,height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 85.0,bottom: 8),
              child: FloatingActionButton(
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers(communityName: widget.communityName)));
                },
                child: Icon(Icons.person_add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0,bottom: 8,top: 4),
              child: FloatingActionButton(
                onPressed: () async {
                  DataProvider dataProvider =
                  Provider.of<DataProvider>(context, listen: false);
                  const snackbar1 = SnackBar(content: Text("Refreshing..."), duration: Duration(seconds: 8),);
                  ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                  await dataProvider.getAllDetails(dataProvider.user!.phoneNo);
                },
                child: Icon(Icons.sync),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
