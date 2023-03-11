import 'package:flutter/material.dart';
import 'package:hello_world/Pages/community_page.dart';
import 'package:hello_world/Pages/profile_page.dart';
import 'package:provider/provider.dart';
import '../components/community.dart';
import '../screens/add_community.dart';
import 'add_home_page_floating_button.dart';
import '../provider/data_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30,),
          onPressed: () {},
        ),
        title: const Text("Your Communities"),
        actions:  [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            child:
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Icon(Icons.person_2_outlined, size: 30,),
              )
          )
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, communityDataProvider, child) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenseServiceCommunity(selectedPage: 2),
                                  ),
                                );
                              },
                              child: const Icon(Icons.home_work),
                            ),
                          ),
                          const Text(
                            "Community",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenseServiceCommunity(selectedPage: 0),
                                  ),
                                );
                              },
                              child: const Icon(Icons.currency_rupee_outlined),
                            ),
                          ),
                          const Text(
                            "Expense",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenseServiceCommunity(selectedPage: 1),
                                  ),
                                );
                              },
                              child: const Icon(Icons.home_repair_service),
                            ),
                          ),
                          const Text(
                            "Service",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenseServiceCommunity(selectedPage: 3),
                                  ),
                                );
                              },
                              child: const Icon(Icons.data_object),
                            ),
                          ),
                          const Text(
                              "Object",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  Community(
                    name: communityDataProvider.communities[0],
                  ),
                  Community(
                    name: communityDataProvider.communities[1],
                  ),
                  Community(
                    name: communityDataProvider.communities[2],
                  ),
                ]
              ),
            ],
          );
        },
      ),
    );
  }
}

