// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hello_world/Pages/auth_pages/phone.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key, required this.isFromCommunityPage, required this.isFromObjectPage, required this.communityName, required this.objectName}) : super(key: key);
  final bool isFromCommunityPage;
  final bool isFromObjectPage;
  final String communityName;
  final String objectName;

  @override
  State<ExpenseScreen> createState() => ExpenseData();
}

class ExpenseData extends State<ExpenseScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController dateController =TextEditingController();

  String communityDropDown='';
  String objectDropDown='';
  late int amount;
  TextEditingController amountInvolved = TextEditingController();
  TextEditingController description = TextEditingController();


  @override
  void initState(){
    super.initState();
    dateController.text="";
  }
  @override
  Widget build(BuildContext context) {


    final providerCommunity = Provider.of<DataProvider>(context, listen: true);
    if(widget.isFromCommunityPage) {
      communityDropDown=widget.communityName;
    } else {
      communityDropDown=providerCommunity.communities[providerCommunity.communitiesIndex];
    }



    if(widget.isFromObjectPage){
        objectDropDown=widget.objectName;
      } else if (providerCommunity.communityObjectMap[communityDropDown]!.isNotEmpty) {
      objectDropDown=providerCommunity.communityObjectMap[communityDropDown]![providerCommunity.objectIndex];
    } else {
      return const Center(child: Text("No Objects in this Community"));
    }

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        // child: Center(
          child: SingleChildScrollView(
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Add Expense',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10,),

                if(!widget.isFromCommunityPage && !widget.isFromObjectPage)
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.home_work),
                      hintText: 'Community',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
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
                        providerCommunity.communityListen(communityDropDown);
                      });
                    },
                  ),

                SizedBox(height: 10,),

                if(!widget.isFromObjectPage)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.data_object),
                    hintText: 'Object',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
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
                    // print(objectDropDown);
                    providerCommunity.objectListen(communityDropDown, objectDropDown);
                  },
                ),


                SizedBox(height: 10,),

                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.currency_rupee_outlined),
                    hintText: 'Amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountInvolved,
                ),

                SizedBox(height: 10,),

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


                SizedBox(height: 10,),


                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.edit),
                    hintText: 'Description',
                  ),
                  controller: description,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        // print(objectDropDown);
                        providerCommunity.addExpense(objectDropDown, providerCommunity.user?.name as String, int.parse(amountInvolved.text), description.text,communityDropDown);
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.check),
                    )),
              ],
            ),
          // )
        )
      )
    );
  }
}
