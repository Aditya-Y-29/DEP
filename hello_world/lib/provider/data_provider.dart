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
    "Hospital":"assets/images/communityImages/Hospital.jpeg",
    "Work":"assets/images/communityImages/Work.png",
    "Lab":"assets/images/communityImages/Lab.jpeg",
    "Friends":"assets/images/communityImages/Friends.jpeg",
    "Family":"assets/images/communityImages/Family.jpeg",
    "Trip":"assets/images/communityImages/Travel.jpeg",
    "Travel":"assets/images/communityImages/Travel.jpeg",
    "Apartment":"assets/images/communityImages/Apartment.jpeg",
    "Flat":"assets/images/communityImages/Apartment.jpeg",
    "Villa":"assets/images/communityImages/Apartment.jpeg",
    "Myself":"assets/images/communityImages/Myself.jpeg",
    "Me":"assets/images/communityImages/Myself.jpeg",
    "Own":"assets/images/communityImages/Myself.jpeg",
    "Self":"assets/images/communityImages/Myself.jpeg",
    "Couple":"assets/images/communityImages/Love.jpeg",
    "Love":"assets/images/communityImages/Love.jpeg",
    "Test":"assets/images/communityImages/Test.jpeg",
    "Default":"assets/images/communityImages/Default.jpg",
  };

  Map<String, String> objectNameToImagePath = {
    "Car": "assets/images/objectImages/Car.png",
    "furniture": "assets/images/objectImages/Furniture.jpeg",
    "fridge": "assets/images/objectImages/Fridge.jpeg",
    "Mobile": "assets/images/objectImages/Mobile.jpeg",
    "RO": "assets/images/objectImages/RO.jpeg",
    "Server": "assets/images/objectImages/Server.jpeg",
    "Shopping": "assets/images/objectImages/Shopping.jpeg",
    "Snacks": "assets/images/objectImages/Snacks.jpeg",
    "Table": "assets/images/objectImages/Table.jpeg",
    "Washing": "assets/images/objectImages/Washing Machine.jpeg",
    "Default": "assets/images/objectImages/Default.jpeg",
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

  String extractCommunityImagePathByName(String creatorTuple) {

    String communityName = creatorTuple.split(":")[0];

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

  int communityTotalExpense(String creatorTuple) {
    int sum = 0;
    for (int i = 0; i < communityObjectMap[creatorTuple]!.length; i++) {
      for (int j = 0;
          j <
              objectUnresolvedExpenseMap[creatorTuple]![
                      communityObjectMap[creatorTuple]![i]]!
                  .length;
          j++) {
        sum += objectUnresolvedExpenseMap[creatorTuple]![
                communityObjectMap[creatorTuple]![i]]![j]
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
      String creatorTuple = "${element.name}:${element.phoneNo}";
      sum += communityTotalExpense(creatorTuple);
    });
    return sum;
  }

  Future<int> myTotalExpense() async {
    int sum = 0;
    List<CommunityModel>? communityList =
        await UserDataBaseService.getCommunities(user!.phoneNo);
    communityList!.forEach((element) {
      String creatorTuple = "${element.name}:${element.phoneNo}";
      sum += myExpenseInCommunity(creatorTuple);
    });
    return sum;
  }

  Future<Map<int, int>> spendingSummaryData() async {
    Map<int, int> spendingSummary = {};
    spendingSummary[0] = await myTotalExpense();
    spendingSummary[1] = await totalExpense();
    return spendingSummary;
  }

  int myExpenseInCommunity(String creatorTuple) {
    int sum = 0;
    for (int i = 0; i < communityObjectMap[creatorTuple]!.length; i++) {
      for (int j = 0;
          j <
              objectUnresolvedExpenseMap[creatorTuple]![
                      communityObjectMap[creatorTuple]![i]]!
                  .length;
          j++) {
        if (user!.name ==
            objectUnresolvedExpenseMap[creatorTuple]![
                    communityObjectMap[creatorTuple]![i]]![j]
                .creator) {
          sum += objectUnresolvedExpenseMap[creatorTuple]![
                  communityObjectMap[creatorTuple]![i]]![j]
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
      String creatorTuple = "${communityList[i].name}:${communityList[i].phoneNo}";
      String commCreatorName = creatorTuple.split(":")[0] + " - " + communityMembersMap[creatorTuple]!.firstWhere((member) => member.phone == (creatorTuple).split(":")[1], orElse: () => communityMembersMap[creatorTuple]!.firstWhere((member) => member.isCreator == true)).name;
      communityTotalExpenseMap[commCreatorName] =
          communityTotalExpense(creatorTuple).toDouble();
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
      String creatorTuple = '${communityTemp[i].name}:${communityTemp[i].phoneNo}';
      communities.add(creatorTuple);
    }

    notifyListeners();
    getAllUserPhones();

    for (int i = 0; i < communityTemp.length; i++) {
      getCommunityDetails('${communityTemp[i].name}:${communityTemp[i].phoneNo}');
    }

    notifyListeners();
  }

  Future<void> getCommunityDetails(String creatorTuple) async {

    List<String> extractedTupleInfo = creatorTuple.split(':');
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];

    CommunityModel? currCommunity=null;
    for(int i=0;i<communitiesdb!.length;i++){
      if(communitiesdb![i].name==communityName && communitiesdb![i].phoneNo==creatorPhoneNo){
        currCommunity = communitiesdb![i];
        break;
      }
    }

    if(currCommunity==null){
      return;
    }

    communityObjectMap[creatorTuple] = [];
    communityObjectMapdb![currCommunity] = [];
    objectUnresolvedExpenseMap[creatorTuple] = {};
    objectUnresolvedExpenseMapdb![currCommunity] = {};

    String? communityID = await CommunityDataBaseService.getCommunityID(currCommunity);
    List<ObjectsModel>? objectTemp = await ObjectDataBaseService.getObjects(communityID!);

    for (int j = 0; j < objectTemp!.length; j++) {

      communityObjectMap[creatorTuple]!.add(objectTemp[j].name);
      communityObjectMapdb![currCommunity]!.add(objectTemp[j]);

      getObjectDetails(creatorTuple, objectTemp[j].name);
    }

    getIndividualCommunityMembers(currCommunity);

    notifyListeners();

  }

  Future<void> getObjectDetails(String creatorTuple,String ObjectName) async{

    List<String> extractedTupleInfo = creatorTuple.split(':');
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];

    CommunityModel? currCommunity=null;
    for(int i=0;i<communitiesdb!.length;i++){
      if(communitiesdb![i].name==communityName && communitiesdb![i].phoneNo==creatorPhoneNo){
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

      objectUnresolvedExpenseMap[creatorTuple]![currObject.name] = [];
      objectUnresolvedExpenseMapdb![currCommunity]![currObject] = [];
    List<ExpenseModel>? expenseTemp = await ObjectDataBaseService.getExpenses(currObject);

    for (int k = 0; k < expenseTemp.length; k++) {
        objectUnresolvedExpenseMap[creatorTuple]![currObject.name]!.add(Expense(
          creatorTuple: creatorTuple,
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
    String creatorTuple = '${community.name}:${community.phoneNo}';
    communityMembersMap[creatorTuple] = memberList;

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

  void communityListen(String creatorTuple) {
    communitiesIndex = communities.indexOf(creatorTuple);
    notifyListeners();
  }

  void objectListen(String communityName, String objectName) {
    objectIndex = communityObjectMap[communityName]!.indexOf(objectName);
    notifyListeners();
  }

  void expenseListen(Expense expense) {
    expenseIndex =
        objectUnresolvedExpenseMap[expense.creatorTuple]![expense.objectName]!
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

    String creatorTuple = '${communityName}:${user!.phoneNo}';
    communities.add(creatorTuple);
    communityObjectMap[creatorTuple] = ["Misc"];
    objectUnresolvedExpenseMap[creatorTuple] = {};
    communityMembersMap[creatorTuple] = [];
    communityMembersMap[creatorTuple]!
        .add(Member(name: user!.name, phone: user!.phoneNo, isCreator: true));
    communitiesdb!.add(community);

    // await addObject(communityName, "Misc");
    // communityObjectMap[communityName]?.add("Misc");
    objectUnresolvedExpenseMap[creatorTuple]!["Misc"] = [];

    notifyListeners();

    await CommunityDataBaseService.communityAddRemoveNotification(community, user!.phoneNo, true);
    await CommunityDataBaseService.addCommunityLogNotification(community,"Community Created");
  }

  Future<void> addObject(String creatorTuple, String objectName) async {
    notifyListeners();
    List<String> extractedTupleInfo = creatorTuple.split(':');
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhoneNo);
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
    communityObjectMap[creatorTuple]!.add(objectName);
    objectUnresolvedExpenseMap[creatorTuple]![objectName] = [];

    objectUnresolvedExpenseMapdb![ctmp]![object] = [];
    notifyListeners();

    ObjectDataBaseService.ObjectAddNotification(object);
    await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Object Added : " + objectName+ " by ${user?.name}");
  }

  Future<void> addExpense(String objectName, String creator, int amount,String expenseDate, String description, String creatorTuple) async {

    List<String> extractedTupleInfo = creatorTuple.split(':');
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];
    CommunityModel ctmp =communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhoneNo);
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
    objectUnresolvedExpenseMap[creatorTuple]![objectName]?.add(Expense(
        objectName: objectName,
        creator: creator,
        amount: amount,
        date: expenseDate,
        description: description,
        isPaid: false,
        creatorTuple: creatorTuple));
    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expense);

    notifyListeners();
  }

  void updateExpense(Expense expense, String newAmount, String newDate,String newDescription) async {

    List<String> extractedTupleInfo = expense.creatorTuple.split(':');
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];

    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhoneNo);
    ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name == expense.objectName);
    ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!.firstWhere((element) => element.name == expense.description);

    if (ExpenseDataBaseService.deleteExpense(rtmp) == false) {
      return;
    }
    

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

    Expense? item =
        objectUnresolvedExpenseMap[expense.creatorTuple]![expense.objectName]?.firstWhere((element) =>
                element.objectName == expense.objectName &&
                element.creator == expense.creator &&
                element.amount == expense.amount &&
                element.description == expense.description);

    objectUnresolvedExpenseMap[expense.creatorTuple]![expense.objectName]
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

    objectUnresolvedExpenseMap[expense.creatorTuple]![expense.objectName]?.add(
        Expense(
            objectName: expense.objectName,
            creator: expense.creator,
            amount: int.parse(newAmount),
            date: newDate,
            description: newDescription,
            isPaid: false,
            creatorTuple: expense.creatorTuple));

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expenseM);
    notifyListeners();

  }

  addMembersToCommunity(String creatorTuple, List<dynamic> names,
      List<dynamic> phones, String phoneNo) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhoneNo = extractedTupleInfo[1];

    for (int i = 0; i < names.length; i++) {
      Member member = Member(
        name: names[i],
        phone: phones[i],
        isCreator: false,
      );
      if (!communityMembersMap[creatorTuple]!.contains(member)) {
        CommunityModel ctmp = communitiesdb!
            .firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhoneNo);
        if (await CommunityDataBaseService.addUserInCommunity(
            ctmp, member.phone, false)) {
          communityMembersMap[creatorTuple]!.add(member);
          CommunityDataBaseService.communityAddRemoveNotification(ctmp, member.phone, true);
          await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Member Added : ${member.name}");
        }
      }
    }
    notifyListeners();
  }

  void removeMemberFromCommunity(String creatorTuple, String phoneNo) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);
    if(await CommunityDataBaseService.removeUserFromCommunity(ctmp, phoneNo)){
      Member member = communityMembersMap[creatorTuple]!
          .firstWhere((element) => element.phone == phoneNo);
      communityMembersMap[creatorTuple]!.remove(member);
      communities.remove(creatorTuple);
      CommunityDataBaseService.communityAddRemoveNotification(ctmp, phoneNo, false);
      await CommunityDataBaseService.addCommunityLogNotification(ctmp, "No longer in $communityName : ${member.name}");
    }
    notifyListeners();
  }

  void toggleCreatorPower(String creatorTuple, String phoneNo) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);
    if(await CommunityDataBaseService.toggleCreatorPower(ctmp, phoneNo)){
      Member member = communityMembersMap[creatorTuple]!
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

  Future<List<String>> getNotification(String creatorTuple) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);
    List<String> notification =
        await CommunityDataBaseService.getCommunityNotification(ctmp);
    return notification;
  }

  Future<bool> deleteCommunity(String creatorTuple) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);

    communitiesdb!.remove(ctmp);
    communityMembersMap.remove(creatorTuple);
    communityObjectMap.remove(creatorTuple);
    communityObjectMapdb!.remove(ctmp);
    objectUnresolvedExpenseMap.remove(creatorTuple);
    objectUnresolvedExpenseMapdb!.remove(ctmp);

    communities.remove(creatorTuple);

    notifyListeners();
    CommunityDataBaseService.deleteCommunity(ctmp);
    return true;
  }

  Future<bool> deleteObject(String creatorTuple, String objectName) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);
    ObjectsModel otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == objectName);
    communityObjectMapdb![ctmp]!.remove(otmp);
    objectUnresolvedExpenseMapdb![ctmp]!.remove(otmp);
    communityObjectMap[creatorTuple]!.remove(objectName);
    objectUnresolvedExpenseMap[creatorTuple]!.remove(objectName);
    notifyListeners();
    ObjectDataBaseService.deleteObject(otmp);
    return true;
  }

  Future<bool> isAdmin(String creatorTuple) async {

    List<String> extractedTupleInfo = creatorTuple.split(":");
    String communityName = extractedTupleInfo[0];
    String creatorPhone = extractedTupleInfo[1];

    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName && element.phoneNo == creatorPhone);
    bool res = await UserDataBaseService.isAdmin(ctmp, user!.phoneNo);
    return res;
  }
}
