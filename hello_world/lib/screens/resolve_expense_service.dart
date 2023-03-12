import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/service.dart';
import '../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ResolveScreen extends StatefulWidget {
  const ResolveScreen({Key? key, required this.isFromObjectPage, required this.communityName, required this.objectName}) : super(key: key);
  final bool isFromObjectPage;
  final String communityName;
  final String objectName;

  @override
  State<ResolveScreen> createState() => ResolveData();
}

class ResolveData extends State<ResolveScreen> {

  final _formKey = GlobalKey<FormState>();
  String objectDropDown='';
  String resolveExpenseDropDown='';
  String resolveServiceDropDown='';
  bool isExpense=true;


  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);
    if(widget.isFromObjectPage){
        objectDropDown=widget.objectName;
      } else {
      objectDropDown=providerCommunity.communityObjectMap[widget.communityName]![providerCommunity.objectIndex];
    }
    Expense expense = providerCommunity.objectUnresolvedExpenseMap[objectDropDown]![providerCommunity.expenseIndex];
    resolveExpenseDropDown="${expense.creator} ₹${expense.amount} ${expense.description}";
    Service service = providerCommunity.objectUnresolvedServices[objectDropDown]![providerCommunity.serviceIndex];
    resolveServiceDropDown="${service.creator} ${service.description}";

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
                      providerCommunity.objectListen(widget.communityName, widget.objectName);
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

                  if(isExpense)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.check_circle_outline),
                        hintText: 'Object',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      value : resolveExpenseDropDown,
                      items: providerCommunity.objectUnresolvedExpenseMap[objectDropDown]!.map<DropdownMenuItem<String>>((Expense expense) {
                        return DropdownMenuItem<String>(
                          value: "${expense.creator} ₹${expense.amount} ${expense.description}",
                          child: Text("${expense.creator} ₹${expense.amount} ${expense.description}"),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          resolveExpenseDropDown = newValue!;
                        });
                        // var expenseAttributes = resolveExpenseDropDown.split(" ");
                        // String creator = expenseAttributes[0];
                        // int amount = int.parse(expenseAttributes[1].substring(1));
                        // String description = "";
                        // for(int i=2; i<expenseAttributes.length; i++){
                        //   description = description + " " + expenseAttributes[i];
                        // }
                        // print("creator: $creator, amount: $amount, description: $description");
                        Expense expense = providerCommunity.objectUnresolvedExpenseMap[objectDropDown]!.firstWhere((element) => "${element.creator} ₹${element.amount} ${element.description}"==resolveExpenseDropDown);
                        providerCommunity.expenseListen(expense);
                      },
                    ),
                  if(!isExpense)
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.check_circle_outline),
                        hintText: 'Object',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      value : resolveServiceDropDown,
                      items: providerCommunity.objectUnresolvedServices[objectDropDown]!.map<DropdownMenuItem<String>>((Service service) {
                        return DropdownMenuItem<String>(
                          value: "${service.creator} ${service.description}",
                          child: Text("${service.creator} ${service.description}"),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          resolveServiceDropDown = newValue!;
                        });
                        Service service = providerCommunity.objectUnresolvedServices[objectDropDown]!.firstWhere((element) => "${element.creator} ${element.description}"==resolveServiceDropDown);
                        providerCommunity.serviceListen(service);
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
                        onPressed: () {
                          if(isExpense){
                            Expense expense = providerCommunity.objectUnresolvedExpenseMap[objectDropDown]!.firstWhere((element) => "${element.creator} ₹${element.amount} ${element.description}"==resolveExpenseDropDown);
                            providerCommunity.resolveExpense(expense);
                          }
                          else{
                            Service service = providerCommunity.objectUnresolvedServices[objectDropDown]!.firstWhere((element) => "${element.creator} ${element.description}"==resolveServiceDropDown);
                            providerCommunity.resolveService(service);
                          }
                          Navigator.pop(context);
                        },
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
