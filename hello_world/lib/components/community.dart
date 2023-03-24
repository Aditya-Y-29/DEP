import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/community_page.dart';
import '../Pages/add_from_pages/add_from_community_page.dart';
import '../Pages/add_from_pages/add_home_page_floating_button.dart';

class Community extends StatefulWidget {
  final String name;
  const Community({ Key? key, required this.name }): super(key: key);
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  Choice selectedOption = choices[0];
  handleSelect(Choice choice) async {
    setState(() {
      selectedOption = choice;
    });
  }

  bool clicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => CommunityPage(communityName: widget.name,)
        //     )
        // );
        setState(() {
          clicked = !clicked;
        });
      },
      child: Container(
      // width: 150,
      // height: 150,
      // margin: const EdgeInsets.all(5.0),
      // padding: const EdgeInsets.only(left: 20.0),
      // decoration: BoxDecoration(
      //   color: clicked ? Colors.blue.shade50 : Colors.grey.shade100,
      //   border: Border.all(
      //     color: clicked ? Colors.blue : Colors.blue.withOpacity(0),
      //     width: 2.0,
      //   ),
      //   borderRadius: BorderRadius.circular(20.0),
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
      // duration: const Duration(milliseconds: 250),
      // curve: Curves.easeIn,
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
                      child:
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    )
                ),
                PopupMenuButton<Choice>(
                  itemBuilder: (BuildContext context) {
                    return choices.skip(0).map((Choice choice) {
                      return PopupMenuItem <Choice>(
                        value: choice,
                        child: Text(choice.name),
                      );
                    }).toList();
                  },
                  onSelected: (value) {
                    if(value.name == "Add Expense")
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFromHomePage(selectedPage: 0)),
                      );
                    }
                    // else if (value.name == "Add Service")
                    // {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => AddFromHomePage(selectedPage: 1)),
                    //   );
                    // }
                  },
                  // color: Colors.black,
                ),
              ]
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 5.0, right: 5.0),
              height: 35.0,
              width: 35.0,
              child: FloatingActionButton(
                heroTag: "Comm_Btn",
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFromCommunityPage(selectedPage: 0, communityName: widget.name,)),
                  );
                },
                backgroundColor: Colors.green,
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    )
    );
  }
}


class Choice {
  final String name;
  const Choice({ required this.name});
}

const List<Choice> choices = <Choice> [
  Choice(name: 'Add to Favourites'),
  Choice(name: 'Delete Community')
];

