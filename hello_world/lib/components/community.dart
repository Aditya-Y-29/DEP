import 'package:flutter/material.dart';
import 'package:hello_world/Pages/community_page.dart';
import '../Pages/add_home_page_floating_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommunityPage(communityName: widget.name,)
            )
        );
      },
      child: Container(
      width: 150,
      height: 100,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.only(left: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 15.0, // soften the shadow
            spreadRadius: 1.0, //extend the shadow
            offset: Offset(
              1.0, // Move to right 5  horizontally
              1.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
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
                      print("pressed add expense");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFromHomePage(selectedPage: 0)),
                      );
                    }
                    else if (value.name == "Add Service")
                    {
                      print("pressed add service");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddFromHomePage(selectedPage: 1)),
                      );
                    }
                  },
                  // color: Colors.black,
                ),
              ]
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 25.0,
              width: 25.0,
              child: FloatingActionButton(
                heroTag: "Comm_Btn",
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddFromHomePage(selectedPage: 0)),
                  );
                },
                child: const  Text(
                    "+"
                ),
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

