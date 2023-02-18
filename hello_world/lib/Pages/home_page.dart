import 'package:flutter/material.dart';
import 'package:hello_world/Pages/community_page.dart';
import 'package:provider/provider.dart';
import '../components/community.dart';
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
        title: const Text("Your Communities"),
      ),
      body: Consumer<DataProvider>(
        builder: (context, communityDataProvider, child) {
          return GridView.count(
            crossAxisCount: 2,
            // childAspectRatio:  3,
            children: List.generate(communityDataProvider.len, (index) {
              return  GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CommunityPage()),
                    );
                  },
                  child: Container(
                    height: 500.0,
                    padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    // color: Colors.red,
                    child: Community(name: communityDataProvider.communities[index].toString(),),
                  ),
              );
            }),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseServiceCommunity()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

