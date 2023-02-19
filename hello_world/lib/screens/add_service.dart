import 'package:flutter/material.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';



class ServiceScreen extends StatefulWidget {
  const ServiceScreen({Key? key}) : super(key: key);
  
  @override
  State<ServiceScreen> createState() => ServiceData();
}

class ServiceData extends State<ServiceScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController =TextEditingController();

  String communityDropDown='';
  String objectDropDown='';

  @override
  void initState(){
    super.initState();
    dateController.text="";
  }

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
              hintText: 'Service Name',
            ),
          ),
          TextField(
              controller: dateController, //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
              ),
              readOnly: true,  // when true user cannot edit text
              onTap: () async {
                //when click we have to show the datepicker
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(), //get today's date
                    firstDate:DateTime(1900), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime.now(),
                );
                if(pickedDate != null ){
                  // print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                  // print(formattedDate); //formatted date output using intl package =>  2022-07-04
                  //You can format date as per your need

                  setState(() {
                    dateController.text = formattedDate.toString(); //set foratted date to TextField value.
                  });
                }else{
                  //print("Date is not selected");
                }
              }

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
