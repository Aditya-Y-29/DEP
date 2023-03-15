import 'package:flutter/material.dart';
import 'package:hello_world/Pages/add_from_pages/add_from_community_page.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';

import '../Pages/add_from_pages/add_from_object_page.dart';
import '../Pages/add_from_pages/add_home_page_floating_button.dart';
import 'community.dart';

class Object extends StatefulWidget {
  final String name;
  final String communityName;
  const Object({Key? key, required this.name, required this.communityName}) : super(key: key);

  @override
  State<Object> createState() => _ObjectState();
}

class _ObjectState extends State<Object> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ObjectPage(objectName: widget.name, communityName: widget.communityName,)
            )
        );
      },
      child: Container(
        // width: 150,
        // height: 100,
        // margin: const EdgeInsets.all(5.0),
        // padding: const EdgeInsets.only(left: 20.0),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(35.0),
        //   color: Colors.white,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      child:
                        Text(
                          widget.name,
                          style: const TextStyle(
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
      ),
    );
  }
}


const List<Choice> choices = <Choice> [
  Choice(name: 'Add to Favourites'),
  Choice(name: 'Delete Object')
];