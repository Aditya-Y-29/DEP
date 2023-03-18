import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMembers> {
  var selectedContacts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Members'),
      ),
      body: Container(

      ),
    );
  }
}
