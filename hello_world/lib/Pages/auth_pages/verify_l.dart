import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Pages/auth_pages/phone.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/data_provider.dart';

class MyVerifyL extends StatefulWidget {
  const MyVerifyL({Key? key}) : super(key: key);
  @override
  State<MyVerifyL> createState() => _MyVerifyLState();
}

class _MyVerifyLState extends State<MyVerifyL> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    var code="";

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

        body: Consumer<DataProvider>(
            builder: (context, objectDataProvider, child) {
              return Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/img1.png',
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Phone Verification",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Enter Your OTP",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Pinput(
                        onChanged: (value){
                          code=value;
                        },
                        length: 6,


                        showCursor: true,
                        onCompleted: (pin) => print(pin),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade600,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              try{
                                // Create a PhoneAuthCredential with the code
                                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                                print("Code: $code");

                                await auth.signInWithCredential(credential);
                                // ignore: use_build_context_synchronously
                                DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);

                                var sharedPref = await SharedPreferences.getInstance();
                                sharedPref.setString("userPhone", MyPhone.phoneNo);

                                await dataProvider.getAllDetails(MyPhone.phoneNo);

                                if(dataProvider.user==null){
                                  return;
                                }
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                              }
                              catch(e){
                                // modified to show error message
                                if(e.toString().contains("invalid-verification-code")){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Wrong OTP"),
                                      duration: Duration(seconds: 5),
                                    ),
                                  );
                                  return;
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Something went wrong"),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                              }
                            },
                            child: Text("Verify Phone Number")),
                      ),
                      // Row(
                      //   children: [
                      //     TextButton(
                      //         onPressed: () {
                      //           Navigator.pushNamedAndRemoveUntil(
                      //             context,
                      //             'phone',
                      //                 (route) => false,
                      //           );
                      //         },
                      //         child: Text(
                      //           "Edit Phone Number ?",
                      //           style: TextStyle(color: Colors.black),
                      //         )
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
              );
            }
        ));
  }
}