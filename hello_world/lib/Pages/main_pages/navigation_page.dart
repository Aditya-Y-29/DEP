import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';
import 'package:hello_world/Pages/main_pages/community_page.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import '../../components/community.dart';

class NavigationPage extends StatefulWidget {
  //const NavigationPage({Key? key}) : super(key: key);
  const NavigationPage({super.key});
  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int clickedCommunity = 0;
  String communityName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),

        child:AppBar(
          title: Text('Utility App'),

        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, communityDataProvider, child) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 95.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  color: Colors.green.shade50,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child : GestureDetector(
                  onTap: () {
                    // Handle item click
                  },
                  child: ListTile(
                    title: Text('Archieved',
                      style: TextStyle(
                          fontSize: 21.0),
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 170.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  color: Colors.green.shade50,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child : GestureDetector(
                  onTap: () {
                    // Handle item click
                  },
                  child: ListTile(
                    title: Text('Reminders', style: TextStyle(
                        fontSize: 21.0),
                    ),
                  ),
                ),
              ),
              ListView(
                  children:  List.of(communityDataProvider.communities.map((e) {
                    int k = communityDataProvider.communities.indexOf(e)+1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          int temp = 1 << (k-1);
                          if(clickedCommunity >> (k-1) & 1 == 1)
                            clickedCommunity = clickedCommunity ^ temp;
                          else{
                            clickedCommunity = 0;
                            clickedCommunity = clickedCommunity | temp;
                          }
                          communityName = e;
                        });
                      },
                      child:ListTile(
                        title: Text(e),
                      ),
                    );
                  }))
              ),

            ],
          );
        },
      ),




    );
  }
}


Route _createRoute(String communityName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CommunityPage(communityName: communityName),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}