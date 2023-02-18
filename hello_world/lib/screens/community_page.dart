import 'package:flutter/material.dart';
import './community.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<String> items = ["PC", "Television", "Microwave", "Fridge"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, size: 40.0),
          onPressed: (){},
        ),
        title: Text("Utility Application"),
        actions: const [
          Icon(Icons.person_2_outlined, size: 40.0)
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Icon(Icons.person_add, size: 40.0, color: Colors.white,),
              Row(
                children:  <Widget>[
                  Icon(Icons.home, size: 40.0, color: Colors.lightBlue[100],),
                  Text(
                    "Home",
                    style: TextStyle(
                    color: Colors.lightBlue[100],
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
            ]),
            const Icon(Icons.search, size: 40.0, color: Colors.white,)
          ])
        ),
      ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        // childAspectRatio:  3,
        children: List.generate(items.length, (index) {
          return Align(
            child: Container(
              height: 500.0,
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              // color: Colors.red,
              child: Community(name: items[index],),
            ),
          );
        }),
      ),
    );
  }
}
