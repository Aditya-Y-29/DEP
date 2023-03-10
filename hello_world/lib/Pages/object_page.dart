//create a page for an object.dart that consists of two screens in two separate tabs; namely Expenses and Services
import 'package:flutter/material.dart';
import 'package:hello_world/screens/object_expense.dart';
import 'package:hello_world/screens/object_service.dart';

import 'add_home_page_floating_button.dart';

class ObjectPage extends StatefulWidget {
  const ObjectPage({Key? key}) : super(key: key);

  @override
  State<ObjectPage> createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, size: 40.0),
          onPressed: (){},
        ),
        title: const Text("Utility Application"),
        actions: const [
          Icon(Icons.person_2_outlined, size: 40.0)
        ],



        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children:  <Widget>[
                  Icon(Icons.tv, size: 40.0, color: Colors.lightBlue[100],),
                  Text(
                    " TV",
                    style: TextStyle(
                      color: Colors.lightBlue[100],
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                  ),
                ]),
          ])
        ),
      ),),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Expenses'),
                Tab(text: 'Services',),
              ],
              indicatorColor: Colors.white,
            ),
            backgroundColor: const Color.fromARGB(255, 225, 135, 18),
          ),
          ),
          body: const TabBarView(
            children: [
              ObjectExpenseScreen(),
              ObjectServiceScreen(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
