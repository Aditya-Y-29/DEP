import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/member.dart';
import 'package:hello_world/components/service.dart';

import '../Models/user.dart';
import '../Models/community.dart';
import '../Models/objects.dart';
import '../Models/expense.dart';
import '../Models/service.dart';

import '../database/db_user.dart';
import '../database/db_communities.dart';
import '../database/db_objects.dart';
import '../database/db_expenses.dart';
import '../database/db_services.dart';

class DataProvider extends ChangeNotifier {

  int communitiesIndex = 0;
  int objectIndex = 0;
  int expenseIndex = 0;
  // int serviceIndex = 0;

  UserModel? user;
  List<String> allUserPhones = [];
  Map<String, List<Member>> communityMembersMap = {};
  
  List<CommunityModel>? communitiesdb = [];
  Map<CommunityModel, List<ObjectsModel>>? communityObjectMapdb = {};
  Map<CommunityModel, Map<ObjectsModel, List<ExpenseModel>>>? objectUnresolvedExpenseMapdb = {};
  Map<CommunityModel, Map<ObjectsModel, List<ExpenseModel>>>? objectResolvedExpenseMapdb = {};

  List<String> communities = [];
  Map<String, List<String>> communityObjectMap = {};
  Map<String, Map<String, List<Expense>>> objectUnresolvedExpenseMap = {};
  Map<String, Map<String, List<Expense>>> objectResolvedExpenseMap = {};

  void checkuser(String phoneNo) async {
    user = await UserDataBaseService.getUser(phoneNo);
  }

  void getCommunityMembers(String phone) async {
    List<CommunityModel>? communityList =
        await UserDataBaseService.getCommunities(phone);
    for (int i = 0; i < communityList!.length; i++) {
      // print("goin thru communities");
      List<Member> memberList = [];
      List<dynamic>? group = await UserDataBaseService.getCommunityMembers(
          communityList[i].name, communityList[i].phoneNo);
      for (int j = 0; j < group.length; j++) {
        memberList.add(Member(
          name: group[j]["Name"],
          phone: group[j]["Phone Number"],
          isCreator: group[j]["Is Admin"],
        ));
      }
      communityMembersMap[communityList[i].name] = memberList;
    }
    notifyListeners();
  }

  void getAllUserPhones() async {
    List<String> phones = await UserDataBaseService.getAllUserPhones();
    allUserPhones = phones;
    notifyListeners();
  }

  Future<void> getAllDetails(String phoneNo) async {
    String name = await UserDataBaseService.getNameFromPhone(phoneNo);

    deleteState();
    checkuser(phoneNo);
    List<CommunityModel>? communityTemp =
        await UserDataBaseService.getCommunities(phoneNo);
    communitiesdb = communityTemp;

    for (int i = 0; i < communityTemp!.length; i++) {
      communities.add(communityTemp[i].name);
      communityObjectMap[communityTemp[i].name] = [];
      communityObjectMapdb![communityTemp[i]] = [];

      objectUnresolvedExpenseMap[communityTemp[i].name] = {};
      objectUnresolvedExpenseMapdb![communityTemp[i]] = {};

      objectResolvedExpenseMap[communityTemp[i].name] = {};
      objectResolvedExpenseMapdb![communityTemp[i]] = {};

      communityMembersMap[communityTemp[i].name] = [];

    }
    getAllUserPhones();
    getCommunityMembers(phoneNo);
    for (int i = 0; i < communityTemp.length; i++) {
      String? communityID =
          await CommunityDataBaseService.getCommunityID(communityTemp[i]);
      List<ObjectsModel>? objectTemp =
          await ObjectDataBaseService.getObjects(communityID!);

      for (int j = 0; j < objectTemp!.length; j++) {
        communityObjectMap[communityTemp[i].name]!.add(objectTemp[j].name);
        communityObjectMapdb![communityTemp[i]]!.add(objectTemp[j]);


        objectUnresolvedExpenseMap[communityTemp[i].name]![objectTemp[j].name] =
            [];
        objectUnresolvedExpenseMapdb![communityTemp[i]]![objectTemp[j]] = [];


        objectResolvedExpenseMap[communityTemp[i].name]![objectTemp[j].name] =
            [];
        objectResolvedExpenseMapdb![communityTemp[i]]![objectTemp[j]] = [];

        List<ExpenseModel>? expenseTemp =
            await ObjectDataBaseService.getExpenses(objectTemp[j]);

        for (int k = 0; k < expenseTemp.length; k++) {
          if (expenseTemp[k].resolverid == null) {
            objectUnresolvedExpenseMap[communityTemp[i].name]![
                    objectTemp[j].name]!
                .add(Expense(
              communityName: communityTemp[i].name,
              objectName: objectTemp[j].name,
              creator:
                  await UserDataBaseService.getName(expenseTemp[k].creatorID!),
              description: expenseTemp[k].name,
              isPaid: false,
              amount: int.parse(expenseTemp[k].amount),
            ));

            objectUnresolvedExpenseMapdb![communityTemp[i]]![objectTemp[j]]!
                .add(expenseTemp[k]);
          } else {
            objectResolvedExpenseMap[communityTemp[i].name]![
                    objectTemp[j].name]!
                .add(Expense(
              communityName: communityTemp[i].name,
              objectName: objectTemp[j].name,
              creator:
                  await UserDataBaseService.getName(expenseTemp[k].creatorID!),
              description: expenseTemp[k].name,
              isPaid: true,
              amount: int.parse(expenseTemp[k].amount),
            ));

            objectResolvedExpenseMapdb![communityTemp[i]]![objectTemp[j]]!
                .add(expenseTemp[k]);
          }
        }
      }
    }

    notifyListeners();
  }

  void deleteState() {
    user = null;
    allUserPhones = [];
    communityMembersMap = {};

    communitiesdb = [];
    objectUnresolvedExpenseMapdb = {};
    objectResolvedExpenseMapdb = {};
    communityObjectMapdb = {};

    communities = [];
    communityObjectMap = {};
    objectUnresolvedExpenseMap = {};
    objectResolvedExpenseMap = {};

    // notifyListeners();
  }

  void communityListen(String communityName) {
    communitiesIndex = communities.indexOf(communityName);
    notifyListeners();
  }

  void objectListen(String communityName, String objectName) {
    objectIndex = communityObjectMap[communityName]!.indexOf(objectName);
    notifyListeners();
  }

  void expenseListen(Expense expense) {
    expenseIndex =
        objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]!
            .indexOf(expense);
    notifyListeners();
  }

  void addCommunity(String communityName) {
    communities.add(communityName);
    communityObjectMap[communityName] = [];
    objectUnresolvedExpenseMap[communityName] = {};
    objectResolvedExpenseMap[communityName] = {};
    communityMembersMap[communityName] = [];
    communityMembersMap[communityName]!
        .add(Member(name: user!.name, phone: user!.phoneNo, isCreator: true));
    notifyListeners();

    CommunityModel community = CommunityModel(
      name: communityName,
      phoneNo: user!.phoneNo,
    );
    CommunityDataBaseService.createCommunity(community);
    communitiesdb!.add(community);
    notifyListeners();
  }

  Future<void> addObject(String communityName, String objectName) async {
    communityObjectMap[communityName]!.add(objectName);
    objectUnresolvedExpenseMap[communityName]![objectName] = [];
    objectResolvedExpenseMap[communityName]![objectName] = [];

    notifyListeners();
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    String? communityID = await CommunityDataBaseService.getCommunityID(ctmp);
    ObjectsModel object = ObjectsModel(
        name: objectName,
        communityID: communityID,
        creatorPhoneNo: user!.phoneNo,
        type: "",
        description: "");
    communityObjectMapdb![ctmp]!.add(object);
    ObjectDataBaseService.createObjects(object);
  }

  Future<void> addExpense(String objectName, String creator, int amount,
      String description, String communityName) async {
    objectUnresolvedExpenseMap[communityName]![objectName]?.add(Expense(
        objectName: objectName,
        creator: creator,
        amount: amount,
        description: description,
        isPaid: false,
        communityName: communityName));

    notifyListeners();
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    ObjectsModel otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == objectName);
    String? objectID = await ObjectDataBaseService.getObjectID(otmp);
    // print(objectID);
    ExpenseModel expense = ExpenseModel(
        creatorID: await UserDataBaseService.getUserID(user!.phoneNo),
        amount: amount.toString(),
        name: description,
        objectID: objectID,
        resolverid: null,
        description: "",
        date: null);
    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expense);

    ExpenseDataBaseService.createExpense(expense);
    notifyListeners();
  }

  void resolveExpense(Expense expense) {
    Expense? item =
        objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]
            ?.firstWhere((element) =>
                element.objectName == expense.objectName &&
                element.creator == expense.creator &&
                element.amount == expense.amount &&
                element.description == expense.description);
    objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]
        ?.remove(item);
    objectResolvedExpenseMap[expense.communityName]![expense.objectName]?.add(
        Expense(
            objectName: expense.objectName,
            creator: expense.creator,
            amount: expense.amount,
            description: expense.description,
            isPaid: true,
            communityName: expense.communityName));
    notifyListeners();

    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == expense.communityName);
    ObjectsModel? otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == expense.objectName);
    ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!
        .firstWhere((element) => element.name == expense.description);

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

    rtmp.resolverid = user!.phoneNo;
    objectResolvedExpenseMapdb![ctmp]![otmp]!.add(rtmp);
    ExpenseDataBaseService.resolveExpense(rtmp, user!.phoneNo);
  }

  addMembersToCommunity(String communityName, List<dynamic> names,
      List<dynamic> phones, String phoneNo) {
    for (int i = 0; i < names.length; i++) {
      Member member = Member(
        name: names[i],
        phone: phones[i],
        isCreator: false,
      );
      if (!communityMembersMap[communityName]!.contains(member)) {
        communityMembersMap[communityName]!.add(member);
        CommunityModel ctmp = communitiesdb!
            .firstWhere((element) => element.name == communityName);
        CommunityDataBaseService.addUserInCommunity(ctmp, member.phone, false);
      }
      // CommunityModel community =
      //     CommunityModel(name: communityName, phoneNo: phoneNo);
      // CommunityDataBaseService.addUserInCommunity(
      //     community, member.phone, false);
    }
    notifyListeners();
  }
}
