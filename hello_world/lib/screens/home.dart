import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'community.dart';
import 'add_expense_service_community.dart';
import '../provider/community_data_provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ["Home", "Office"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Communities"),
      ),
      body: Consumer<CommunityDataProvider>(
        builder: (context, communityDataProvider, child) {
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio:  3,
            children: List.generate(communityDataProvider.len, (index) {
              return  Community(name: communityDataProvider.communities[index].toString(),);
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

