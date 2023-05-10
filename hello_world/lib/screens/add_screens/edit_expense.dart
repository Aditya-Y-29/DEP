// import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:hello_world/components/expense.dart';

class EditExpenseScreen extends StatefulWidget {
  const EditExpenseScreen({Key? key, required this.isFromCommunityPage, required this.isFromObjectPage,required this.expense}) : super(key: key);
  final bool isFromCommunityPage;
  final bool isFromObjectPage;
  final Expense expense;

  @override
  State<EditExpenseScreen> createState() => ExpenseData();
}

class ExpenseData extends State<EditExpenseScreen> {

  final _formKey = GlobalKey<FormState>();


  String communityDropDown='';
  String objectDropDown='';
  late int amount;
  TextEditingController amountInvolved = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController dateController =TextEditingController();

  






  void initState(){
    super.initState();
    description.text='${widget.expense.description}';
    amountInvolved.text='${widget.expense.amount}';
    dateController.text='${widget.expense.date}';
  }


  Widget build(BuildContext context) {


    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

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
                    'Edit Expense',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),  

                  SizedBox(height: 10,),

                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.currency_rupee_outlined),
                      hintText: 'amount',
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
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed

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
                        heroTag: "BTN-22",
                        // added checks for empty fields
                        onPressed: () async {
                          if(RegExp(r'[,.-]').hasMatch(amountInvolved.text)){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Amount should be valid'),duration: Duration(seconds: 3)),
                            );
                            return;
                          }

                          if(dateController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Date cannot be empty'),duration: Duration(seconds: 3),),
                            );
                            return;
                          }

                          // CHANGED HERE
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Editing Expenses'),duration: Duration(seconds: 8))
                          );

                          bool res=await providerCommunity.updateExpense(widget.expense,amountInvolved.text,dateController.text, description.text);
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();

                          if(!res){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error in Editing Expense'),duration: Duration(seconds: 1))
                            );
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Expense Edited'),duration: Duration(seconds: 1))
                            );
                          }

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

// creator name: providerCommunity.user?.name as String
