import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';
import 'package:hello_world/Pages/main_pages/community_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);
  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),

        child:AppBar(
          title: Text('Utility App'),

        ),
      ),
      body: ListView(
          children: <Widget>[
      Container(
      margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
      padding:EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: ListTile(
        //leading: Icon(Icons.person),
        title: Text('Notification'),
        //subtitle: Text(''),
        ),
       ),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
              padding:EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: ListTile(
                //leading: Icon(Icons.person),
                title: Text('Archieved Communities'),
                //subtitle: Text(''),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
              padding:EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: ListTile(
                //leading: Icon(Icons.person),
                title: Text('To Do'),
                //subtitle: Text(''),
              ),
            ),
          ],
      )

    );
  }
}
