import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Models/community.dart';
import '../Models/user.dart';

class UserDataBaseService {
  static final _db = FirebaseFirestore.instance;

  static createUserDb(UserModel user) async {
    try {
      final sp1 = await _db
          .collection('users')
          .where("Email ID", isEqualTo: user.email)
          .get();
      final sp2 = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: user.phoneNo)
          .get();
      final sp3 = await _db
          .collection('users')
          .where("UserName", isEqualTo: user.username)
          .get();
      final sp4 = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: user.phoneNo)
          .get();

      if (sp1.docs.isNotEmpty) {
        return false;
      }
      if (sp2.docs.isNotEmpty) {
        return false;
      }
      if (sp3.docs.isNotEmpty) {
        return false;
      }

      await _db.collection('users').add(user.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<UserModel?> getUser(String phoneNo) async {
    try {
      final sp = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: phoneNo)
          .get();

      if (sp.docs.isNotEmpty) {
        return UserModel.fromJson(sp.docs.first.data());
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<bool> updateUser(UserModel user) async {
    try {
      final sp = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: user.phoneNo)
          .get();

      final sp1 = await _db
          .collection('users')
          .where("Email ID", isEqualTo: user.email)
          .get();

      final sp2 = await _db
          .collection('users')
          .where("UserName", isEqualTo: user.username)
          .get();

      if (sp.docs.isNotEmpty && sp1.docs.isEmpty && sp2.docs.isEmpty) {
        await _db
            .collection('users')
            .doc(sp.docs.first.id)
            .update(user.toJson());
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<String?> getUserID(String phoneNo) async {
    try {
      final sp = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: phoneNo)
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

  static Future<List<CommunityModel>?> getCommunities(String phoneNo) async {
    try {
      List<CommunityModel> communities = [];
      final sp = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: phoneNo)
          .get();
      if (sp.docs.isNotEmpty) {
        final sp1= await _db.collection('communityMembers').where("UserID", isEqualTo: sp.docs.first.id).get();
        if(sp1.docs.isNotEmpty){
          for(var i in sp1.docs){
            final sp2= await _db.collection('communities').doc(i.data()["CommunityID"]).get();
            if(sp2.data() == null) {
                continue;
              }
            communities.add(CommunityModel.fromJson(sp2.data()!));
            // print(sp2.data()!);
          }
        }
      }
      return communities;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<String> getName(String id) async{
    try{
      final sp= await _db.collection('users').doc(id).get();
      if(sp.exists){
        return sp.data()!["Name"];
      }
      return "";
    }catch(e){
      print(e);
      return "";
    }
  }

  static Future<String> getNameFromPhone(String phone) async {
    try {
      final sp = await _db
          .collection('users')
          .where("Phone Number", isEqualTo: phone)
          .get();
      if (sp.docs.isNotEmpty) {
        return sp.docs.first.data()["Name"];
      }
      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }

  static Future<List<dynamic>> getCommunityMembers(String communityName, String creatorPhone) async{
    try{
      List<dynamic> group=[];
      print(communityName);
      print(creatorPhone);
      String communityID="";
      final sp= await _db.collection('communities').where("Name", isEqualTo: communityName).where("Phone Number", isEqualTo: creatorPhone).get();
      if(sp.docs.isNotEmpty){
        final doc = sp.docs.first;
        communityID=doc.id;
        final sp1 = await _db.collection('communityMembers').where("CommunityID", isEqualTo: communityID).get();
        if(sp1.docs.isNotEmpty){
          for(var i in sp1.docs){
            final sp2= await _db.collection('users').doc(i.data()["UserID"]).get();
            print(sp2.data()!);
            var groupMember = {
              ...sp2.data()!,
              "Is Admin": i.data()["Is Admin"],
            };
            group.add(groupMember);
          }
        }
      }
      return group;
    }catch(e){
      print(e);
      return [];
    }
  }

  static Future<List<String>> getAllUserPhones() async {
    try {
      List<String> phones = [];
      final sp = await _db.collection('users').get();
      if (sp.docs.isNotEmpty) {
        for (var i in sp.docs) {
          phones.add(i.data()["Phone Number"]);
        }
      }
      return phones;
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<String> getUserToken(String phoneNo) async{
    try{
      final sp= await _db.collection('tokens').where("UserID", isEqualTo: await getUserID(phoneNo)).get();
      if(sp.docs.isNotEmpty){
        return sp.docs.first.data()["Token"];
      }
      return "";
    }catch(e){
      return "";
    }
  }

  static Future<bool> addToken(String phoneNo, String token) async{
    try{
      final sp= await _db.collection('tokens').where("UserID", isEqualTo: await getUserID(phoneNo)).get();
      if(sp.docs.isNotEmpty){
        await _db.collection('tokens').doc(sp.docs.first.id).update({"Token": token});
      }else{
        await _db.collection('tokens').add({"UserID": await getUserID(phoneNo), "Token": token});
      }
      return true;
    }catch(e){
      return false;
    }
  } 
}
