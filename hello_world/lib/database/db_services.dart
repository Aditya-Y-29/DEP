import 'package:cloud_firestore/cloud_firestore.dart';

import './db_user.dart';
import '../Models/service.dart';


class ExpenseDataBaseService {
  final _db = FirebaseFirestore.instance;

  createService(ServiceModel service) async {
    try {

      final sp= await _db.collection('services').where("Name", isEqualTo: service.name).where("ObjectID", isEqualTo: service.objectID).get();

      if(sp.docs.isNotEmpty){
        print("Service Already exist for this Object");
        return false;
      }


      await _db.collection('services').add(service.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> getServiceID(ServiceModel service) async {
    try {
      final sp = await _db.collection('services').where("Name", isEqualTo: service.name).where("ObjectID", isEqualTo: service.objectID).get();

      if(sp.docs.isNotEmpty){
        return sp.docs.first.id;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> resolveService(ServiceModel service, String phoneNo) async {
    try {
      String? serviceID = await getServiceID(service);
      String? userID = await UserDataBaseService().getUserID(phoneNo);

      if(serviceID == null){
        print("Service does not exist");
        return false;
      }

      if(userID == null){
        print("User does not exist");
        return false;
      }

      await _db.collection('services').doc(serviceID).update({
        'Resolverid': userID,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
