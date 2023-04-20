import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/member.dart';
import 'package:collection/collection.dart';

// import 'package:hello_world/components/service.dart';

import '../Models/user.dart';
import '../Models/community.dart';
import '../Models/objects.dart';
import '../Models/expense.dart';
// import '../Models/service.dart';

import '../database/db_user.dart';
import '../database/db_communities.dart';
import '../database/db_objects.dart';
import '../database/db_expenses.dart';
// import '../database/db_services.dart';

import 'package:hello_world/Notifications/notification_services.dart';

class DataProvider extends ChangeNotifier {
  int communitiesIndex = 0;
  int objectIndex = 0;
  int expenseIndex = 0;

  UserModel? user;
  List<String> allUserPhones = [];
  Map<String, List<Member>> communityMembersMap = {};

  List<CommunityModel>? communitiesdb = [];
  Map<CommunityModel, List<ObjectsModel>>? communityObjectMapdb = {};
  Map<CommunityModel, Map<ObjectsModel, List<ExpenseModel>>>?objectUnresolvedExpenseMapdb = {};

  List<String> communities = [];
  Map<String, List<String>> communityObjectMap = {};
  Map<String, Map<String, List<Expense>>> objectUnresolvedExpenseMap = {};



  void checkuser(String phoneNo) async {
    user = await UserDataBaseService.getUser(phoneNo);
  }

  //***********************************************
  // Images for common names

  Map<String, String> communityNameToImagePath = {
    "Home": "assets/images/communityImages/Home.jpg",
    "Office": "assets/images/communityImages/Office.png",
    "Shop":"assets/images/communityImages/Shop.jpg",
    "Mess":"assets/img1.png",
    // "Work":"assets/images/communityImages/Work.png",
    // "Lab":"assets/images/communityImages/Lab.jpg",
    // "Friends":"assets/images/communityImages/Friends.jpg",
    // "Family":"assets/images/communityImages/Family.jpg",
    // "Trip":"assets/images/communityImages/Trip.jpg",
    // "Apartment":"assets/images/communityImages/Apartment.jpg",
    // "Test":"assets/images/communityImages/Test.jpg",
    // "Myself":"assets/images/communityImages/Myself.jpg",
    // "Me":"assets/images/communityImages/Me.jpg",
    // "Couple":"assets/images/communityImages/Couple.jpg",
    //"Hospital":"assets/images/communityImages/Hospital.jpg",
    "Default":"assets/images/communityImages/Default.jpg",
  };

  Map<String, String> objectNameToImagePath = {
    "Car": "assets/images/objectImages/Car.png",
    "furniture": "assets/images/objectImages/Car.png",
    // "Office": "assets/images/communityImages/Office.png",
    // "Shop":"assets/images/communityImages/Shop.jpg",
    // "Work":"assets/images/communityImages/Work.jpg",
    // "Lab":"assets/images/communityImages/Lab.jpg",
    // "Friends":"assets/images/communityImages/Friends.jpg",
    // "Family":"assets/images/communityImages/Family.jpg",
    // "Trip":"assets/images/communityImages/Trip.jpg",
    // "Apartment":"assets/images/communityImages/Apartment.jpg",
    // "Test":"assets/images/communityImages/Test.jpg",
    // "Myself":"assets/images/communityImages/Myself.jpg",
    // "Me":"assets/images/communityImages/Me.jpg",
    // "Couple":"assets/images/communityImages/Couple.jpg",
    "Default": "assets/images/objectImages/Car.jpg",
  };

  //***********************************************

  bool isSubstring(String s, String t) {
    if (s.isEmpty) return true;
    if (t.isEmpty) return false;
    if (t.length < s.length) return false;

    for (int i = 0; i <= t.length - s.length; i++) {
      if (t.substring(i, i + s.length) == s) {
        return true;
      }
    }
    return false;
  }

  String extractCommunityImagePathByName(String communityName) {
    for (String key in communityNameToImagePath.keys) {
      String value = communityNameToImagePath[key]!;
      if (isSubstring(key.toLowerCase(), communityName.toLowerCase())) {
        return value;
      }
    }
    return communityNameToImagePath["Default"]!;
  }

  String extractObjectImagePathByName(String objectName) {
    for (String key in objectNameToImagePath.keys) {
      String value = objectNameToImagePath[key]!;
      if (isSubstring(key.toLowerCase(), objectName.toLowerCase())) {
        return value;
      }
    }
    return communityNameToImagePath["Default"]!;
  }

  int communityTotalExpense(String communityName) {
    int sum = 0;
    for (int i = 0; i < communityObjectMap[communityName]!.length; i++) {
      for (int j = 0;
          j <
              objectUnresolvedExpenseMap[communityName]![
                      communityObjectMap[communityName]![i]]!
                  .length;
          j++) {
        sum += objectUnresolvedExpenseMap[communityName]![
                communityObjectMap[communityName]![i]]![j]
            .amount;
      }
    }
    return sum;
  }

  Future<int> totalExpense() async {
    int sum = 0;
    List<CommunityModel>? communityList =
        await UserDataBaseService.getCommunities(user!.phoneNo);
    communityList!.forEach((element) {
      String communityName = element!.name;
      sum += communityTotalExpense(communityName);
    });
    return sum;
  }

  Future<int> myTotalExpense() async {
    int sum = 0;
    List<CommunityModel>? communityList =
        await UserDataBaseService.getCommunities(user!.phoneNo);
    communityList!.forEach((element) {
      String communityName = element!.name;
      sum += myExpenseInCommunity(communityName);
    });
    return sum;
  }

  Future<Map<int, int>> spendingSummaryData() async {
    Map<int, int> spendingSummary = {};
    spendingSummary[0] = await myTotalExpense();
    spendingSummary[1] = await totalExpense();
    return spendingSummary;
  }

  int myExpenseInCommunity(String communityName) {
    int sum = 0;
    for (int i = 0; i < communityObjectMap[communityName]!.length; i++) {
      for (int j = 0;
          j <
              objectUnresolvedExpenseMap[communityName]![
                      communityObjectMap[communityName]![i]]!
                  .length;
          j++) {
        if (user!.name ==
            objectUnresolvedExpenseMap[communityName]![
                    communityObjectMap[communityName]![i]]![j]
                .creator) {
          sum += objectUnresolvedExpenseMap[communityName]![
                  communityObjectMap[communityName]![i]]![j]
              .amount;
        }
      }
    }
    return sum;
  }

  int objectTotalExpense(String communityName, String objectName) {
    int sum = 0;
    for (int j = 0;
        j < objectUnresolvedExpenseMap[communityName]![objectName]!.length;
        j++) {
      sum += objectUnresolvedExpenseMap[communityName]![objectName]![j].amount;
    }
    return sum;
  }

  int myExpenseInObject(String communityName, String objectName) {
    int sum = 0;
    for (int j = 0;
        j < objectUnresolvedExpenseMap[communityName]![objectName]!.length;
        j++) {
      if (user!.name ==
          objectUnresolvedExpenseMap[communityName]![objectName]![j].creator) {
        sum +=
            objectUnresolvedExpenseMap[communityName]![objectName]![j].amount;
      }
    }
    return sum;
  }

  bool addUser(String name, String email, String phoneNo) {
    UserModel userM = UserModel(
      name: name,
      username: name,
      phoneNo: phoneNo,
      email: email,
    );
    UserDataBaseService.createUserDb(userM);
    return true;
  }

  Future<Map<String, double>> pieChartDataOfCommunities() async {
    Map<String, double> communityTotalExpenseMap = {};
    List<CommunityModel>? communityList =
        await UserDataBaseService.getCommunities(user!.phoneNo);
    for (int i = 0; i < communityList!.length; i++) {
      communityTotalExpenseMap[communityList[i].name] =
          communityTotalExpense(communityList[i].name).toDouble();
    }
    return communityTotalExpenseMap;
  }

  void getAllUserPhones() async {
    allUserPhones = await UserDataBaseService.getAllUserPhones();
    notifyListeners();
  }

  Future<void> getAllDetails(String phoneNo) async {

    deleteState();
    checkuser(phoneNo);
    List<CommunityModel>? communityTemp = await UserDataBaseService.getCommunities(phoneNo);
    communitiesdb = communityTemp;

    for (int i = 0; i < communityTemp!.length; i++) {
      communities.add(communityTemp[i].name);
    }

    notifyListeners();
    getAllUserPhones();

    for (int i = 0; i < communityTemp.length; i++) {
      getCommunityDetails(communityTemp[i].name);
    }

    notifyListeners();
  }

  Future<void> getCommunityDetails(String CommunityName) async {

    CommunityModel? currCommunity=null;
    for(int i=0;i<communitiesdb!.length;i++){
      if(communitiesdb![i].name==CommunityName){
        currCommunity = communitiesdb![i];
        break;
      }
    }

    if(currCommunity==null){
      return;
    }

    communityObjectMap[currCommunity.name] = [];
    communityObjectMapdb![currCommunity] = [];
    objectUnresolvedExpenseMap[currCommunity.name] = {};
    objectUnresolvedExpenseMapdb![currCommunity] = {};

    String? communityID = await CommunityDataBaseService.getCommunityID(currCommunity);
    List<ObjectsModel>? objectTemp = await ObjectDataBaseService.getObjects(communityID!);

    for (int j = 0; j < objectTemp!.length; j++) {

      communityObjectMap[currCommunity.name]!.add(objectTemp[j].name);
      communityObjectMapdb![currCommunity]!.add(objectTemp[j]);

      getObjectDetails(CommunityName, objectTemp[j].name);
    }

    getIndividualCommunityMembers(currCommunity);

    notifyListeners();

  }

  Future<void> getObjectDetails(String CommunityName,String ObjectName) async{


    CommunityModel? currCommunity=null;
    for(int i=0;i<communitiesdb!.length;i++){
      if(communitiesdb![i].name==CommunityName){
        currCommunity = communitiesdb![i];
        break;
      }
    }

    if(currCommunity==null){
      return;
    }

    ObjectsModel? currObject=null;
    for(int i=0;i<communityObjectMapdb![currCommunity]!.length;i++){
      if(communityObjectMapdb![currCommunity]![i].name==ObjectName){
        currObject = communityObjectMapdb![currCommunity]![i];
        break;
      }
    }

    if(currObject==null){
      return;
    }

      objectUnresolvedExpenseMap[currCommunity.name]![currObject.name] = [];
      objectUnresolvedExpenseMapdb![currCommunity]![currObject] = [];
    List<ExpenseModel>? expenseTemp = await ObjectDataBaseService.getExpenses(currObject);

    for (int k = 0; k < expenseTemp.length; k++) {
        objectUnresolvedExpenseMap[currCommunity.name]![currObject.name]!.add(Expense(
          communityName: currCommunity.name,
          objectName: currObject.name,
          creator:await UserDataBaseService.getName(expenseTemp[k].creatorID!),
          description: expenseTemp[k].name,
          isPaid: false,
          amount: int.parse(expenseTemp[k].amount),
          date:expenseTemp[k].date.toString(),
        ));
        objectUnresolvedExpenseMapdb![currCommunity]![currObject]!.add(expenseTemp[k]);
    }

    notifyListeners();
  }

  void getIndividualCommunityMembers(CommunityModel community) async{
    List<Member> memberList = [];
    List<dynamic>? group = await UserDataBaseService.getCommunityMembers(community.name, community.phoneNo);
    for (int j = 0; j < group.length; j++) {
      memberList.add(Member(
        name: group[j]["Name"],
        phone: group[j]["Phone Number"],
        isCreator: group[j]["Is Admin"],
      ));
    }
    communityMembersMap[community.name] = memberList;

  }

  void deleteState() {
    user = null;
    allUserPhones = [];
    communityMembersMap = {};

    communitiesdb = [];
    objectUnresolvedExpenseMapdb = {};
    communityObjectMapdb = {};

    communities = [];
    communityObjectMap = {};
    objectUnresolvedExpenseMap = {};

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

  Future<void> addCommunity(String communityName) async {
    CommunityModel community = CommunityModel(
      name: communityName,
      phoneNo: user!.phoneNo,
    );
    if (await CommunityDataBaseService.createCommunity(community) == false) {
      return;
    }

    communities.add(communityName);
    communityObjectMap[communityName] = ["Misc"];
    objectUnresolvedExpenseMap[communityName] = {};
    communityMembersMap[communityName] = [];
    communityMembersMap[communityName]!
        .add(Member(name: user!.name, phone: user!.phoneNo, isCreator: true));
    communitiesdb!.add(community);

    // await addObject(communityName, "Misc");
    // communityObjectMap[communityName]?.add("Misc");
    objectUnresolvedExpenseMap[communityName]!["Misc"] = [];

    notifyListeners();

    await CommunityDataBaseService.communityAddRemoveNotification(community, user!.phoneNo, true);
    await CommunityDataBaseService.addCommunityLogNotification(community,"Community Created");
  }

  Future<void> addObject(String communityName, String objectName) async {
    notifyListeners();
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    String? communityID = await CommunityDataBaseService.getCommunityID(ctmp);
    
    //checking if object already present?

    ObjectsModel? otmp = communityObjectMapdb![ctmp]!
        .firstWhereOrNull((element) => element.name == objectName);

    if(otmp!=null){
      return;
    }
    
    
    ObjectsModel object = ObjectsModel(
        name: objectName,
        communityID: communityID,
        creatorPhoneNo: user!.phoneNo,
        type: "",
        description: "");

    if (ObjectDataBaseService.createObjects(object) == false) {
      return;
    }

    communityObjectMapdb![ctmp]!.add(object);
    communityObjectMap[communityName]!.add(objectName);
    objectUnresolvedExpenseMap[communityName]![objectName] = [];

    objectUnresolvedExpenseMapdb![ctmp]![object] = [];
    notifyListeners();

    ObjectDataBaseService.ObjectAddNotification(object);
    await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Object Added : " + objectName+ " by ${user?.name}");
  }

  Future<void> addExpense(String objectName, String creator, int amount,String expenseDate, String description, String communityName) async {
    
    CommunityModel ctmp =communitiesdb!.firstWhere((element) => element.name == communityName);
    DateTime time = DateTime.now().toLocal();
    DateTime dateTime = DateTime.parse(expenseDate);
    expenseDate += " " + time.hour.toString() + ":" + time.minute.toString() + ":" + time.second.toString() + "." + time.millisecond.toString();
    dateTime = new DateTime( dateTime.year, dateTime.month, dateTime.day, time.hour, time.minute, time.second, time.millisecond);

    
    ObjectsModel otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == objectName);

    String? objectID = await ObjectDataBaseService.getObjectID(otmp);
    ExpenseModel expense = ExpenseModel(
        creatorID: await UserDataBaseService.getUserID(user!.phoneNo),
        amount: amount.toString(),
        name: description,
        objectID: objectID,
        description: "",
        date: dateTime);

    if (ExpenseDataBaseService.createExpense(expense) == false) {
      return;
    }

    ExpenseDataBaseService.ExpenseAddNotification(expense);
    await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Expense Added In ${objectName}: ₹" + amount.toString()+" by ${user?.name}");
    objectUnresolvedExpenseMap[communityName]![objectName]?.add(Expense(
        objectName: objectName,
        creator: creator,
        amount: amount,
        date: expenseDate,
        description: description,
        isPaid: false,
        communityName: communityName));
    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expense);

    notifyListeners();
  }

  void updateExpense(Expense expense, String newAmount, String newDate,String newDescription) async {

    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == expense.communityName);
    ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name == expense.objectName);
    ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!.firstWhere((element) => element.name == expense.description);

    if (ExpenseDataBaseService.deleteExpense(rtmp) == false) {
      return;
    }
    

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

    Expense? item =
        objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.firstWhere((element) =>
                element.objectName == expense.objectName &&
                element.creator == expense.creator &&
                element.amount == expense.amount &&
                element.description == expense.description);

    objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]
        ?.remove(item);


    DateTime? dateTime = DateTime.tryParse(newDate);
    ExpenseModel expenseM = ExpenseModel(
        creatorID: await UserDataBaseService.getUserID(user!.phoneNo),
        amount: newAmount,
        name: newDescription,
        objectID: await ObjectDataBaseService.getObjectID(otmp),
        description: "",
        date: dateTime);

    if (ExpenseDataBaseService.createExpense(expenseM) == false) {
      return;
    }

    ExpenseDataBaseService.ExpenseEditNotification(rtmp, expenseM, user!.phoneNo);

    objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.add(
        Expense(
            objectName: expense.objectName,
            creator: expense.creator,
            amount: int.parse(newAmount),
            date: newDate,
            description: newDescription,
            isPaid: false,
            communityName: expense.communityName));

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expenseM);
    notifyListeners();

  }

  addMembersToCommunity(String communityName, List<dynamic> names,
      List<dynamic> phones, String phoneNo) async {
    for (int i = 0; i < names.length; i++) {
      Member member = Member(
        name: names[i],
        phone: phones[i],
        isCreator: false,
      );
      if (!communityMembersMap[communityName]!.contains(member)) {
        CommunityModel ctmp = communitiesdb!
            .firstWhere((element) => element.name == communityName);
        if (await CommunityDataBaseService.addUserInCommunity(
            ctmp, member.phone, false)) {
          communityMembersMap[communityName]!.add(member);
          CommunityDataBaseService.communityAddRemoveNotification(ctmp, member.phone, true);
          await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Member Added : ${member.name}");
        }
      }
    }
    notifyListeners();
  }

  void removeMemberFromCommunity(String communityName, String phoneNo) async {
    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == communityName);
    if(await CommunityDataBaseService.removeUserFromCommunity(ctmp, phoneNo)){
      Member member = communityMembersMap[communityName]!
          .firstWhere((element) => element.phone == phoneNo);
      communityMembersMap[communityName]!.remove(member);
      communities.remove(communityName);
      CommunityDataBaseService.communityAddRemoveNotification(ctmp, phoneNo, false);
      await CommunityDataBaseService.addCommunityLogNotification(ctmp, "No longer in $communityName : ${member.name}");
    }
    notifyListeners();
  }

  void toggleCreatorPower(String communityName, String phoneNo) async {
    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == communityName);
    if(await CommunityDataBaseService.toggleCreatorPower(ctmp, phoneNo)){
      Member member = communityMembersMap[communityName]!
          .firstWhere((element) => element.phone == phoneNo);
      member.isCreator = !member.isCreator;
      await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Creator Power Toggled : ${member.name}");
    }
    notifyListeners();
  }

  void addToken(  ) async {
    NotificationServices notificationServices = NotificationServices();
    String token = await notificationServices.getToken();
    if (user != null) {
      UserDataBaseService.addToken(user!.phoneNo, token);
    }
  }

  Future<List<String>> getNotification(String communityName) async {
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    List<String> notification =
        await CommunityDataBaseService.getCommunityNotification(ctmp);
    return notification;
  }

  Future<bool> deleteCommunity(String communityName) async {
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);

    communitiesdb!.remove(ctmp);
    communityMembersMap.remove(communityName);
    communityObjectMap.remove(communityName);
    communityObjectMapdb!.remove(ctmp);
    objectUnresolvedExpenseMap.remove(communityName);
    objectUnresolvedExpenseMapdb!.remove(ctmp);

    communities.remove(communityName);

    notifyListeners();
    CommunityDataBaseService.deleteCommunity(ctmp);
    return true;
  }

  Future<bool> deleteObject(String communityName, String objectName) async {
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    ObjectsModel otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == objectName);
    communityObjectMapdb![ctmp]!.remove(otmp);
    objectUnresolvedExpenseMapdb![ctmp]!.remove(otmp);
    communityObjectMap[communityName]!.remove(objectName);
    objectUnresolvedExpenseMap[communityName]!.remove(objectName);
    notifyListeners();
    ObjectDataBaseService.deleteObject(otmp);
    return true;
  }

  Future<bool> isAdmin(String communityName) async {
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    bool res = await UserDataBaseService.isAdmin(ctmp, user!.phoneNo);
    return res;
  }
}
