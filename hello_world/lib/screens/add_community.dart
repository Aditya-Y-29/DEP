import 'package:flutter/material.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';


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

    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
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