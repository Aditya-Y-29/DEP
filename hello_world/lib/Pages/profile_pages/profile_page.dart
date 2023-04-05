import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key }) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    countryController.text = " +91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(top: 3),
                    // height: kSpacingUnit.w * 18,
                    // width: kSpacingUnit.w * 18,
                    // margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 75,
                          // radius: kSpacingUnit.w * 10,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 32,
                            width: 32,
                            // height: kSpacingUnit.w * 4,
                            // width: kSpacingUnit.w * 5,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              heightFactor: 2,
                              widthFactor: 2,
                              // heightFactor: kSpacingUnit.w * 1.5,
                              // widthFactor: kSpacingUnit.w * 1.5,

                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: kSpacingUnit.w * 2),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.person,
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text("${providerCommunity.user?.username}",
                              style: TextStyle(fontSize: 16)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.mail,
                          ),
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text("${providerCommunity.user?.email}",
                              style: TextStyle(fontSize: 16)
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 40,
                            child:  Text(
                                " +91",
                                style: TextStyle(fontSize: 16)
                            )
                        ),
                        Text(
                          "|",
                          style: TextStyle(fontSize: 33, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Text(
                                "${providerCommunity.user?.phoneNo}",
                                style: TextStyle(fontSize: 16)
                            )
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          providerCommunity.deleteState();
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                        },
                        child: Text("Log Out", style: TextStyle(fontSize: 15)),
                      )
                  )       //
                ],
              )
          ),
        )
    );
  }
}