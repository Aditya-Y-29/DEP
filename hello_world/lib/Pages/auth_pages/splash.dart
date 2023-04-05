import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/data_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  static const KEYLOGIN = "Login";

  @override
  void initState() {
    super.initState();

    whereToGo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade200,
        child:
        Center(
          child: Container(
            margin: EdgeInsets.only(left: 25, right: 25),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.green.shade100,
              border: Border.all(color: Colors.green, width: 2)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.home_filled,
                  size: 45,
                  color: Colors.green,),
                Text(
                  "UtilMan",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          )
        ),
      )
    );
  }

  void whereToGo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var userPhone = sharedPref.getString("userPhone") ?? "";
    Timer(Duration(seconds: 2), () async {
      if (userPhone != "") {
        DataProvider dataProvider = Provider.of<DataProvider>(context, listen: false);
        await dataProvider.getAllDetails(userPhone);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}
