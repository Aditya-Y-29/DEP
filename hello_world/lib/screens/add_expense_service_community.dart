import 'package:flutter/material.dart';
import '../provider/community_data_provider.dart';
import 'package:provider/provider.dart';

class AddExpenseServiceCommunity extends StatefulWidget {
  const AddExpenseServiceCommunity({Key? key}) : super(key: key);

  @override
  State<AddExpenseServiceCommunity> createState() => _AddExpenseServiceCommunityData();
}

class _AddExpenseServiceCommunityData extends State<AddExpenseServiceCommunity> {

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

  String communityDropDown='';
  String objectDropDown='';

  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<CommunityDataProvider>(context, listen: true);

    communityDropDown=providerCommunity.communities[providerCommunity.communities_index];

    objectDropDown=providerCommunity.communityObjectMap[communityDropDown]![0];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          DropdownButtonFormField<String>(
            value : communityDropDown,
            items: providerCommunity.communities.map<DropdownMenuItem<String>>((String chosenValue) {
              return DropdownMenuItem<String>(
                value: chosenValue,
                child: Text(chosenValue),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                communityDropDown = newValue!;
                objectDropDown=providerCommunity.communityObjectMap[communityDropDown]![0];
                providerCommunity.dolistening(communityDropDown);
              });
            },
          ),

      
          DropdownButtonFormField<String>(
            value : objectDropDown,
            items: providerCommunity.communityObjectMap[communityDropDown]?.map<DropdownMenuItem<String>>((String chosenValue) {
              return DropdownMenuItem<String>(
                value: chosenValue,
                child: Text(chosenValue),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                objectDropDown = newValue!;
              });
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.home),
              hintText: 'Amount',
            ),
            keyboardType: TextInputType.number,
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

  String communityDropDown='';
  String objectDropDown='';

  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<CommunityDataProvider>(context, listen: true);

    communityDropDown=providerCommunity.communities[providerCommunity.communities_index];

    objectDropDown=providerCommunity.communityObjectMap[communityDropDown]![0];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          DropdownButtonFormField<String>(
            value : communityDropDown,
            items: providerCommunity.communities.map<DropdownMenuItem<String>>((String chosenValue) {
              return DropdownMenuItem<String>(
                value: chosenValue,
                child: Text(chosenValue),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                communityDropDown = newValue!;
                objectDropDown=providerCommunity.communityObjectMap[communityDropDown]![0];
                providerCommunity.dolistening(communityDropDown);
              });
            },
          ),

      
          DropdownButtonFormField<String>(
            value : objectDropDown,
            items: providerCommunity.communityObjectMap[communityDropDown]?.map<DropdownMenuItem<String>>((String chosenValue) {
              return DropdownMenuItem<String>(
                value: chosenValue,
                child: Text(chosenValue),
              );
            }).toList(),

            onChanged: (String? newValue) {
              setState(() {
                objectDropDown = newValue!;
              });
            },
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

  TextEditingController communityName = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<CommunityDataProvider>(context, listen: false);
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
            controller: communityName,
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
                onPressed: (){
                  providerCommunity.addCommunity(communityName.text);
                },
                backgroundColor: Colors.red[400],
                child: const Text('Create'),
              )
          ),
        ],
      ),
    );
  }
}