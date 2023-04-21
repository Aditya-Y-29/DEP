import 'package:flutter/material.dart';
import '../Pages/add_from_pages/add_from_community_page.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class Community extends StatefulWidget {
  final String creatorTuple;
  const Community({ Key? key, required this.creatorTuple }): super(key: key);
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  Future<bool> showDeleteDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete ${(widget.creatorTuple).split(":")[0]} community?'),
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
    if(choice.name=="Delete Community"){
      Future<bool> returnValue= showDeleteDialog(context);
      bool alertResponse = await returnValue;
      if(alertResponse==true){
        if(await Provider.of<DataProvider>(context, listen: false).isAdmin(widget.creatorTuple)==true){
          Provider.of<DataProvider>(context, listen: false).deleteCommunity(widget.creatorTuple);
        }
        else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Only creators have delete power! Become a creator to delete this community!'),
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

  bool clicked = false;

  Random random = Random();
  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                        child:
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green.shade200,
                              width: 1.0,
                            ),
                          ),
                          child:
                          Image.asset(
                            '${providerCommunity.extractCommunityImagePathByName(widget.creatorTuple)}',
                            // 'assets/images/Home.jpg',
                            width: 45,
                            height: 45,
                          ),
                        )
                    ),
                    Flexible(
                        child:
                        Container(
                          child:
                              Column(
                              children: [
                                Text(
                                  (widget.creatorTuple).split(":")[0],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person_pin_circle_outlined, size: 14,),
                                    Flexible(
                                      child:
                                        Text(
                                          providerCommunity.communityMembersMap.isEmpty ? "Creator" :
                                          providerCommunity.communityMembersMap[widget.creatorTuple]!.firstWhere((member) => member.phone == (widget.creatorTuple).split(":")[1], orElse: () => providerCommunity.communityMembersMap[widget.creatorTuple]!.firstWhere((member) => member.isCreator == true)).name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    )
                                  ],
                                )
                              ],
                              )
                        )
                    ),
                    Column(
                    children: <Widget>[
                      // First Row
                       Row(
                        children: <Widget>[
                        // Widgets for the first row
                          Icon(
                            Icons.person,
                          ),
                          Text(' = ',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),),
                          Text("₹ ${providerCommunity.myExpenseInCommunity(widget.creatorTuple)}",
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 13,
                            ),),
                         ],
                       ),

                      // Second Row
                      Row(
                      children: <Widget>[
                      // Widgets for the second row
                        Icon(
                          Icons.group,

                        ),
                        Text(' = ',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),),
                        Text("₹ ${providerCommunity.communityTotalExpense(widget.creatorTuple)}",
                          style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                          ),),
                        ],
                      ),
                    ],
                      ),

                    Row(
                      children: [
                          // PopupMenuButton<Choice>(
                          //   itemBuilder: (BuildContext context) {
                          //     return choices.skip(0).map((Choice choice) {
                          //       return PopupMenuItem <Choice>(
                          //         value: choice,
                          //         child: Text(choice.name),
                          //
                          //       );
                          //     }).toList();
                          //
                          //   },
                          //   onSelected: handleSelect,
                          // ),
                          Container(
                              margin: const EdgeInsets.only(bottom: 1.0, right: 1.0),
                              height: 30.0,
                              width: 30.0,
                              child: new FloatingActionButton(
                                heroTag: "${random.nextInt(1000000)}",
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => AddFromCommunityPage(selectedPage: 0, creatorTuple: widget.creatorTuple,)),
                                  );
                                },
                                backgroundColor: Colors.green,
                                child: FittedBox(
                                  child: const Icon(
                                    Icons.add,
                                  ),
                                ),
                              ),
                            ),
                          // ),
                      PopupMenuButton<Choice>(
                        itemBuilder: (BuildContext context) {
                          return choices.skip(0).map((Choice choice) {
                            return PopupMenuItem <Choice>(
                              value: choice,
                              child: Text(choice.name),
                            );
                          }).toList();
                        },
                        onSelected: handleSelect
                        // color: Colors.black,
                      ),
                     ])
                  ]
              ),
            ],
          ),
        );
    // );
  }
}


class Choice {
  final String name;
  const Choice({ required this.name});
}

const List<Choice> choices = <Choice> [
  Choice(name: 'Delete Community')
];
