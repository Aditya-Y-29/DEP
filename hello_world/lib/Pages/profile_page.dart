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
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Name'),
            subtitle: Text('UserName'),//from database
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('user@email.com'),//from database
          ),
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Mobile Number'),
            subtitle: Text('123'),//from database
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Details'),
            subtitle: Text('About'),
          ),
        ],
      )

        );
  }
}

