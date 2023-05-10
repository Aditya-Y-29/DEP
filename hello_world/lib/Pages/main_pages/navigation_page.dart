import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/community_page.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  //const NavigationPage({Key? key}) : super(key: key);
  const NavigationPage({super.key});
  @override
  NavigationPageState createState() => NavigationPageState();
}

class NavigationPageState extends State<NavigationPage> {
  int clickedCommunity = 0;
  String communityName = "";
  Random random = Random();
  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),

        child:AppBar(
          title: Text('Navigation'),

        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, communityDataProvider, child) {
          return Column(
            children: [
              Container(
                height: 50,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
                padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0, bottom: 0.0),
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.green,
                    width: 1,
                  ),
                  color: Colors.green.shade50,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 2,
                      spreadRadius: 0,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child : GestureDetector(
                  onTap: () {
                    // Handle item click
                  },
                  child: ListTile(
                    tileColor: Colors.green,
                    title: Row(
                      children: [
                        Text('Teleport anywhere!',

                          style: TextStyle(
                            fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.green,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                          color: Colors.green,
                        ),
                      ]
                    )
                  ),
                ),
              ),
              Divider(
                  color: Colors.green
              ),
              Expanded(
                child:
                SingleChildScrollView(
                  child:
                    Column(
                        children:  List.of(communityDataProvider.communities.map((e) {
                          int k = communityDataProvider.communities.indexOf(e)+1;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                communityName = e;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.green,
                                  width: 1,
                                ),
                                color: Colors.green.shade50,
                              ),
                                child: IntrinsicHeight(
                                  child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                    Expanded(
                                      child: FloatingActionButton(
                                        heroTag: "${random.nextInt(1000000)}",
                                        elevation: 0,
                                        onPressed: () {

                                          Navigator.of(context).pushAndRemoveUntil(
                                            _createRoute(e),
                                            ModalRoute.withName('/home'),
                                          );

                                        },
                                        child:ListTile(
                                          leading: Image.asset('${providerCommunity.extractCommunityImagePathByName(e)}',
                                            width: 45,
                                          ),
                                          tileColor: Colors.green.shade50,
                                          title: Text(e.split(":")[0] + " - " + providerCommunity.communityMembersMap[e]!.firstWhere((member) => member.phone == (e).split(":")[1], orElse: () => providerCommunity.communityMembersMap[e]!.firstWhere((member) => member.isCreator == true)).name),
                                        ),),
                                    ),
                                  ]),
                                ),  // margin: const EdgeInsets.only(top: 20.0),
                            ),
                          );
                        }
                        ))
                    ),
                )
              )
            ],
          );
        },
      ),




    );
  }
}


Route _createRoute(String communityName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => CommunityPage(creatorTuple: communityName),
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