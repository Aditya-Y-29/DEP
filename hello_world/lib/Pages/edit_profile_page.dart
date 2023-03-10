import 'package:flutter/material.dart';
import 'package:hello_world/Pages/profile_page.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);
  @override
  EditProfilePageState createState() => EditProfilePageState();
}
class EditProfilePageState extends State<EditProfilePage> {

  String _userName = 'UserName';
  String _userMail = 'Email';
  String _userContact = 'Contact Number';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),

          child:AppBar(
            title: Text('Settings'),
            actions: <Widget>[

            ],
          ),
        ),
        body: ListView(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
              decoration: InputDecoration(
                hintText: '  userName',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _userMail = value;
                });
              },
              decoration: InputDecoration(
                hintText: '  userMail',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _userContact = value;
                });
              },
              decoration: InputDecoration(
                hintText: '  userContact',
              ),
            ),
            SizedBox(height: 20),


          ],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {

    },
    child: const Icon(Icons.save_as),
    ),
    );
  }
}
