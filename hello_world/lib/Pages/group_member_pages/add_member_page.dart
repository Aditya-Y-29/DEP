import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:hello_world/Pages/auth_pages/phone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../provider/data_provider.dart';
import 'community_info_page.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key, required this.creatorTuple}) : super(key: key);
  final String creatorTuple;

  @override
  State<AddMembers> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMembers> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;
  var selectedContacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (await Permission.contacts.request().isGranted) {
      setState(() => _permissionDenied = false);
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
    }
    else {
      setState(() => _permissionDenied = true);
    }
  }

  @override
  Widget build(BuildContext context) {

    if(_contacts == null) return Center(child: CircularProgressIndicator(),);
    final providerCommunity = Provider.of<DataProvider>(context, listen: true);
    List<Contact> contactsOnPlatform = [];
    for (var i = 0; i < _contacts!.length; i++) {
      for( var j = 0; j < providerCommunity.allUserPhones.length; j++){
        if(_contacts![i].phones.isNotEmpty){
          String phone = _contacts![i].phones.first.number.toString().replaceAll(' ', '');
          // only Indian country code
          if(phone.startsWith('+91')) {
            phone = phone.substring(3);
          }
          _contacts![i].phones.first.number = phone;
          bool inComm = false;
          for(var k = 0; k < providerCommunity.communityMembersMap[widget.creatorTuple]!.length; k++){
            String memberPhone = providerCommunity.communityMembersMap[widget.creatorTuple]![k].phone.toString().replaceAll(' ', '');
            if(memberPhone.startsWith('+91')) {
              memberPhone = memberPhone.substring(3);
            }
            if(phone == memberPhone) {
              inComm = true;
              break;
            }
          }
          if(!inComm && phone == providerCommunity.allUserPhones[j].toString()) {
            contactsOnPlatform.add(_contacts![i]);
          }
        }
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Members'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _body(contactsOnPlatform, providerCommunity),
    );
  }

  Widget _body(contactsOnPlatform, providerCommunity) {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (contactsOnPlatform == null) return Center(child: CircularProgressIndicator());
    if (contactsOnPlatform.isEmpty) return Center(child: Text('No new contacts found on UtilMan!'));

    Future<bool> showAddMemberDialog(BuildContext context) async {
      bool? confirm = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Add Member'),
            content: Text('Are you sure you want to add?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
      return confirm ?? false;
    }
    return Container(
      child: Column(
          children: [
            Container(
              height: selectedContacts.isEmpty ? 0 : 100,
              child:
              ListView(
                scrollDirection: Axis.horizontal,
                children: List.of(
                  selectedContacts.map(
                        (contact) => Container(
                      margin: const EdgeInsets.all(0.0),
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 30,
                        child: Text(contact.name.first, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    child:ListView.builder(
                        itemCount: contactsOnPlatform!.length,
                        itemBuilder: (context, i) =>
                            Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 2.0,
                                  ),
                                ),
                                margin: const EdgeInsets.only(top: 5,right: 5,left: 5),
                                padding: const EdgeInsets.all(0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(contactsOnPlatform![i].displayName[0]),
                                  ),
                                  title: Text(contactsOnPlatform![i].displayName),
                                  subtitle: Text(contactsOnPlatform![i].phones.length > 0 ? contactsOnPlatform![i].phones.first.number : '(none)'),
                                  trailing: Checkbox(
                                    value: selectedContacts.contains(contactsOnPlatform![i]),
                                    onChanged: (value) {
                                      if (value == true) {
                                        setState(() {
                                          selectedContacts.add(contactsOnPlatform![i]);
                                        });
                                      } else {
                                        setState(() {
                                          selectedContacts.remove(contactsOnPlatform![i]);
                                        });
                                      }
                                    },
                                  ),
                                )
                            )

                    )
                ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 50.0, top: 10),
              child:
              FloatingActionButton.extended(
                  heroTag:"BTN-3",
                  onPressed: () async {
                    Future<bool> returnValue= showAddMemberDialog(context);
                    bool alertResponse = await returnValue;
                    if(alertResponse==true){
                      var selectedNames = selectedContacts.map((contact) => contact.name.first).toList();
                      var selectedPhones = selectedContacts.map((contact) => contact.phones.first.number).toList();
                      providerCommunity.addMembersToCommunity(widget.creatorTuple, selectedNames, selectedPhones, MyPhone.phoneNo);
                      Navigator.pop(context);
                    }
                  },
                  label: Row(
                    children: const [
                      Text("Add Members",style: TextStyle(fontSize: 17),),
                    ],
                  )
              ),
            ),
          ]
      ),
    );
  }
}