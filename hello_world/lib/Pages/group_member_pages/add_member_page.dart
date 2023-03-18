import 'package:flutter/material.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Members'),
      ),
    );
  }
}
