
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office","Work"];
      int len=3; 

      int communitiesindex=0;

      Map<String, List<String>> communityObjectMap = {
        "Home": ["Obj_Home_1", "Obj_Home_2", "Obj_Home_3"],
        "Office": ["Obj_Office_1", "Obj_Office_2", "Obj_Office_3"],
        "Work": ["Obj_Work_1", "Obj_Work_2", "Obj_Work_3"],
      };
    
      void dolistening( String communityName){
        communitiesindex=communities.indexOf(communityName);
        notifyListeners();
      }

      void addCommunity(String communityName){
        communities.add(communityName);
        len+=1;
        communityObjectMap[communityName] = ["Obj_${communityName}_1", "Obj_${communityName}_2", "Obj_${communityName}_3"];
        notifyListeners();
      }

}