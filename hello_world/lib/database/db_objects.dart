import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Models/objects.dart';

import '../Models/expense.dart';
import '../Models/service.dart';

class ObjectDataBaseService {
  static final _db = FirebaseFirestore.instance;

  static createObjects( ObjectsModel object) async {
    try {
      if( object.communityID == null){
        print("CommunityID is null");
        return false;
      }

      final sp1 = await _db.collection("communities").doc(object.communityID).get();
      if(sp1.data() == null){
        print("Community does not exist");
        return false;
      }

      final sp2 = await _db
          .collection('objects')
          .where("Name", isEqualTo: object.name)
          .where("CommunityID", isEqualTo: object.communityID)
          .get();

      if (sp2.docs.isNotEmpty) {
        print("Object Already exist in this community");
        return false;
      }

      final sp3= await _db.collection("users").where("Phone Number", isEqualTo: object.creatorPhoneNo).get();
      if(sp3.docs.isEmpty){
        print("User does not exist");
        return false;
      }

      await _db.collection('objects').add(object.toJson());
      return true;
    } catch (e) {
      print(e);
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
      
      print( objectid);
      return expenses;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<ServiceModel>> getServices(ObjectsModel object) async {
    try {
      List<ServiceModel> services = [];
      String? objectid=await getObjectID(object);
      await _db
          .collection('services')
          .where("ObjectID", isEqualTo: objectid)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  services.add(ServiceModel.fromJson(element.data()));
                })
              });
      return services;
    } catch (e) {
      print(e);
      return [];
    }
  }
}