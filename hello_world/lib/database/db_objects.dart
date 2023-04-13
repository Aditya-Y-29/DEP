import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Models/objects.dart';

import '../Models/expense.dart';
import './db_communities.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ObjectDataBaseService {
  static final _db = FirebaseFirestore.instance;

  static Future<bool> createObjects( ObjectsModel object) async {
    try {
      if( object.communityID == null){
        return false;
      }

      final sp1 = await _db.collection("communities").doc(object.communityID).get();
      if(sp1.data() == null){
        return false;
      }

      final sp2 = await _db
          .collection('objects')
          .where("Name", isEqualTo: object.name)
          .where("CommunityID", isEqualTo: object.communityID)
          .get();

      if (sp2.docs.isNotEmpty) {
        return false;
      }

      final sp3= await _db.collection("users").where("Phone Number", isEqualTo: object.creatorPhoneNo).get();
      if(sp3.docs.isEmpty){
        return false;
      }

      await _db.collection('objects').add(object.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }
  
  static Future<String?> getObjectID(ObjectsModel object) async {
    try {
      final sp = await _db
          .collection('objects')
          .where("Name", isEqualTo: object.name)
          .where("CommunityID", isEqualTo: object.communityID)
          .get();

      if (sp.docs.isNotEmpty) {
        return sp.docs.first.id;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<ObjectsModel>?> getObjects( String? communityID) async {

    if( communityID == null){
      print("CommunityID is null");
      return null;
    }

    try{
    List<ObjectsModel> objects = [];
    await _db.collection('objects').where("CommunityID", isEqualTo: communityID).get().then((value) => {
      value.docs.forEach((element) {
        objects.add(ObjectsModel.fromJson(element.data()));
      })
    });
    return objects;
    }
    catch(e){
      print(e);
      return null;
    }
  }

  static Future<List<ExpenseModel>> getExpenses(ObjectsModel object) async {
    try {
      List<ExpenseModel> expenses = [];
      String? objectid=await getObjectID(object);
      await _db
          .collection('expenses')
          .where("ObjectID", isEqualTo: objectid)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  expenses.add(ExpenseModel.fromJson(element.data()));
                })
              });
      return expenses;
    } catch (e) {
      print(e);
      return [];
    }
  }



  static Future<List<String>> getTokens(String? CommunityID) async{

    List<String> userID=[];
    await _db.collection("communityMembers").where("CommunityID", isEqualTo: CommunityID)
    .get()
    .then( (value)=>{
      value.docs.forEach((element) {
        userID.add(element.data()['UserID']);
        })
      }
    );

    List<String> tokens=[];
    for(var id in userID){
      await _db.collection("tokens").where("UserID", isEqualTo: id).get()
      .then((value) => {
        value.docs.forEach((element) {
          tokens.add(element.data()['Token']);
        })
      });
    }


    return tokens;
  }

  static Future<bool> ObjectAddNotification(ObjectsModel object) async {

    List<String> tokens= await getTokens(object.communityID);

    String communityName= await CommunityDataBaseService.getCommunityName(object.communityID);

    for( var token in tokens){
        
      var data={
        'to':token.toString(),
        'priority':'high',
        'notification':{
          'title':'Object Added in ${communityName}',
          'body':'${object.name} has been added in ${communityName}'
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
    }

    return true;
  }

  static Future<String> getCommunityID(String? objectID) async{
    String communityID="";
    await _db.collection("objects").doc(objectID).get().then((value) => {
      communityID=value.data()!['CommunityID']
    });
    return communityID;
  }

  static Future<String> getObjectName(String? objectID) async{
    String objectName="";
    await _db.collection("objects").doc(objectID).get().then((value) => {
      objectName=value.data()!['Name']
    });
    return objectName;
  }

  static Future<bool> deleteObject( ObjectsModel object) async{
    
    String? objectID=await getObjectID(object);

    await _db.collection("objects").doc(objectID).delete();

    await _db.collection("expenses").where("ObjectID", isEqualTo: objectID).get().then((value) => {
      value.docs.forEach((element) {
        _db.collection("expenses").doc(element.id).delete();
      })
    });

    return true;
  }
}