import 'package:cloud_firestore/cloud_firestore.dart';

import './db_user.dart';
import '../Models/expense.dart';
import '../Models/objectS.dart';


class ExpenseDataBaseService {
  final _db = FirebaseFirestore.instance;

  createExpense(ExpenseModel expense) async {
    try {

      final sp= await _db.collection('expenses').where("Name", isEqualTo: expense.name).where("ObjectID", isEqualTo: expense.objectID).get();

      if(sp.docs.isNotEmpty){
        print("Expense Already exist for this Object");
        return false;
      }


      await _db.collection('expenses').add(expense.toJson());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String?> getExpenseID(ExpenseModel expense) async {
    try {
      final sp = await _db.collection('expenses').where("Name", isEqualTo: expense.name).where("ObjectID", isEqualTo: expense.objectID).get();

      if(sp.docs.isNotEmpty){
        return sp.docs.first.id;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> resolveExpense(ExpenseModel expense, String phoneNo) async {
    try {
      String? expenseID = await getExpenseID(expense);
      String? userID = await UserDataBaseService().getUserID(phoneNo);

      if(expenseID == null){
        print("Expense does not exist");
        return false;
      }

      if(userID == null){
        print("User does not exist");
        return false;
      }

      await _db.collection('expenses').doc(expenseID).update({
        'Resolverid': userID,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}
