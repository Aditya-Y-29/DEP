import 'package:flutter/material.dart';
import 'package:hello_world/Pages/object_page.dart';
import 'package:hello_world/Pages/community_page.dart';
import 'package:hello_world/Pages/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),

          child:AppBar(
            title: Text('My Profile'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
           Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => EditProfilePage()),
           );
          },
        )
      ],
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
              leading: Icon(Icons.person),
              title: Text('Name'),
              subtitle: Text('UserName'),//from database
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
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text('user@email.com'),//from database
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
              leading: Icon(Icons.phone_android),
              title: Text('Mobile Number'),
              subtitle: Text('123'),//from database
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
              leading: Icon(Icons.details),
              title: Text('Details'),
              subtitle: Text('About'),//from database
            ),
          ),


        ],
      )

        );
  }
}

