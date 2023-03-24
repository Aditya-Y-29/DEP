
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/Models/community.dart';
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

class DataProvider extends ChangeNotifier{
      int communitiesIndex=0;
      int objectIndex = 0;
      int expenseIndex = 0;
      // int serviceIndex = 0;

      UserModel? user;
      List<CommunityModel>? communitiesdb = [];
      Map<CommunityModel, List<ObjectsModel>>? communityObjectMapdb = {};
      Map<CommunityModel,Map<ObjectsModel,List<ExpenseModel>>>? objectUnresolvedExpenseMapdb = {};
      Map<CommunityModel,Map<ObjectsModel,List<ExpenseModel>>>? objectResolvedExpenseMapdb = {};
      // Map<CommunityModel,Map<ObjectsModel,List<ServiceModel>>>? objectUnresolvedServiceMapdb = {};
      // Map<CommunityModel,Map<ObjectsModel,List<ServiceModel>>>? objectResolvedServiceMapdb = {};

      List<String> allUserPhones = [];
      List<String> communities = [];
      Map<String, List<String>> communityObjectMap = {};
      Map<String, List<Member>> communityMembersMap = {};
      Map<String, Map<String,List<Expense> >> objectUnresolvedExpenseMap = {};
      Map<String, Map<String,List<Expense> >> objectResolvedExpenseMap = {};
      // Map<String, Map<String,List<Service> >> objectUnresolvedServices = {};
      // Map<String, Map<String,List<Service> >> objectResolvedServices = {};



      void checkuser(String phoneNo) async {
        user=await UserDataBaseService.getUser(phoneNo);
      }

      void getCommunityMembers(String phone) async {
        List<CommunityModel>? communityList = await UserDataBaseService.getCommunities(phone);
        for(int i=0;i<communityList!.length;i++){
          // print("goin thru communities");
          List<Member> memberList = [];
          List<dynamic>? group = await UserDataBaseService.getCommunityMembers(communityList[i].name, communityList[i].phoneNo);
          for(int j=0;j<group.length;j++)
            {
              memberList.add(Member(name: group[j]["Name"],phone: group[j]["Phone Number"], isCreator: group[j]["Is Admin"],));
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

      Future<void> getAlldetails(String phoneNo) async {

        checkuser(phoneNo);
        List<CommunityModel>? communitytemp=await UserDataBaseService.getCommunities(phoneNo);
        communitiesdb=communitytemp;

        for(int i=0;i<communitytemp!.length;i++){
          communities.add(communitytemp[i].name);
          notifyListeners();
          communityObjectMap[communitytemp[i].name] = [];
          communityObjectMapdb![communitytemp[i]] = [];

          objectUnresolvedExpenseMap[communitytemp[i].name] = {};
          objectUnresolvedExpenseMapdb![communitytemp[i]] = {};

          // objectUnresolvedServices[communitytemp[i].name] = {};
          // objectUnresolvedServiceMapdb![communitytemp[i]] = {};

          objectResolvedExpenseMap[communitytemp[i].name] = {};
          objectResolvedExpenseMapdb![communitytemp[i]] = {};

          // objectResolvedServices[communitytemp[i].name] = {};
          // objectResolvedServiceMapdb![communitytemp[i]] = {};
        }
        notifyListeners();

        getAllUserPhones();
        getCommunityMembers(phoneNo);


        for(int i=0;i<communitytemp.length;i++){
          String? communityID=await CommunityDataBaseService.getCommunityID(communitytemp[i]);
          List<ObjectsModel>? objecttemp=await ObjectDataBaseService.getObjects(communityID!);

          for(int j=0;j<objecttemp!.length;j++){
            communityObjectMap[communitytemp[i].name]!.add(objecttemp[j].name);
            communityObjectMapdb![communitytemp[i]]!.add(objecttemp[j]);


            objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectUnresolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]] = [];

            // objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];
            // objectUnresolvedServiceMapdb![communitytemp[i]]![objecttemp[j]] = [];

            objectResolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectResolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]] = [];

            // objectResolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];
            // objectResolvedServiceMapdb![communitytemp[i]]![objecttemp[j]] = [];

            notifyListeners();
            List<ExpenseModel>? expensetemp=await ObjectDataBaseService.getExpenses(objecttemp[j]);

            for(int k=0;k<expensetemp.length;k++){
              if(expensetemp[k].resolverid==null){
                objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name]!.add(Expense(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: await UserDataBaseService.getName(expensetemp[k].creatorID!),
                  description: expensetemp[k].name,
                  isPaid: false,
                  amount: int.parse(expensetemp[k].amount),
                ));

                objectUnresolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]]!.add(expensetemp[k]);
              }
              else{
                objectResolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name]!.add(Expense(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: await UserDataBaseService.getName(expensetemp[k].creatorID!),
                  description: expensetemp[k].name,
                  isPaid: true,
                  amount: int.parse(expensetemp[k].amount),
                ));

                objectResolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]]!.add(expensetemp[k]);
              }
            }
            notifyListeners();
            // List<ServiceModel>? servicetemp=await ObjectDataBaseService.getServices(objecttemp[j]);

            // for(int k=0;k<servicetemp.length;k++){
            //   if(servicetemp[k].resolverid==null){
            //     objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
            //       communityName: communitytemp[i].name,
            //       objectName: objecttemp[j].name,
            //       creator: await UserDataBaseService.getName(servicetemp[k].creatorID!),
            //       description: servicetemp[k].name,
            //       isResolved: false,
            //     ));

            //     objectUnresolvedServiceMapdb![communitytemp[i]]![objecttemp[j]]!.add(servicetemp[k]);
            //   }
            //   else{
            //     objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
            //       communityName: communitytemp[i].name,
            //       objectName: objecttemp[j].name,
            //       creator: await UserDataBaseService.getName(servicetemp[k].creatorID!),
            //       description: servicetemp[k].name,
            //       isResolved: true,
            //     ));

            //     objectResolvedServiceMapdb![communitytemp[i]]![objecttemp[j]]!.add(servicetemp[k]);
            //   }
            // }
            notifyListeners();
          }
        }
        notifyListeners();
      }

      void deleteState(){
        communities=[];
        communityObjectMap={};
        objectUnresolvedExpenseMap={};
        // objectUnresolvedServices={};
        objectResolvedExpenseMap={};
        // objectResolvedServices={};
        communitiesdb=[];
        notifyListeners();
      }

      void communityListen( String communityName){
        communitiesIndex=communities.indexOf(communityName);
        notifyListeners();
      }

      void objectListen( String communityName, String objectName){
        objectIndex=communityObjectMap[communityName]!.indexOf(objectName);
        notifyListeners();
      }

      void expenseListen(Expense expense){
        expenseIndex=objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]!.indexOf(expense);
        notifyListeners();
      }

      // void serviceListen(Service service){
      //   serviceIndex=objectUnresolvedServices[service.communityName]![service.objectName]!.indexOf(service);
      //   notifyListeners();
      // }

      void addCommunity(String communityName){
        communities.add(communityName);
        communityObjectMap[communityName] = [];
        objectUnresolvedExpenseMap[communityName] = {};
        // objectUnresolvedServices[communityName] = {};
        objectResolvedExpenseMap[communityName] = {};
        // objectResolvedServices[communityName] = {};
        communityMembersMap[communityName] = [];
        communityMembersMap[communityName]!.add(Member(name:user!.name,phone: user!.phoneNo,isCreator: true));
        notifyListeners();

        CommunityModel community=CommunityModel(name: communityName,phoneNo: user!.phoneNo,);
        CommunityDataBaseService.createCommunity(community);
        communitiesdb!.add(community);
        notifyListeners();
      }

      Future<void> addObject(String communityName, String objectName) async {
        communityObjectMap[communityName]!.add(objectName);
        objectUnresolvedExpenseMap[communityName]![objectName] = [];
        // objectUnresolvedServices[communityName]![objectName] = [];
        objectResolvedExpenseMap[communityName]![objectName] = [];
        // objectResolvedServices[communityName]![objectName] = [];

        notifyListeners();
        CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==communityName);
        String? communityID=await CommunityDataBaseService.getCommunityID(ctmp);
        ObjectsModel object=ObjectsModel(name: objectName,communityID: communityID,creatorPhoneNo: user!.phoneNo,type:"",description: "");
        communityObjectMapdb![ctmp]!.add(object);
        ObjectDataBaseService.createObjects(object);
      }

      Future<void> addExpense(String objectName, String creator, int amount, String description, String communityName)async {
        objectUnresolvedExpenseMap[communityName]![objectName]?.add(Expense(objectName: objectName, creator: creator, amount: amount, description: description, isPaid: false, communityName: communityName));
        
        notifyListeners();
        CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==communityName);
        ObjectsModel otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==objectName);
        String? objectID=await ObjectDataBaseService.getObjectID(otmp);
        ExpenseModel expense=ExpenseModel(creatorID: await UserDataBaseService.getUserID(user!.phoneNo),amount: amount.toString(),name: description,objectID: objectID,resolverid: null,description: "", date: null);
        objectUnresolvedExpenseMapdb![ctmp]![otmp]!.add(expense);
        
        ExpenseDataBaseService.createExpense(expense);

        
      }

      // Future<void> addService(String objectName, String creator, String description, String communityName)async {
      //   objectUnresolvedServices[communityName]![objectName]?.add(Service(objectName: objectName, creator: creator, description: description, isResolved: false, communityName: communityName));
      //   notifyListeners();
      //   CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==communityName);
      //   ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==objectName);
      //   String? objectID=await ObjectDataBaseService.getObjectID(otmp);
      //   ServiceModel service = ServiceModel(creatorID: await UserDataBaseService.getUserID(user!.phoneNo) ,name: description,objectID: objectID,resolverid: null, date: null,description: "");
      //   objectUnresolvedServiceMapdb![ctmp]![otmp]!.add(service);
      //   ServiceDataBaseService.createService(service);
      // }

      void resolveExpense(Expense expense)
      {
        Expense? item = objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.firstWhere((element) => element.objectName == expense.objectName && element.creator == expense.creator && element.amount == expense.amount && element.description == expense.description);
        objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.remove(item);
        objectResolvedExpenseMap[expense.communityName]![expense.objectName]?.add(Expense(objectName: expense.objectName, creator: expense.creator, amount: expense.amount, description: expense.description, isPaid: true, communityName: expense.communityName));
        notifyListeners();

        CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==expense.communityName);
        ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==expense.objectName);
        ExpenseModel? rtmp = objectUnresolvedExpenseMapdb![ctmp]![otmp]!.firstWhere((element) => element.name==expense.description);
        
        objectUnresolvedExpenseMapdb![ctmp]![otmp]!.remove(rtmp);

        rtmp.resolverid=user!.phoneNo;
        objectResolvedExpenseMapdb![ctmp]![otmp]!.add(rtmp);
        ExpenseDataBaseService.resolveExpense(rtmp,user!.phoneNo);

      }

      // void resolveService(Service service)
      // {
      //   Service? item = objectUnresolvedServices[service.communityName]![service.objectName]?.firstWhere((element) => element.objectName == service.objectName && element.creator == service.creator && element.description == service.description);
      //   objectUnresolvedServices[service.communityName]![service.objectName]?.remove(item);
      //   objectResolvedServices[service.communityName]![service.objectName]?.add(Service(objectName: service.objectName, creator: service.creator, description: service.description, isResolved: true, communityName: service.communityName));
      //   notifyListeners();

      //   CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==service.communityName);
      //   ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==service.objectName);
      //   ServiceModel? stmp = objectUnresolvedServiceMapdb![ctmp]![otmp]!.firstWhere((element) => element.name==service.description);

      //   objectUnresolvedServiceMapdb![ctmp]![otmp]!.remove(stmp);

      //   stmp.resolverid=user!.phoneNo;
      //   objectResolvedServiceMapdb![ctmp]![otmp]!.add(stmp);
      //   ServiceDataBaseService.resolveService(stmp,user!.phoneNo);
      // }

      addMembersToCommunity(String communityName, List<dynamic> names, List<dynamic> phones){
        for(int i=0;i<names.length;i++)
          {
            Member member = Member(name: names[i], phone: phones[i], isCreator: false,);
            if(!communityMembersMap[communityName]!.contains(member)) {
              communityMembersMap[communityName]!.add(member);
              CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==communityName);
              CommunityDataBaseService.addUserInCommunity(ctmp, member.phone,false);
              }
          }
        notifyListeners();
      }

}