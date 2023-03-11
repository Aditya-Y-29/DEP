
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office", "Apartment"];
      int communitiesindex=0;

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Oven", "PC", "TV", "Fridge"],
        "Office": ["Chairs", "Books", "Speaker"],
        "Apartment": ["Car", "Computer", "TV"],
      };
    
      void dolistening( String communityName){
        communitiesindex=communities.indexOf(communityName);
        notifyListeners();
      }

      void addCommunity(String communityName){
        communities.add(communityName);
        communityObjectMap[communityName] = ["Obj_${communityName}_1", "Obj_${communityName}_2", "Obj_${communityName}_3"];
        notifyListeners();
      }

}