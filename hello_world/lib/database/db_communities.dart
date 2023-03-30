import 'package:cloud_firestore/cloud_firestore.dart';
import '../Models/user.dart';
import '../Models/community.dart';
import './db_user.dart';

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

}
