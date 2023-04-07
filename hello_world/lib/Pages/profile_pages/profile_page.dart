import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../components/chart.dart';
import '../../components/spendingSummary.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key }) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController countryController = TextEditingController();


  // Map<String,double> dataMap= {};

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
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.only(top: 3),
                    // height: kSpacingUnit.w * 18,
                    // width: kSpacingUnit.w * 18,
                    // margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60,
                          // radius: kSpacingUnit.w * 10,
                          backgroundImage: AssetImage('assets/images/avatar.png'),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 30,
                            width: 30,
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
                                size: 18,
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
                    height: 0,
                  ),
                  SizedBox(
                    height: 280,
                    width: 310,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                        margin: EdgeInsets.only(top: 10.0,bottom: 10),
                      padding: EdgeInsets.only(top:22.0,bottom: 15.0,left: 10.0,right: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // margin: EdgeInsets.only(top: 0.0, left: 0),
                                  child: Center(

                                    child: MySpendingSummary(),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Expanded(
                                child:
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 20, left: 10),
                                          child: MyPieChart(),
                                        ),
                                      ],
                                    ),
                                  ),
                              )
                            ),
                          ],
                        ),
                      )
                    // child: Container(
                    //   child: Center(
                    //
                    //     child: MyPieChart(),
                    //   ),
                    // ),
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade600,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          var sharedPref = await SharedPreferences.getInstance();
                          sharedPref.setString("userPhone", "");
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