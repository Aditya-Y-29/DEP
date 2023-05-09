import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class ObjectScreen extends StatefulWidget {
  const ObjectScreen({Key? key, required this.isFromCommunityPage, required this.creatorTuple}) : super(key: key);
  final bool isFromCommunityPage;
  final String creatorTuple;

  @override
  State<ObjectScreen> createState() => ObjectData();
}

class ObjectData extends State<ObjectScreen> {

  final _formKey = GlobalKey<FormState>();
  String communityDropDown='';

  @override
  void initState(){
    super.initState();
  }

  TextEditingController objectName = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

    if(providerCommunity.communities.isEmpty){
      return Container(margin: EdgeInsets.symmetric(horizontal: 30, vertical: 150),child: Text("Hey there! Swipe left to add your first community! Then come back here to add an object!", style: TextStyle(fontSize: 30),));
    }

    if(widget.isFromCommunityPage) {
      communityDropDown=widget.creatorTuple;
    } else {
      communityDropDown=providerCommunity.communities[providerCommunity.communitiesIndex];
    }

    return Form(
        key: _formKey,
        child: Container(
            padding: const EdgeInsets.all(16.0),
            // child: Center(
            child: SingleChildScrollView(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Add Object',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),

                  if(!widget.isFromCommunityPage)
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    itemHeight: null,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home_work),
                      hintText: 'Community',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    value : communityDropDown,
                    items: providerCommunity.communities.map<DropdownMenuItem<String>>((String chosenValue) {
                      return DropdownMenuItem<String>(
                        value: chosenValue,
                        child: Text((chosenValue).split(":")[0] + " - " + providerCommunity.communityMembersMap[chosenValue]!.firstWhere((member) => member.phone == (chosenValue).split(":")[1], orElse: () => providerCommunity.communityMembersMap[chosenValue]!.firstWhere((member) => member.isCreator == true)).name,),
                      );
                    }).toList(),

                    onChanged: (String? newValue) {
                      setState(() {
                        communityDropDown = newValue!;
                        providerCommunity.communityListen(communityDropDown);
                      });
                    },
                  ),

                  SizedBox(height: 10,),

                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      icon: Icon(Icons.grid_view),
                      hintText: 'Enter the Object Name',
                    ),
                    controller: objectName,
                  ),

                  SizedBox(height: 10,),

                  //
                  // TextFormField(
                  //   keyboardType: TextInputType.multiline,
                  //   maxLines: null,
                  //   decoration: const InputDecoration(
                  //     icon: Icon(Icons.edit),
                  //     hintText: 'Description',
                  //   ),
                  // ),
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: FloatingActionButton(
                        heroTag: "BTN-21",
                        // added checks for empty fields
                        onPressed: () {
                          if(objectName.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter the object name!'), duration: Duration(seconds: 3)));
                            return;
                          }
                          providerCommunity.addObject(communityDropDown, objectName.text);
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.check),
                      )),
                ],
              ),
              // )
            )
        )
    );
  }
}
