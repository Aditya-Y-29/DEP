import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/objects.dart';
import '../Models/user.dart';
import '../Models/community.dart';
import './db_user.dart';

import 'package:http/http.dart' as http;

import 'db_objects.dart';

class CommunityDataBaseService {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> createCommunity(CommunityModel community) async {
    try {
      final sp1 = await _db
          .collection('communities')
          .where("Name", isEqualTo: community.name)
          .where("Phone Number", isEqualTo: community.phoneNo)
          .get();

      if (sp1.docs.isNotEmpty) {
        return false;
      }

      await _db.collection('communities').add(community.toJson());
      addUserInCommunity(community, community.phoneNo,true);
      // create misc object
      String? communityID = await getCommunityID(community);
      ObjectsModel object = ObjectsModel(
          name: "Misc",
          communityID: communityID,
          creatorPhoneNo: community.phoneNo,
          type: "",
          description: "");
      ObjectDataBaseService.createObjects(object);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String?> getCommunityID(CommunityModel community) async {
    try {
      final sp = await _db
          .collection('communities')
          .where("Name", isEqualTo: community.name)
          .where("Phone Number", isEqualTo: community.phoneNo)
          .get();

      if (sp.docs.isNotEmpty) {
        return sp.docs.first.id;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> addUserInCommunity(CommunityModel community, String memberPhoneNo,bool admin) async {
    try {
      String? communityID = await getCommunityID(community);
      String? userID = await UserDataBaseService.getUserID(memberPhoneNo);

      if (communityID == null) {
        return false;
      }

      if (userID == null) {
        return false;
      }

      final sp = await _db
          .collection('communityMembers')
          .where("CommunityID", isEqualTo: communityID)
          .where("UserID", isEqualTo: userID)
          .get();

      print("HELLO1");
      if (sp.docs.isNotEmpty) {
        return false;
      }
      print("HELLO2");


      await _db.collection('communityMembers').add({
        'CommunityID': communityID,
        'UserID': userID,
        'Is Admin':admin
      });
      return true;
      
    } catch (e) {
      return false;
    }
  }

  static Future<String> getCommunityName(String? communityID) async {
    try {
      final sp = await _db.collection('communities').doc(communityID).get();
      if (sp.data() == null) {
        return "";
      }
      return sp.data()!['Name'];
    } catch (e) {
      return "";
    }
  }

  static Future<bool> CommunityAddNotification(CommunityModel community, String phoneNo) async {

    String token= await UserDataBaseService.getUserToken(phoneNo);

    if(token==""){
      return false;
    }
    var data={
      'to':token.toString(),
      'priority':'high',
      'notification':{
        'title':'New Community Added',
        'body':'You have been added to ${community.name}'
      }
    };

    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body:jsonEncode(data),
      headers:{
        'Content-Type':'application/json; charset=UTF-8',
        'Authorization':'key=AAAAsXT8mZo:APA91bEjQMOMbx42wNSYYqsQsFQcQX3QEWrjeSVE0kKtvkxtoJrhhvJvqb2yCjPRHFlQQ05YZRkjgYkHJvNtO0O4n5b8w35-XMNQHda0Y_D7XPoF5oZWRN7U6HhmsymK7hEzK2qrms74'
      }
    );
    return true;
  }
}
