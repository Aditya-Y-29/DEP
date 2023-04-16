import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
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
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child:
        Column(
          children: <Widget>[
            const Text(
              'Add Community',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10,),

            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                icon: Icon(Icons.home_work),
                hintText: 'Enter the Community Name',
              ),
              controller: communityName,
            ),

            SizedBox(height: 10,),

            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.edit),
                hintText: 'Description',
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: FloatingActionButton(
                  heroTag: "BTN-19",
                  onPressed: () async {
                    providerCommunity.addCommunity(communityName.text);
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.check),
                )
            ),
          ],
        ),
      )
    );
  }
}