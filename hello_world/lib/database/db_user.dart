import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/Models/community.dart';
import '../Models/user.dart';

class UserDataBaseService {
  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
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

      if (sp1.docs.isNotEmpty) {
        print("Email ID already exists");
        return false;
      }
      if (sp2.docs.isNotEmpty) {
        print("Phone Number already exists");
        return false;
      }
      if (sp3.docs.isNotEmpty) {
        print("UserName already exists");
        return false;
      }

      await _db.collection('users').add(user.toJson());
      return true;
    } catch (e) {
      print(e);
    }
  }

  Future<UserModel?> getUser(String phoneNo) async {
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
      print(e);
      return null;
    }
  }

  Future<bool> updateUser(UserModel user) async {
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

  Future<String?> getUserID(String phoneNo) async {
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

  Future<List<CommunityModel>?> getCommunities(String phoneNo) async {
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
            communities.add(CommunityModel.fromJson(sp2.data()!));
          }
        }
      }
      return communities;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
