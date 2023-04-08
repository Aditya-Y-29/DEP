import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/member.dart';
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

  //***********************************************
  // Images for common names

  Map<String,String> communityNameToImagePath={
    "Home": "assets/images/communityImages/Home.jpg",
    "Office": "assets/images/communityImages/Office.png",
    "Shop":"assets/images/communityImages/Shop.jpg",
    // "Lab":"assets/images/communityImages/Lab.jpg",
    // "Friends":"assets/images/communityImages/Friends.jpg",
    // "Family":"assets/images/communityImages/Family.jpg",
    // "Trip":"assets/images/communityImages/Trip.jpg",
    // "Apartment":"assets/images/communityImages/Apartment.jpg",
    // "Test":"assets/images/communityImages/Test.jpg",
    // "Myself":"assets/images/communityImages/Myself.jpg",
    // "Me":"assets/images/communityImages/Me.jpg",
    // "Couple":"assets/images/communityImages/Couple.jpg",
    "Default":"assets/images/communityImages/Default.jpg",
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

  String extractCommunityImagePathByName(String communityName){
    for (String key in communityNameToImagePath.keys) {
      String value = communityNameToImagePath[key]!;
      if(isSubstring(communityName.toLowerCase(),key.toLowerCase())){
        return value;
      }
    }
    return communityNameToImagePath["Default"]!;
  }

  int communityTotalExpense(String communityName) {
     int sum=0;
     for(int i=0;i<communityObjectMap[communityName]!.length;i++){
         for(int j=0;j<objectUnresolvedExpenseMap[communityName]![communityObjectMap[communityName]![i]]!.length;j++){
             sum+=objectUnresolvedExpenseMap[communityName]![communityObjectMap[communityName]![i]]![j].amount;
         }
     }
     return sum;
  }

  Future<int> totalExpense() async{
    int sum=0;
    List<CommunityModel>? communityList = await UserDataBaseService.getCommunities(user!.phoneNo);
    communityList!.forEach((element) {
         String communityName=element!.name;
         sum+=communityTotalExpense(communityName);
      }
    );
    return sum;
  }

  Future<int> myTotalExpense() async{
    int sum=0;
    List<CommunityModel>? communityList = await UserDataBaseService.getCommunities(user!.phoneNo);
    communityList!.forEach((element) {
        String communityName=element!.name;
        sum+=myExpenseInCommunity(communityName);
      }
    );
    return sum;
  }

  Future<Map<int,int>> spendingSummaryData() async {
    Map<int,int> spendingSummary={};
    spendingSummary[0]=await myTotalExpense();
    spendingSummary[1]=await totalExpense();
    return spendingSummary;
  }

  int myExpenseInCommunity(String communityName) {
    int sum=0;
    for(int i=0;i<communityObjectMap[communityName]!.length;i++){
      for(int j=0;j<objectUnresolvedExpenseMap[communityName]![communityObjectMap[communityName]![i]]!.length;j++){
        if(user!.name==objectUnresolvedExpenseMap[communityName]![communityObjectMap[communityName]![i]]![j].creator){
          sum+=objectUnresolvedExpenseMap[communityName]![communityObjectMap[communityName]![i]]![j].amount;
        }
      }
    }
    return sum;
  }

  int objectTotalExpense(String communityName, String objectName) {
    int sum=0;
    for(int j=0;j<objectUnresolvedExpenseMap[communityName]![objectName]!.length;j++){
      sum += objectUnresolvedExpenseMap[communityName]![objectName]![j].amount;
    }
    return sum;
  }

  int myExpenseInObject(String communityName, String objectName) {
    int sum=0;
    for(int j=0;j<objectUnresolvedExpenseMap[communityName]![objectName]!.length;j++) {
      if (user!.name ==
          objectUnresolvedExpenseMap[communityName]![objectName]![j].creator) {
        sum += objectUnresolvedExpenseMap[communityName]![objectName]![j].amount;
      }
    }
    return sum;
  }

  bool addUser(String name,String email,String phoneNo) {

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
    Map<String,double> communityTotalExpenseMap={};
    List<CommunityModel>? communityList = await UserDataBaseService.getCommunities(user!.phoneNo);
    for (int i = 0; i < communityList!.length; i++) {
      communityTotalExpenseMap[communityList[i].name] = communityTotalExpense(communityList[i].name).toDouble();
    }
    return communityTotalExpenseMap;

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
          // print("HELLO");
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
              date:expenseTemp[k].date.toString(),
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
              date:expenseTemp[k].date.toString(),
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

  Future<void> addCommunity(String communityName) async {
    CommunityModel community = CommunityModel(
      name: communityName,
      phoneNo: user!.phoneNo,
    );
    if( await CommunityDataBaseService.createCommunity(community)==false){
      return;
    }


    communities.add(communityName);
    communityObjectMap[communityName] = ["Misc"];
    objectUnresolvedExpenseMap[communityName] = {};
    objectResolvedExpenseMap[communityName] = {};
    communityMembersMap[communityName] = [];
    communityMembersMap[communityName]!.add(Member(name: user!.name, phone: user!.phoneNo, isCreator: true));
    communitiesdb!.add(community);

    // await addObject(communityName, "Misc");
    // communityObjectMap[communityName]?.add("Misc");
    objectUnresolvedExpenseMap[communityName]!["Misc"] = [];

    notifyListeners();

    await CommunityDataBaseService.communityAddNotification(community, user!.phoneNo);
    await CommunityDataBaseService.addCommunityLogNotification(community,"Community Created");
  }

  Future<void> addObject(String communityName, String objectName) async {

    notifyListeners();
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);
    // print("ctmp name: ${ctmp.name}");
    String? communityID = await CommunityDataBaseService.getCommunityID(ctmp);
    ObjectsModel object = ObjectsModel(
        name: objectName,
        communityID: communityID,
        creatorPhoneNo: user!.phoneNo,
        type: "",
        description: "");


    if(ObjectDataBaseService.createObjects(object)==false){
      return;
    }

    communityObjectMapdb![ctmp]!.add(object);
    communityObjectMap[communityName]!.add(objectName);
    objectUnresolvedExpenseMap[communityName]![objectName] = [];
    objectResolvedExpenseMap[communityName]![objectName] = [];
    objectResolvedExpenseMapdb![ctmp]![object] = [];
    objectUnresolvedExpenseMapdb![ctmp]![object] = [];
    notifyListeners();

    ObjectDataBaseService.ObjectAddNotification(object);
    await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Object Added: " + objectName);
  }

  Future<void> addExpense(String objectName, String creator, int amount,String expenseDate,
      String description, String communityName) async {
    CommunityModel ctmp =
        communitiesdb!.firstWhere((element) => element.name == communityName);

    DateTime dateTime = DateTime.parse(expenseDate);

    ObjectsModel otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name == objectName);

    String? objectID = await ObjectDataBaseService.getObjectID(otmp);
    DateTime? dateTime = DateTime.tryParse(expenseDate);
    ExpenseModel expense = ExpenseModel(
        creatorID: await UserDataBaseService.getUserID(user!.phoneNo),
        amount: amount.toString(),
        name: description,
        objectID: objectID,
        resolverid: null,
        description: "",
        date: dateTime);

    if(ExpenseDataBaseService.createExpense(expense)==false){
      return;
    }

    ExpenseDataBaseService.ExpenseAddNotification(expense);
    await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Expense Added: " + description + " (" + amount.toString() + ")");

    objectUnresolvedExpenseMap[communityName]![objectName]?.add(Expense(
        objectName: objectName,
        creator: creator,
        amount: amount,
        date:expenseDate,
        description: description,
        isPaid: false,
        communityName: communityName));
    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expense);
    
    notifyListeners();
  }

  void resolveExpense(Expense expense) {

    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == expense.communityName);
    ObjectsModel? otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == expense.objectName);
    ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!
        .firstWhere((element) => element.name == expense.description);

    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

    rtmp.resolverid = user!.phoneNo;
    if(ExpenseDataBaseService.resolveExpense(rtmp, user!.phoneNo)==false){
      return;
    }

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
            date: expense.date,
            description: expense.description,
            isPaid: true,
            communityName: expense.communityName));
    objectResolvedExpenseMapdb![ctmp]![otmp]!.add(rtmp);
    notifyListeners();
  }

  void updateExpense(
      Expense expense,
      String newAmount,
      String newDate,
      String newDescription) async{

    CommunityModel ctmp = communitiesdb!
        .firstWhere((element) => element.name == expense.communityName);
    ObjectsModel? otmp = communityObjectMapdb![ctmp]!
        .firstWhere((element) => element.name == expense.objectName);
    ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!
        .firstWhere((element) => element.name == expense.description);

    if(ExpenseDataBaseService.deleteExpense(rtmp)==false){
      return;
    }
    objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

    Expense? item =
    objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]
        ?.firstWhere((element) =>
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
        resolverid: null,
        description: "",
        date: dateTime);
    if(ExpenseDataBaseService.createExpense(expenseM)==false){
      return;
    }

    //ExpenseDataBaseService.ExpenseEditNotification(expense);

    objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.add(
        Expense(
            objectName: expense.objectName,
            creator: expense.creator,
            amount:  int.parse(newAmount),
            date:newDate,
            description:newDescription,
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
        if(await CommunityDataBaseService.addUserInCommunity(ctmp, member.phone, false)){
          communityMembersMap[communityName]!.add(member);
          CommunityDataBaseService.communityAddNotification(ctmp, member.phone);
          await CommunityDataBaseService.addCommunityLogNotification(ctmp, "Member Added : ${member.name}");
        }
      }
    }
    notifyListeners();
  }

  void addToken(  ) async {
    NotificationServices notificationServices = NotificationServices();
    String token = await notificationServices.getToken();
    if(user!=null){
      UserDataBaseService.addToken(user!.phoneNo, token);
    }
  }

  Future<List<String>> getNotification( String communityName) async {
    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == communityName);
    List<String> notification = await CommunityDataBaseService.getCommunityNotification(ctmp);
    return notification;
  }

  Future<bool> deleteCommunity(String communityName) async{
    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == communityName);


    communitiesdb!.remove(ctmp);
    communityMembersMap.remove(communityName);
    communityObjectMap.remove(communityName);
    communityObjectMapdb!.remove(ctmp);
    objectUnresolvedExpenseMap.remove(communityName);
    objectResolvedExpenseMap.remove(communityName);
    objectUnresolvedExpenseMapdb!.remove(ctmp);
    objectResolvedExpenseMapdb!.remove(ctmp);
    communities.remove(communityName);

    notifyListeners();
    CommunityDataBaseService.deleteCommunity(ctmp);
    return true;
    
  }

  Future<bool> deleteObject(String communityName, String objectName) async {
    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == communityName);
    ObjectsModel otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name == objectName);
    communityObjectMapdb![ctmp]!.remove(otmp);
    objectUnresolvedExpenseMapdb![ctmp]!.remove(otmp);
    objectResolvedExpenseMapdb![ctmp]!.remove(otmp);
    communityObjectMap[communityName]!.remove(objectName);
    objectUnresolvedExpenseMap[communityName]!.remove(objectName);
    objectResolvedExpenseMap[communityName]!.remove(objectName);
    notifyListeners();
    ObjectDataBaseService.deleteObject(otmp);
    return true;
  }

  Future<bool> isAdmin(String communityName) async {

    CommunityModel ctmp = communitiesdb!.firstWhere((element) => element.name == communityName);
    bool res= await UserDataBaseService.isAdmin(ctmp, user!.phoneNo);
    return res;
  }
}
