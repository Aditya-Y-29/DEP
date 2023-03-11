import 'package:flutter/material.dart';
import 'package:hello_world/Pages/object_page.dart';
import 'package:provider/provider.dart';
import '../components/object.dart';
import '../provider/data_provider.dart';
import '../components/community.dart';
import 'package:hello_world/Pages/object_page.dart';
import 'package:hello_world/Pages/profile_page.dart';
import 'package:hello_world/Pages/navigation_page.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<String> items = ["PC", "TV", "Oven", "Fridge"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
            );
          },
        ),
        title: const Text("Home"),
        actions:  [
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
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, objectDataProvider, child) {
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
                              onPressed: () {},
                              child: const Icon(Icons.check_circle_outline),
                            ),
                          ),
                          const Text(
                            "Resolve",
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
                              onPressed: () {},
                              child: const Icon(Icons.monetization_on_sharp),
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
                              onPressed: () {},
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
                              onPressed: () {},
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
                    Object(
                      name: objectDataProvider.objects[0],
                    ),
                    Object(
                      name: objectDataProvider.objects[1],
                    ),
                    Object(
                      name: objectDataProvider.objects[2],
                    ),
                    Object(
                      name: objectDataProvider.objects[3],
                    ),
                  ]
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfilePage()),
          );
        },
        child: const Icon(Icons.add),
      )
    );
  }
}
