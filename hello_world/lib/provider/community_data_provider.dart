
import 'package:flutter/material.dart';

class CommunityDataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office","Work"];
      int len=3; 

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Obj_Home_1", "Obj_Home_1", "Obj_Home_1"],
        "Office": ["Obj_Office_1", "Obj_Office_1", "Obj_Office_1"],
        "Work": ["Obj_Work_1", "Obj_Work_1", "Obj_Work_1"],
      };

      void addCommunity(String communityName){
        communities.add(communityName);
        len+=1;
        communityObjectMap[communityName] = [];
        notifyListeners();
      }

}