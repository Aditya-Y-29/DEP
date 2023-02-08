import 'package:flutter/material.dart';

class AddCommunity extends StatelessWidget {
  const AddCommunity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Join'),
              Tab(text: 'Create',),
            ],
          ),
          backgroundColor: Colors.red[400],
        ),
        body: const TabBarView(
          children: [
            JoinScreen(),
            CreateScreen(),
          ],
        ),
      ),
    );
  }
}

// Join Screen
class JoinScreen extends StatefulWidget {
  const JoinScreen({Key? key}) : super(key: key);

  @override
  State<JoinScreen> createState() => FormData();
}

class FormData extends State<JoinScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Enter the community code',
              labelText: 'Code',
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.red[400],
                child: const Text('Join'),
              )),
        ],
      ),
    );
  }
}

// Create Screen
class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);
  
  @override
  State<CreateScreen> createState() => CreateData();
}

class CreateData extends State<CreateScreen> {

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Enter the community name',
              labelText: 'Name',
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.red[400],
                child: const Text('Create'),
              )
          ),
        ],
      ),
    );
  }
}

