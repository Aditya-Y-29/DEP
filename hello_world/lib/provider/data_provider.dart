
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
      int serviceIndex = 0;

      UserModel? user;
      List<CommunityModel>? communitiesdb = [];
      Map<CommunityModel, List<ObjectsModel>>? communityObjectMapdb = {};

      Map<CommunityModel,Map<ObjectsModel,List<ExpenseModel>>>? objectUnresolvedExpenseMapdb = {};
      Map<CommunityModel,Map<ObjectsModel,List<ExpenseModel>>>? objectResolvedExpenseMapdb = {};

      Map<CommunityModel,Map<ObjectsModel,List<ServiceModel>>>? objectUnresolvedServiceMapdb = {};
      Map<CommunityModel,Map<ObjectsModel,List<ServiceModel>>>? objectResolvedServiceMapdb = {};

      List<String> allUserPhones = ["8279833510", "8595939608", "8930448891", "9502201858"];

      List<String> communities = ["Home", "Office", "Apartment"];

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Oven", "PC", "TV", "Fridge"],
        "Office": ["Chairs", "Books", "Speaker"],
        "Apartment": ["Car", "Computer", "TV"],
      };

      Map<String, List<Member>> communityMembersMap = {
        "Home": [
          Member(name: "PersonA", phone: "8279833510", isCreator: true,),
          Member(name: "PersonB", phone: "8595939608", isCreator: false,),
          Member(name: "PersonC", phone: "8930448891", isCreator: false,),
          Member(name: "PersonD", phone: "9502201858", isCreator: false,),
        ],
        "Office": [
          Member(name: "PersonA", phone: "8279833510", isCreator: true,),
          Member(name: "PersonE", phone: "8595939608", isCreator: false,),
          Member(name: "PersonF", phone: "8930448891", isCreator: false,),
          Member(name: "PersonG", phone: "9502201858", isCreator: false,),
        ],
        "Apartment": [
          Member(name: "PersonA", phone: "8279833510", isCreator: true,),
          Member(name: "PersonH", phone: "8595939608", isCreator: false,),
          Member(name: "PersonI", phone: "8930448891", isCreator: false,),
          Member(name: "PersonJ", phone: "9502201858", isCreator: false,),
        ]
      };

      Map<String, Map<String,List<Expense> >> objectUnresolvedExpenseMap = {
        "Home":{
            "Oven": [
            Expense(objectName: "Oven", creator: "PersonA", description: "Oven Service", amount: 750, isPaid: false,communityName: "Home",),
            Expense(objectName: "Oven", creator: "PersonB", description: "Oven Repair", amount: 1000, isPaid: false,communityName: "Home",),
          ],
          "PC": [
            Expense(objectName: "PC", creator: "PersonA", description: "PC Service", amount: 750, isPaid: false,communityName: "Home",),
            Expense(objectName: "PC", creator: "PersonB", description: "PC Repair", amount: 1000, isPaid: false,communityName: "Home",),
          ],
          "TV": [
            Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: false,communityName: "Home",),
            Expense(objectName: "TV", creator: "PersonB", description: "TV Repair", amount: 1000, isPaid: false,communityName: "Home",),
          ],
          "Fridge": [
            Expense(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: false,communityName: "Home",),
            Expense(objectName: "Fridge", creator: "PersonB", description: "Fridge Repair", amount: 1000, isPaid: false,communityName: "Home",),
          ]
        },
        "Office": {
          "Chairs": [
            Expense(objectName: "Chairs", creator: "PersonA", description: "Chair Service", amount: 750, isPaid: false,communityName: "Office",),
            Expense(objectName: "Chairs", creator: "PersonB", description: "Chair Repair", amount: 1000, isPaid: false,communityName: "Office",),
          ],
          "Books": [
            Expense(objectName: "Books", creator: "PersonA", description: "Book Service", amount: 750, isPaid: false,communityName: "Office",),
            Expense(objectName: "Books", creator: "PersonB", description: "Book Repair", amount: 1000, isPaid: false,communityName: "Office",),
          ],
          "Speaker": [
            Expense(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: false,communityName: "Office",),
            Expense(objectName: "Speaker", creator: "PersonB", description: "Speaker Repair", amount: 1000, isPaid: false,communityName: "Office",),
          ],
        },

        "Apartment": {
            "Car": [
            Expense(objectName: "Car", creator: "PersonA", description: "Car Service", amount: 750, isPaid: false,communityName: "Apartment",),
            Expense(objectName: "Car", creator: "PersonB", description: "Car Repair", amount: 1000, isPaid: false,communityName: "Apartment",),
          ],
          "Computer": [
            Expense(objectName: "Computer", creator: "PersonA", description: "Computer Service", amount: 750, isPaid: false,communityName: "Apartment",),
            Expense(objectName: "Computer", creator: "PersonB", description: "Computer Repair", amount: 1000, isPaid: false,communityName: "Apartment",),
          ],
          "TV": [
            Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: false,communityName: "Apartment",),
            Expense(objectName: "TV", creator: "PersonB", description: "TV Repair", amount: 1000, isPaid: false,communityName: "Apartment",),
          ],
        }

      };

      Map<String, Map<String,List<Expense> >> objectResolvedExpenseMap = {

        "Home":{
          "Oven": [
            Expense(objectName: "Oven", creator: "PersonA", description: "Oven Service", amount: 750, isPaid: true,communityName: "Home",),
          ],
          "PC": [
            Expense(objectName: "PC", creator: "PersonA", description: "PC Service", amount: 750, isPaid: true,communityName: "Home",),
          ],
          "TV": [
            Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: true,communityName: "Home",),
          ],
          "Fridge": [
            Expense(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: true,communityName: "Home",),
          ],
        },

        "Office": {
          "Chairs": [
            Expense(objectName: "Chairs", creator: "PersonA", description: "Chair Service", amount: 750, isPaid: true,communityName: "Office",),
          ],
          "Books": [
            Expense(objectName: "Books", creator: "PersonA", description: "Book Service", amount: 750, isPaid: true,communityName: "Office",),
          ],
          "Speaker": [
            Expense(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: true,communityName: "Office",),
          ],
        },

        "Apartment": {
          "Car": [
            Expense(objectName: "Car", creator: "PersonA", description: "Car Service", amount: 750, isPaid: true,communityName: "Apartment",),
          ],
          "Computer": [
            Expense(objectName: "Computer", creator: "PersonA", description: "Computer Service", amount: 750, isPaid: true,communityName: "Apartment",),
          ],
          "TV": [
            Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: true,communityName: "Apartment",),
          ],
        }
      };

      Map<String, Map<String,List<Service> >> objectUnresolvedServices = {

        "Home":{
          "Oven": [
            Service(objectName: "Oven", creator: "PersonA", description: "Oven Service", isResolved: false,communityName: "Home",),
            Service(objectName: "Oven", creator: "PersonB", description: "Oven Repair", isResolved: false,communityName: "Home",),
          ],
          "PC": [
            Service(objectName: "PC", creator: "PersonA", description: "PC Service", isResolved: false,communityName: "Home",),
            Service(objectName: "PC", creator: "PersonB", description: "PC Repair", isResolved: false,communityName: "Home",),
          ],
          "TV": [
            Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: false,communityName: "Home",),
            Service(objectName: "TV", creator: "PersonB", description: "TV Repair", isResolved: false,communityName: "Home",),
          ],
          "Fridge": [
            Service(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", isResolved: false,communityName: "Home",),
            Service(objectName: "Fridge", creator: "PersonB", description: "Fridge Repair", isResolved: false,communityName: "Home",),
          ],
        },

        "Office": {
          "Chairs": [
            Service(objectName: "Chairs", creator: "PersonA", description: "Chair Service", isResolved: false,communityName: "Office",),
            Service(objectName: "Chairs", creator: "PersonB", description: "Chair Repair", isResolved: false,communityName: "Office",),
          ],
          "Books": [
            Service(objectName: "Books", creator: "PersonA", description: "Book Service", isResolved: false,communityName: "Office",),
            Service(objectName: "Books", creator: "PersonB", description: "Book Repair", isResolved: false,communityName: "Office",),
          ],
          "Speaker": [
            Service(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", isResolved: false,communityName: "Office",),
            Service(objectName: "Speaker", creator: "PersonB", description: "Speaker Repair", isResolved: false,communityName: "Office",),
          ],
        },

        "Apartment": {
          "Car": [
            Service(objectName: "Car", creator: "PersonA", description: "Car Service", isResolved: false,communityName: "Apartment",),
            Service(objectName: "Car", creator: "PersonB", description: "Car Repair", isResolved: false,communityName: "Apartment",),
          ],
          "Computer": [
            Service(objectName: "Computer", creator: "PersonA", description: "Computer Service", isResolved: false,communityName: "Apartment",),
            Service(objectName: "Computer", creator: "PersonB", description: "Computer Repair", isResolved: false,communityName: "Apartment",),
          ],
          "TV": [
            Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: false,communityName: "Apartment",),
            Service(objectName: "TV", creator: "PersonB", description: "TV Repair", isResolved: false,communityName: "Apartment",),
          ],
        }

      };

      Map<String, Map<String,List<Service> >> objectResolvedServices = {

        "Home":{
          "Oven": [
            Service(objectName: "Oven", creator: "PersonA", description: "Oven Service", isResolved: true,communityName: "Home",),
          ],
          "PC": [
            Service(objectName: "PC", creator: "PersonA", description: "PC Service", isResolved: true,communityName: "Home",),
          ],
          "TV": [
            Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: true,communityName: "Home",),
          ],
          "Fridge": [
            Service(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", isResolved: true,communityName: "Home",),
          ],
        },

        "Office": {
          "Chairs": [
            Service(objectName: "Chairs", creator: "PersonA", description: "Chair Service", isResolved: true,communityName: "Office",),
          ],
          "Books": [
            Service(objectName: "Books", creator: "PersonA", description: "Book Service", isResolved: true,communityName: "Office",),
          ],
          "Speaker": [
            Service(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", isResolved: true,communityName: "Office",),
          ],
        },

        "Apartment": {
          "Car": [
            Service(objectName: "Car", creator: "PersonA", description: "Car Service", isResolved: true,communityName: "Apartment",),
          ],
          "Computer": [
            Service(objectName: "Computer", creator: "PersonA", description: "Computer Service", isResolved: true,communityName: "Apartment",),
          ],
          "TV": [
            Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: true,communityName: "Apartment",),
          ],
        }
      };



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
              // print("goin thru users and adding them");
              memberList.add(Member(name: group[j]["Name"],phone: group[j]["Phone Number"], isCreator: group[j]["isCreator"],));
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

        List<CommunityModel>? communitytemp=await UserDataBaseService.getCommunities(phoneNo);
        communitiesdb=communitytemp;

        for(int i=0;i<communitytemp!.length;i++){
          communities.add(communitytemp[i].name);
          notifyListeners();
          communityObjectMap[communitytemp[i].name] = [];
          communityObjectMapdb![communitytemp[i]] = [];

          objectUnresolvedExpenseMap[communitytemp[i].name] = {};
          objectUnresolvedExpenseMapdb![communitytemp[i]] = {};

          objectUnresolvedServices[communitytemp[i].name] = {};
          objectUnresolvedServiceMapdb![communitytemp[i]] = {};

          objectResolvedExpenseMap[communitytemp[i].name] = {};
          objectResolvedExpenseMapdb![communitytemp[i]] = {};

          objectResolvedServices[communitytemp[i].name] = {};
          objectResolvedServiceMapdb![communitytemp[i]] = {};
        }
        notifyListeners();

        for(int i=0;i<communitytemp.length;i++){
          String? communityID=await CommunityDataBaseService.getCommunityID(communitytemp[i]);
          List<ObjectsModel>? objecttemp=await ObjectDataBaseService.getObjects(communityID!);

          for(int j=0;j<objecttemp!.length;j++){
            communityObjectMap[communitytemp[i].name]!.add(objecttemp[j].name);
            communityObjectMapdb![communitytemp[i]]!.add(objecttemp[j]);


            objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectUnresolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]] = [];

            objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];
            objectUnresolvedServiceMapdb![communitytemp[i]]![objecttemp[j]] = [];

            objectResolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectResolvedExpenseMapdb![communitytemp[i]]![objecttemp[j]] = [];

            objectResolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];
            objectResolvedServiceMapdb![communitytemp[i]]![objecttemp[j]] = [];

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
            List<ServiceModel>? servicetemp=await ObjectDataBaseService.getServices(objecttemp[j]);

            for(int k=0;k<servicetemp.length;k++){
              if(servicetemp[k].resolverid==null){
                objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: await UserDataBaseService.getName(servicetemp[k].creatorID!),
                  description: servicetemp[k].name,
                  isResolved: false,
                ));

                objectUnresolvedServiceMapdb![communitytemp[i]]![objecttemp[j]]!.add(servicetemp[k]);
              }
              else{
                objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: await UserDataBaseService.getName(servicetemp[k].creatorID!),
                  description: servicetemp[k].name,
                  isResolved: true,
                ));

                objectResolvedServiceMapdb![communitytemp[i]]![objecttemp[j]]!.add(servicetemp[k]);
              }
            }
            notifyListeners();
          }
        }
        notifyListeners();
      }

      void deleteState(){
        communities=[];
        communityObjectMap={};
        objectUnresolvedExpenseMap={};
        objectUnresolvedServices={};
        objectResolvedExpenseMap={};
        objectResolvedServices={};
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

      void serviceListen(Service service){
        serviceIndex=objectUnresolvedServices[service.communityName]![service.objectName]!.indexOf(service);
        notifyListeners();
      }

      void addCommunity(String communityName){
        communities.add(communityName);
        communityObjectMap[communityName] = [];
        objectUnresolvedExpenseMap[communityName] = {};
        objectUnresolvedServices[communityName] = {};
        objectResolvedExpenseMap[communityName] = {};
        objectResolvedServices[communityName] = {};
        notifyListeners();

        CommunityModel community=CommunityModel(name: communityName,phoneNo: user!.phoneNo);
        CommunityDataBaseService.createCommunity(community);
        communitiesdb!.add(community);
        notifyListeners();
      }

      Future<void> addObject(String communityName, String objectName) async {
        communityObjectMap[communityName]!.add(objectName);
        objectUnresolvedExpenseMap[communityName]![objectName] = [];
        objectUnresolvedServices[communityName]![objectName] = [];
        objectResolvedExpenseMap[communityName]![objectName] = [];
        objectResolvedServices[communityName]![objectName] = [];

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

      Future<void> addService(String objectName, String creator, String description, String communityName)async {
        objectUnresolvedServices[communityName]![objectName]?.add(Service(objectName: objectName, creator: creator, description: description, isResolved: false, communityName: communityName));
        notifyListeners();
        CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==communityName);
        ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==objectName);
        String? objectID=await ObjectDataBaseService.getObjectID(otmp);
        ServiceModel service = ServiceModel(creatorID: await UserDataBaseService.getUserID(user!.phoneNo) ,name: description,objectID: objectID,resolverid: null, date: null,description: "");
        objectUnresolvedServiceMapdb![ctmp]![otmp]!.add(service);
        ServiceDataBaseService.createService(service);
      }

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

      void resolveService(Service service)
      {
        Service? item = objectUnresolvedServices[service.communityName]![service.objectName]?.firstWhere((element) => element.objectName == service.objectName && element.creator == service.creator && element.description == service.description);
        objectUnresolvedServices[service.communityName]![service.objectName]?.remove(item);
        objectResolvedServices[service.communityName]![service.objectName]?.add(Service(objectName: service.objectName, creator: service.creator, description: service.description, isResolved: true, communityName: service.communityName));
        notifyListeners();

        CommunityModel ctmp=communitiesdb!.firstWhere((element) => element.name==service.communityName);
        ObjectsModel? otmp = communityObjectMapdb![ctmp]!.firstWhere((element) => element.name==service.objectName);
        ServiceModel? stmp = objectUnresolvedServiceMapdb![ctmp]![otmp]!.firstWhere((element) => element.name==service.description);

        objectUnresolvedServiceMapdb![ctmp]![otmp]!.remove(stmp);

        stmp.resolverid=user!.phoneNo;
        objectResolvedServiceMapdb![ctmp]![otmp]!.add(stmp);
        ServiceDataBaseService.resolveService(stmp,user!.phoneNo);
      }

      addMembersToCommunity(String communityName, List<dynamic> names, List<dynamic> phones){
        for(int i=0;i<names.length;i++)
          {
            Member member = Member(name: names[i], phone: phones[i], isCreator: false,);
            if(!communityMembersMap[communityName]!.contains(member)) {
              communityMembersMap[communityName]!.add(member);
              }
          }
        notifyListeners();
      }

}