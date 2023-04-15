import 'package:flutter/material.dart';

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
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
              padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child:  TextField(
                onChanged: (value) {
                  setState(() {
                    _userName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'userName',
                ),
              ),
            ),


            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
              padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child:  TextField(
                onChanged: (value) {
                  setState(() {
                    _userMail = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'userMail',
                ),
              ),
            ),

            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 5.0, top: 5,right: 5.0),
              padding:EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child:  TextField(
                onChanged: (value) {
                  setState(() {
                    _userContact = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'userContact',
                ),
              ),
            ),

            SizedBox(height: 20),


          ],
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {

    },
          child: Text('Save'),
          tooltip: 'Save',
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
