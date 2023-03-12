
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hello_world/components/expense.dart';
import 'package:hello_world/components/service.dart';

class DataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office", "Apartment"];
      int communitiesIndex=0;
      int objectIndex = 0;

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Oven", "PC", "TV", "Fridge"],
        "Office": ["Chairs", "Books", "Speaker"],
        "Apartment": ["Car", "Computer", "TV"],
      };

      Map<String, List<Expense>> objectUnresolvedExpenseMap = {
        "Oven": [
          Expense(creator: "PersonA", description: "Oven Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Oven Repair", amount: 1000, isPaid: false),
        ],
        "PC": [
          Expense(creator: "PersonA", description: "PC Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "PC Repair", amount: 1000, isPaid: false),
        ],
        "TV": [
          Expense(creator: "PersonA", description: "TV Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "TV Repair", amount: 1000, isPaid: false),
        ],
        "Fridge": [
          Expense(creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Fridge Repair", amount: 1000, isPaid: false),
        ],
        "Chairs": [
          Expense(creator: "PersonA", description: "Chair Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Chair Repair", amount: 1000, isPaid: false),
        ],
        "Books": [
          Expense(creator: "PersonA", description: "Book Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Book Repair", amount: 1000, isPaid: false),
        ],
        "Speaker": [
          Expense(creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Speaker Repair", amount: 1000, isPaid: false),
        ],
        "Car": [
          Expense(creator: "PersonA", description: "Car Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Car Repair", amount: 1000, isPaid: false),
        ],
        "Computer": [
          Expense(creator: "PersonA", description: "Computer Service", amount: 750, isPaid: false),
          Expense(creator: "PersonB", description: "Computer Repair", amount: 1000, isPaid: false),
        ],
      };

      Map<String, List<Expense>> objectResolvedExpenseMap = {
        "Oven": [
          Expense(creator: "PersonA", description: "Oven Service", amount: 750, isPaid: true),
        ],
        "PC": [
          Expense(creator: "PersonA", description: "PC Service", amount: 750, isPaid: true),
        ],
        "TV": [
          Expense(creator: "PersonA", description: "TV Service", amount: 750, isPaid: true),
        ],
        "Fridge": [
          Expense(creator: "PersonA", description: "Fridge Service", amount: 750, isPaid: true),
        ],
        "Chairs": [
          Expense(creator: "PersonA", description: "Chair Service", amount: 750, isPaid: true),
        ],
        "Books": [
          Expense(creator: "PersonA", description: "Book Service", amount: 750, isPaid: true),
        ],
        "Speaker": [
          Expense(creator: "PersonA", description: "Speaker Service", amount: 750, isPaid: true),
        ],
        "Car": [
          Expense(creator: "PersonA", description: "Car Service", amount: 750, isPaid: true),
        ],
        "Computer": [
          Expense(creator: "PersonA", description: "Computer Service", amount: 750, isPaid: true),
          ],
      };

      Map<String, List<Service>> objectUnresolvedServices = {
        "Oven": [
          Service(creator: "PersonA", description: "Oven Service", isResolved: false),
          Service(creator: "PersonB", description: "Oven Repair", isResolved: false),
        ],
        "PC": [
          Service(creator: "PersonA", description: "PC Service", isResolved: false),
          Service(creator: "PersonB", description: "PC Repair", isResolved: false),
        ],
        "TV": [
          Service(creator: "PersonA", description: "TV Service", isResolved: false),
          Service(creator: "PersonB", description: "TV Repair", isResolved: false),
        ],
        "Fridge": [
          Service(creator: "PersonA", description: "Fridge Service", isResolved: false),
          Service(creator: "PersonB", description: "Fridge Repair", isResolved: false),
        ],
        "Chairs": [
          Service(creator: "PersonA", description: "Chair Service", isResolved: false),
          Service(creator: "PersonB", description: "Chair Repair", isResolved: false),
        ],
        "Books": [
          Service(creator: "PersonA", description: "Book Service", isResolved: false),
          Service(creator: "PersonB", description: "Book Repair", isResolved: false),
        ],
        "Speaker": [
          Service(creator: "PersonA", description: "Speaker Service", isResolved: false),
          Service(creator: "PersonB", description: "Speaker Repair", isResolved: false),
        ],
        "Car": [
          Service(creator: "PersonA", description: "Car Service", isResolved: false),
          Service(creator: "PersonB", description: "Car Repair", isResolved: false),
        ],
        "Computer": [
          Service(creator: "PersonA", description: "Computer Service", isResolved: false),
          Service(creator: "PersonB", description: "Computer Repair", isResolved: false),
        ],
      };

      Map<String, List<Service>> objectResolvedServices = {
        "Oven": [
          Service(creator: "PersonA", description: "Oven Service", isResolved: true),
        ],
        "PC": [
          Service(creator: "PersonA", description: "PC Service", isResolved: true),
        ],
        "TV": [
          Service(creator: "PersonA", description: "TV Service", isResolved: true),
        ],
        "Fridge": [
          Service(creator: "PersonA", description: "Fridge Service", isResolved: true),
        ],
        "Chairs": [
          Service(creator: "PersonA", description: "Chair Service", isResolved: true),
        ],
        "Books": [
          Service(creator: "PersonA", description: "Book Service", isResolved: true),
        ],
        "Speaker": [
          Service(creator: "PersonA", description: "Speaker Service", isResolved: true),
        ],
        "Car": [
          Service(creator: "PersonA", description: "Car Service", isResolved: true),
        ],
        "Computer": [
          Service(creator: "PersonA", description: "Computer Service", isResolved: true),
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

      void addCommunity(String communityName){
        communities.add(communityName);
        communityObjectMap[communityName] = [];
        notifyListeners();
      }

      void addExpense(String objectName, String creator, int amount, String description)
      {
        objectUnresolvedExpenseMap[objectName]?.add(Expense(creator: creator, amount: amount, description: description, isPaid: false));
        // notifyListeners();
      }

      void addService(String objectName, String creator, String description)
      {
        objectUnresolvedServices[objectName]?.add(Service(creator: creator, description: description, isResolved: false));
        // notifyListeners();
      }

}