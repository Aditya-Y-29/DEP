import 'package:flutter/material.dart';
import 'package:hello_world/community.dart';

class AddExpenseService extends StatelessWidget {
  const AddExpenseService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Expense'),
              Tab(text: 'Service',),
              Tab(text: 'Community',),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 225, 135, 18),
        ),
        body: const TabBarView(
          children: [
            ExpenseScreen(),
            ServiceScreen(),
            CommunityScreen(),
          ],
        ),
      ),
    );
  }
}

// Join Screen




class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => ExpenseData();
}

class ExpenseData extends State<ExpenseScreen> {

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
              hintText: 'Enter the Community Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Amount',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Description',
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.red[400],
                child: const Text('Add'),
              )),
        ],
      ),
    );
  }
}

// Create Screen





class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);
  
  @override
  State<ServiceScreen> createState() => ServiceData();
}

class ServiceData extends State<ServiceScreen> {

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
              hintText: 'Enter the Community Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Service Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Description',
            ),
          ),
          Container(
              padding: const EdgeInsets.only(left: 150.0, top: 40.0),
              child: FloatingActionButton(
                onPressed: null,
                backgroundColor: Colors.red[400],
                child: const Text('Add'),
              )
          ),
        ],
      ),
    );
  }
}


////


class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => CommunityData();
}

class CommunityData extends State<CommunityScreen> {

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
              hintText: 'Enter the Community Name',
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Description',
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