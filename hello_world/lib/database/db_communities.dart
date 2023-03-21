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
        print("Community Already exist for this user");
        return false;
      }

      await _db.collection('communities').add(community.toJson());
      addUserInCommunity(community, community.phoneNo, true);
      return true;
    } catch (e) {
      print(e);
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
      print(e);
      return null;
    }
  }

  static Future<bool> addUserInCommunity(CommunityModel community, String memberPhoneNo, bool isCreator) async {
    try {
      String? communityID = await getCommunityID(community);
      String? userID = await UserDataBaseService.getUserID(memberPhoneNo);

      if (communityID == null) {
        print("Community does not exist");
        return false;
      }

      if (userID == null) {
        print("User does not exist");
        return false;
      }

      final sp = await _db
          .collection('communityMembers')
          .where("CommunityID", isEqualTo: communityID)
          .where("UserID", isEqualTo: userID)
          .get();

      if (sp.docs.isNotEmpty) {
        print("User already exist in this community");
        return false;
      }


      await _db.collection('communityMembers').add({
        'CommunityID': communityID,
        'UserID': userID,
        'isCreator': isCreator,
      });
      return true;
      
    } catch (e) {
      print("Error in adding user in community");
      return false;
    }
  }

}
