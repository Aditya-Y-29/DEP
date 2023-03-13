import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Models/objects.dart';

class ObjectDataBaseService {
  final _db = FirebaseFirestore.instance;

  createObjects( ObjectsModel object) async {
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
  
  Future<String?> getObjectID(ObjectsModel object) async {
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

  Future<List<ObjectsModel>?> getObjects( String? communityID) async {

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

}