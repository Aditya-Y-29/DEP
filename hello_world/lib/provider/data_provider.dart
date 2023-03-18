
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/Models/community.dart';
import 'package:hello_world/components/expense.dart';
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

      List<String> allUserPhones = ["8279833510", "8595939608", "8930448891", "9502201858"];

      List<String> communities = ["Home", "Office", "Apartment"];

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Oven", "PC", "TV", "Fridge"],
        "Office": ["Chairs", "Books", "Speaker"],
        "Apartment": ["Car", "Computer", "TV"],
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

      void getAlldetails(String phoneNo) async {

        List<CommunityModel>? communitytemp=await UserDataBaseService.getCommunities(phoneNo);

        for(int i=0;i<communitytemp!.length;i++){
          communities.add(communitytemp[i].name);
          communityObjectMap[communitytemp[i].name] = [];
          objectUnresolvedExpenseMap[communitytemp[i].name] = {};
          objectUnresolvedServices[communitytemp[i].name] = {};
          objectResolvedExpenseMap[communitytemp[i].name] = {};
          objectResolvedServices[communitytemp[i].name] = {};
        }

        for(int i=0;i<communitytemp.length;i++){
          String? communityID=await CommunityDataBaseService.getCommunityID(communitytemp[i]);
          List<ObjectsModel>? objecttemp=await ObjectDataBaseService.getObjects(communityID!);

          for(int j=0;j<objecttemp!.length;j++){
            communityObjectMap[communitytemp[i].name]!.add(objecttemp[j].name);
            objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];
            objectResolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name] = [];
            objectResolvedServices[communitytemp[i].name]![objecttemp[j].name] = [];

            List<ExpenseModel>? expensetemp=await ObjectDataBaseService.getExpenses(objecttemp[j]);
            
            for(int k=0;k<expensetemp.length;k++){
              if(expensetemp[k].resolverid==null){
                objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name]!.add(Expense(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: expensetemp[k].creatorID,
                  description: expensetemp[k].description,
                  isPaid: false,
                  amount: int.parse(expensetemp[k].amount),
                ));
              }
              else{
                objectUnresolvedExpenseMap[communitytemp[i].name]![objecttemp[j].name]!.add(Expense(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: expensetemp[k].creatorID,
                  description: expensetemp[k].description,
                  isPaid: true,
                  amount: int.parse(expensetemp[k].amount),
                ));
              }
            }

            List<ServiceModel>? servicetemp=await ObjectDataBaseService.getServices(objecttemp[j]);

            for(int k=0;k<servicetemp.length;k++){
              if(servicetemp[k].resolverid==null){
                objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: servicetemp[k].creatorID,
                  description: servicetemp[k].description,
                  isResolved: false,
                ));
              }
              else{
                objectUnresolvedServices[communitytemp[i].name]![objecttemp[j].name]!.add(Service(
                  communityName: communitytemp[i].name,
                  objectName: objecttemp[j].name,
                  creator: servicetemp[k].creatorID,
                  description: servicetemp[k].description,
                  isResolved: true,
                ));
              }
            }
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

        CommunityModel community=CommunityModel(name: communityName,phoneNo: user!.phoneNo);
        CommunityDataBaseService.createCommunity(community);
        notifyListeners();
      }

      Future<void> addObject(String communityName, String objectName) async {
        communityObjectMap[communityName]!.add(objectName);
        objectUnresolvedExpenseMap[communityName]![objectName] = [];
        objectUnresolvedServices[communityName]![objectName] = [];
        objectResolvedExpenseMap[communityName]![objectName] = [];
        objectResolvedServices[communityName]![objectName] = [];

        CommunityModel community=CommunityModel(name: communityName,phoneNo: user!.phoneNo);
        ObjectsModel object=ObjectsModel(name: objectName,communityID: await CommunityDataBaseService.getCommunityID(community),creatorPhoneNo: "",type: "",description: "");
        ObjectDataBaseService.createObjects(object);
        notifyListeners();
      }

      void addExpense(String objectName, String creator, int amount, String description, String communityName)
      {
        objectUnresolvedExpenseMap[communityName]![objectName]?.add(Expense(objectName: objectName, creator: creator, amount: amount, description: description, isPaid: false, communityName: communityName));
        // notifyListeners();
      }

      void addService(String objectName, String creator, String description, String communityName)
      {
        objectUnresolvedServices[communityName]![objectName]?.add(Service(objectName: objectName, creator: creator, description: description, isResolved: false, communityName: communityName));
        // notifyListeners();
      }

      void resolveExpense(Expense expense)
      {
        Expense? item = objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.firstWhere((element) => element.objectName == expense.objectName && element.creator == expense.creator && element.amount == expense.amount && element.description == expense.description);
        objectUnresolvedExpenseMap[expense.communityName]![expense.objectName]?.remove(item);
        objectResolvedExpenseMap[expense.communityName]![expense.objectName]?.add(Expense(objectName: expense.objectName, creator: expense.creator, amount: expense.amount, description: expense.description, isPaid: true, communityName: expense.communityName));
        notifyListeners();
      }

      void resolveService(Service service)
      {
        Service? item = objectUnresolvedServices[service.communityName]![service.objectName]?.firstWhere((element) => element.objectName == service.objectName && element.creator == service.creator && element.description == service.description);
        objectUnresolvedServices[service.communityName]![service.objectName]?.remove(item);
        objectResolvedServices[service.communityName]![service.objectName]?.add(Service(objectName: service.objectName, creator: service.creator, description: service.description, isResolved: true, communityName: service.communityName));
        notifyListeners();
      }

}