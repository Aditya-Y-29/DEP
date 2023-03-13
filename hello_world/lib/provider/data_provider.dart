
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/service.dart';

class DataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office", "Apartment"];
      int communitiesIndex=0;
      int objectIndex = 0;
      int expenseIndex = 0;
      int serviceIndex = 0;

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Oven", "PC", "TV", "Fridge"],
        "Office": ["Chairs", "Books", "Speaker"],
        "Apartment": ["Car", "Computer", "TV"],
      };

      Map<String, List<Expense>> objectUnresolvedExpenseMap = {
        "Oven": [
          Expense(objectName: "Oven", creator: "PersonA", description: "Oven Service", amount: 750, isPaid: false),
          Expense(objectName: "Oven", creator: "PersonB", description: "Oven Repair", amount: 1000, isPaid: false),
        ],
        "PC": [
          Expense(objectName: "PC", creator: "PersonA", description: "PC Service", amount: 750, isPaid: false),
          Expense(objectName: "PC", creator: "PersonB", description: "PC Repair", amount: 1000, isPaid: false),
        ],
        "TV": [
          Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: false),
          Expense(objectName: "TV", creator: "PersonB", description: "TV Repair", amount: 1000, isPaid: false),
        ],
        "Fridge": [
          Expense(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: false),
          Expense(objectName: "Fridge", creator: "PersonB", description: "Fridge Repair", amount: 1000, isPaid: false),
        ],
        "Chairs": [
          Expense(objectName: "Chairs", creator: "PersonA", description: "Chair Service", amount: 750, isPaid: false),
          Expense(objectName: "Chairs", creator: "PersonB", description: "Chair Repair", amount: 1000, isPaid: false),
        ],
        "Books": [
          Expense(objectName: "Books", creator: "PersonA", description: "Book Service", amount: 750, isPaid: false),
          Expense(objectName: "Books", creator: "PersonB", description: "Book Repair", amount: 1000, isPaid: false),
        ],
        "Speaker": [
          Expense(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: false),
          Expense(objectName: "Speaker", creator: "PersonB", description: "Speaker Repair", amount: 1000, isPaid: false),
        ],
        "Car": [
          Expense(objectName: "Car", creator: "PersonA", description: "Car Service", amount: 750, isPaid: false),
          Expense(objectName: "Car", creator: "PersonB", description: "Car Repair", amount: 1000, isPaid: false),
        ],
        "Computer": [
          Expense(objectName: "Computer", creator: "PersonA", description: "Computer Service", amount: 750, isPaid: false),
          Expense(objectName: "Computer", creator: "PersonB", description: "Computer Repair", amount: 1000, isPaid: false),
        ],
      };

      Map<String, List<Expense>> objectResolvedExpenseMap = {
        "Oven": [
          Expense(objectName: "Oven", creator: "PersonA", description: "Oven Service", amount: 750, isPaid: true),
        ],
        "PC": [
          Expense(objectName: "PC", creator: "PersonA", description: "PC Service", amount: 750, isPaid: true),
        ],
        "TV": [
          Expense(objectName: "TV", creator: "PersonA", description: "TV Service", amount: 750, isPaid: true),
        ],
        "Fridge": [
          Expense(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: true),
        ],
        "Chairs": [
          Expense(objectName: "Chairs", creator: "PersonA", description: "Chair Service", amount: 750, isPaid: true),
        ],
        "Books": [
          Expense(objectName: "Books", creator: "PersonA", description: "Book Service", amount: 750, isPaid: true),
        ],
        "Speaker": [
          Expense(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: true),
        ],
        "Car": [
          Expense(objectName: "Car", creator: "PersonA", description: "Car Service", amount: 750, isPaid: true),
        ],
        "Computer": [
          Expense(objectName: "Computer", creator: "PersonA", description: "Computer Service", amount: 750, isPaid: true),
        ],

      };

      Map<String, List<Service>> objectUnresolvedServices = {
        "Oven": [
          Service(objectName: "Oven", creator: "PersonA", description: "Oven Service", isResolved: false),
          Service(objectName: "Oven", creator: "PersonB", description: "Oven Repair", isResolved: false),
        ],
        "PC": [
          Service(objectName: "PC", creator: "PersonA", description: "PC Service", isResolved: false),
          Service(objectName: "PC", creator: "PersonB", description: "PC Repair", isResolved: false),
        ],
        "TV": [
          Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: false),
          Service(objectName: "TV", creator: "PersonB", description: "TV Repair", isResolved: false),
        ],
        "Fridge": [
          Service(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", isResolved: false),
          Service(objectName: "Fridge", creator: "PersonB", description: "Fridge Repair", isResolved: false),
        ],
        "Chairs": [
          Service(objectName: "Chairs", creator: "PersonA", description: "Chair Service", isResolved: false),
          Service(objectName: "Chairs", creator: "PersonB", description: "Chair Repair", isResolved: false),
        ],
        "Books": [
          Service(objectName: "Books", creator: "PersonA", description: "Book Service", isResolved: false),
          Service(objectName: "Books", creator: "PersonB", description: "Book Repair", isResolved: false),
        ],
        "Speaker": [
          Service(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", isResolved: false),
          Service(objectName: "Speaker", creator: "PersonB", description: "Speaker Repair", isResolved: false),
        ],
        "Car": [
          Service(objectName: "Car", creator: "PersonA", description: "Car Service", isResolved: false),
          Service(objectName: "Car", creator: "PersonB", description: "Car Repair", isResolved: false),
        ],
        "Computer": [
          Service(objectName: "Computer", creator: "PersonA", description: "Computer Service", isResolved: false),
          Service(objectName: "Computer", creator: "PersonB", description: "Computer Repair", isResolved: false),
        ],

      };

      Map<String, List<Service>> objectResolvedServices = {
        "Oven": [
          Service(objectName: "Oven", creator: "PersonA", description: "Oven Service", isResolved: true),
        ],
        "PC": [
          Service(objectName: "PC", creator: "PersonA", description: "PC Service", isResolved: true),
        ],
        "TV": [
          Service(objectName: "TV", creator: "PersonA", description: "TV Service", isResolved: true),
        ],
        "Fridge": [
          Service(objectName: "Fridge", creator: "PersonA", description: "Fridge Service", isResolved: true),
        ],
        "Chairs": [
          Service(objectName: "Chairs", creator: "PersonA", description: "Chair Service", isResolved: true),
        ],
        "Books": [
          Service(objectName: "Books", creator: "PersonA", description: "Book Service", isResolved: true),
        ],
        "Speaker": [
          Service(objectName: "Speaker", creator: "PersonA", description: "Speaker Service", isResolved: true),
        ],
        "Car": [
          Service(objectName: "Car", creator: "PersonA", description: "Car Service", isResolved: true),
        ],
        "Computer": [
          Service(objectName: "Computer", creator: "PersonA", description: "Computer Service", isResolved: true),
        ],
      };
    
      void communityListen( String communityName){
        communitiesIndex=communities.indexOf(communityName);
        notifyListeners();
      }

      void objectListen( String communityName, String objectName){
        objectIndex=communityObjectMap[communityName]!.indexOf(objectName);
        notifyListeners();
      }

      void expenseListen(Expense expense){
        expenseIndex=objectUnresolvedExpenseMap[expense.objectName]!.indexOf(expense);
        notifyListeners();
      }

      void serviceListen(Service service){
        serviceIndex=objectUnresolvedServices[service.objectName]!.indexOf(service);
        notifyListeners();
      }

      void addCommunity(String communityName){
        communities.add(communityName);
        communityObjectMap[communityName] = [];
        notifyListeners();
      }

      void addObject(String communityName, String objectName)
      {
        communityObjectMap[communityName]!.add(objectName);
        objectUnresolvedExpenseMap[objectName] = [];
        objectUnresolvedServices[objectName] = [];
        objectResolvedExpenseMap[objectName] = [];
        objectResolvedServices[objectName] = [];
      }

      void addExpense(String objectName, String creator, int amount, String description)
      {
        objectUnresolvedExpenseMap[objectName]?.add(Expense(objectName: objectName, creator: creator, amount: amount, description: description, isPaid: false));
        // notifyListeners();
      }

      void addService(String objectName, String creator, String description)
      {
        objectUnresolvedServices[objectName]?.add(Service(objectName: objectName, creator: creator, description: description, isResolved: false));
        // notifyListeners();
      }

      void resolveExpense(Expense expense)
      {
        Expense? item = objectUnresolvedExpenseMap[expense.objectName]?.firstWhere((element) => element.objectName == expense.objectName && element.creator == expense.creator && element.amount == expense.amount && element.description == expense.description);
        objectUnresolvedExpenseMap[expense.objectName]?.remove(item);
        objectResolvedExpenseMap[expense.objectName]?.add(Expense(objectName: expense.objectName, creator: expense.creator, amount: expense.amount, description: expense.description, isPaid: true));
      }

      void resolveService(Service service)
      {
        Service? item = objectUnresolvedServices[service.objectName]?.firstWhere((element) => element.objectName == service.objectName && element.creator == service.creator && element.description == service.description);
        objectUnresolvedServices[service.objectName]?.remove(item);
        objectResolvedServices[service.objectName]?.add(Service(objectName: service.objectName, creator: service.creator, description: service.description, isResolved: true));
      }

}