import 'package:flutter/material.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';



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

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

    communityDropDown=providerCommunity.communities[providerCommunity.communitiesindex];

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
