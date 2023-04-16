import 'package:flutter/material.dart';
import 'package:hello_world/Pages/group_member_pages/add_member_page.dart';
import 'package:provider/provider.dart';
import '../../components/member.dart';
import '../../provider/data_provider.dart';
import '../main_pages/home_page.dart';

class CommunityInfo extends StatefulWidget {
  const CommunityInfo({Key? key, required this.communityName}) : super(key: key);
  final String communityName;

  @override
  State<CommunityInfo> createState() => _CommunityInfoState();
}

class _CommunityInfoState extends State<CommunityInfo> {

  bool isLongPressed = false;
  late Offset tapXY;
  late RenderBox overlay;

  @override
  Widget build(BuildContext context) {

    overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);
    bool hasCreatorPower = false;
    int creators = 0;
    int len = providerCommunity.communityMembersMap[widget.communityName] == null ? 0 : providerCommunity.communityMembersMap[widget.communityName]!.length;
    for(var i=0;i<len;i++){
      Member member = providerCommunity.communityMembersMap[widget.communityName]![i];
      // print("index: $i, name: ${member.name}, phone: ${member.phone}, isCreator: ${member.isCreator}");
      if(member.isCreator){
        creators++;
        if(member.phone == providerCommunity.user!.phoneNo) {
            hasCreatorPower = true;
          }
      }
    }
    print("creators: $creators, hasCreatorPower: $hasCreatorPower");

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
          child:
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
              Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AddMembers(communityName: widget.communityName)));
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // border: Border.all(color: Colors.green, width: 2),
                              color: Colors.green.shade100,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  child:
                                    CircleAvatar(
                                      child: Icon(Icons.person_add),
                                    ),
                                  ),
                                SizedBox(width: 10,),
                                Text('Add Member', style: TextStyle(fontSize: 18),)
                              ]
                            )
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                            border: Border.all(color: Colors.green, width: 2),
                          ),
                          child: const Text('Members', style: TextStyle(fontSize: 17),)
                        ),
                        Expanded(
                            child:
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            // decoration: BoxDecoration(
                            //   border: Border.all(color: Colors.green, width: 2),
                            // ),
                            child:
                            ListView(
                                children: providerCommunity.communityMembersMap[widget.communityName] == null ? [] : List.of(providerCommunity.communityMembersMap[widget.communityName]!.map(
                                      (member) =>
                                          GestureDetector(
                                          // onLongPressCancel: () {
                                          //   setState(() {
                                          //     isLongPressed = false;
                                          //   });
                                          // },
                                          onTapDown: getPosition,
                                          onLongPress: () async {
                                            // setState(() {
                                            //   isLongPressed = true;
                                            // });
                                            if(!hasCreatorPower || member.phone == providerCommunity.user!.phoneNo){
                                              return;
                                            }
                                           int selected = await showMenu(
                                              items: <PopupMenuEntry>[
                                                PopupMenuItem(
                                                  value: 0,
                                                  child: Row(
                                                    children: [
                                                      Text("Remove ${member.name}"),
                                                    ],
                                                  ),
                                                ),
                                                PopupMenuItem(
                                                  value: 1,
                                                  child: Row(
                                                    children: [
                                                      member.isCreator ? Text("Remove creator power") :
                                                      Text("Give creator power"),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              context: context,
                                              position: relRectSize, // TODO: fix positioning,
                                            );
                                            if(selected == 0){
                                              providerCommunity.removeMemberFromCommunity(widget.communityName, member.phone);
                                            }
                                            else if(selected == 1){
                                              providerCommunity.toggleCreatorPower(widget.communityName, member.phone);
                                            }
                                          },
                                          child: Container(
                                            color: isLongPressed ? Colors.green.shade100 : Colors.green.shade50,
                                            child:
                                              Member(
                                                      name: member.name,
                                                      phone: member.phone,
                                                      isCreator: member.isCreator,
                                                    ),
                                          ),
                                      ),
                                ),
                              ))
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(providerCommunity.communityMembersMap[widget.communityName]!.length == 1) {
                              providerCommunity.deleteCommunity(widget.communityName);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                              return;
                            }
                            else if(hasCreatorPower && creators == 1) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("You are the only creator, make another creator before leaving!"),
                                  duration: Duration(seconds: 2),
                                )
                              );
                              return;
                            }
                            providerCommunity.removeMemberFromCommunity(widget.communityName, providerCommunity.user!.phoneNo);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                          },
                          child:
                          Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.red, width: 2),
                              color: Colors.red.shade50,
                            ),
                            child:
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Exit Community ${widget.communityName}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Icon(Icons.output_sharp, color: Colors.red,)
                                  ],
                                )
                              ],
                            )
                          )
                        )
                    ],
                  )
                  // )
                // ],
              // )
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
              padding: const EdgeInsets.only(right: 8.0,bottom: 8,top: 4),
              child: FloatingActionButton(
                heroTag: "BTN-4",
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
  RelativeRect get relRectSize => RelativeRect.fromSize(tapXY & const Size(40, 40), overlay.size);
  void getPosition(TapDownDetails details) {
    tapXY = details.globalPosition;
  }
}

