
import 'package:flutter/material.dart';

class CommunityDataProvider extends ChangeNotifier{
      List<String> communities = ["Home", "Office","Work"];
      int len=3; 

      void addCommunity(String communityName){
        communities.add(communityName);
        len+=1;
        notifyListeners();
      }

}