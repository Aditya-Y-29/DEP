import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ResolveScreen extends StatefulWidget {
  const ResolveScreen({Key? key, required this.communityName}) : super(key: key);
  final String communityName;

  @override
  State<ResolveScreen> createState() => ResolveData();
}

class ResolveData extends State<ResolveScreen> {

  final _formKey = GlobalKey<FormState>();
  String objectDropDown='';
  String resolveDropDown='';
  bool isExpense=true;


  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);
    objectDropDown=providerCommunity.communityObjectMap[widget.communityName]![0];

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
                    'Resolve',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10,),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.data_object),
                      hintText: 'Object',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    value : objectDropDown,
                    items: providerCommunity.communityObjectMap[widget.communityName]?.map<DropdownMenuItem<String>>((String chosenValue) {
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


                  SizedBox(height: 10,),

                  Row(
                    children: [
                      Flexible(
                        child:
                          ListTile(
                            title: const Text('Expense'),
                            leading: Radio(
                              value: true,
                              groupValue: isExpense,
                              onChanged: (bool? value) {
                                setState(() {
                                  isExpense = value!;
                                });
                              },
                            ),
                          ),
                      ),
                      Flexible(
                        child:
                        ListTile(
                          title: const Text('Service'),
                          leading: Radio(
                            value: false,
                            groupValue: isExpense,
                            onChanged: (bool? value) {
                              setState(() {
                                isExpense = value!;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.check_circle_outline),
                      hintText: 'Object',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    value : resolveDropDown,
                    items: providerCommunity.objectUnresolvedExpenseMap[objectDropDown]!.map<DropdownMenuItem<String>>((Expense expense) {
                      return DropdownMenuItem<String>(
                        value: expense.description,
                        child: Text(expense.description),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        resolveDropDown = newValue!;
                      });
                    },
                  ),

                  SizedBox(height: 10,),

                  TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.edit),
                      hintText: 'Description',
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      child: FloatingActionButton.extended(
                        onPressed: null,
                        label: Row(
                          children: const [
                            Text("Resolve"),
                          ],
                        )
                      )),
                ],
              ),
              // )
            )
        )
    );
  }
}
