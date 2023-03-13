import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/Models/community.dart';
import 'package:hello_world/Models/objects.dart';
import 'package:hello_world/Models/user.dart';

import './db_user.dart';
import './db_communities.dart';
import './db_objects.dart';

class LandingPage1 extends StatefulWidget {
  const LandingPage1({Key? key}) : super(key: key);

  @override
  _LandingPageState1 createState() => _LandingPageState1();
}

class _LandingPageState1 extends State<LandingPage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:  const BoxDecoration(
          gradient: LinearGradient(
            colors:  [Color.fromRGBO(67, 18, 214, 1), Color.fromRGBO(84, 161, 224, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the app',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sign up to get started',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                  // UserModel user= UserModel(name: "Akshat Toolaj Sinha", username: "Akshat017", email: "akshatsinha172@gmail.com", phoneNo: "82798335510");
                  // await UserDataBaseService().createUser(user);

                  // UserModel? res= await UserDataBaseService().getUser("123456780");
                  // if( res != null){
                  //   print(res.name);
                  //   print(res.username);
                  //   print(res.email);
                  //   print(res.phoneNo);
                  // }
                  // else{
                  //   print("User not found");
                  // }

                  // String? res= await UserDataBaseService().getUserID("234567890");
                  // print( res );

                  // CommunityModel community= CommunityModel(name: "Community 2", phoneNo: "1234567890");
                  // // await CommunityDataBaseService().createCommunity(community);

                  // CommunityDataBaseService().addUserInCommunity(community, "82798335510");

                  // List<CommunityModel>? res= await UserDataBaseService().getCommunities("1234567890");

                  // if( res != null){
                  //   for( CommunityModel community in res){
                  //     print(community.name);
                  //     print(community.phoneNo);
                  //   }
                  // }
                  // else{
                  //   print("User not found");
                  // }
                  // String? res= await CommunityDataBaseService().getCommunityID(CommunityModel(name: "Community 1", phoneNo: "8279833510"));
                  
                  // // ObjectsModel object= ObjectsModel(communityID: res, creatorPhoneNo: "8279833510", name: "Object 1", type: "Type 1", description: "Description 1");
                  // // await ObjectDataBaseService().createObjects(object);

                  // List<ObjectsModel>? res1= await ObjectDataBaseService().getObjects(res);

                  // if( res1 != null){
                  //   for( ObjectsModel object in res1){
                  //     print(object.name);
                  //     print(object.type);
                  //     print(object.description);
                  //   }
                  // }
                  // else{
                  //   print("User not found");
                  // }

                  

              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}