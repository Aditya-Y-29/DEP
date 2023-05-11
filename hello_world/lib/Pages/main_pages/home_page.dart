import 'package:flutter/material.dart';
import 'package:hello_world/Notifications/notification_services.dart';
import 'package:hello_world/Pages/main_pages/community_page.dart';
import 'package:hello_world/Pages/profile_pages/profile_page.dart';
import 'package:provider/provider.dart';
import '../../components/community.dart';
import '../add_from_pages/add_home_page_floating_button.dart';
import '../../provider/data_provider.dart';
import 'package:hello_world/Pages/main_pages/navigation_page.dart';
import 'package:connectivity/connectivity.dart';
import 'no_internet_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int clickedCommunity = 0;
  String communityName = "";

  NotificationServices notificationServices = NotificationServices();
  
  @override
  void initState() {
    super.initState();
    notificationServices.RequestNotificationPermission();
    notificationServices.initlocalNotifications();
    notificationServices.firebaseInit();
    notificationServices.isTokenRefreshed();
    
    DataProvider tokenProvider =Provider.of<DataProvider>(context, listen: false);
    tokenProvider.addToken();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);
    return StreamBuilder<bool>(
      stream: connectivityStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!) {
            return buildScaffold(providerCommunity);
          } else {
            return const NoInternetPage();
          }
        } else {
          return buildScaffold(providerCommunity);
        }
      }
    );
  }
  buildScaffold(providerCommunity) {
    return
    Scaffold(

      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => NavigationPage()),
              );
            }
        ),
        title: const Text("Your Communities"),
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: CircleAvatar(
                  radius: 15,
                  // radius: kSpacingUnit.w * 10,
                  child: Text("${providerCommunity.user?.username[0]}",
                    style: TextStyle(fontSize: 20),),
                ),
              )
          )
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, communityDataProvider, child) {
          return Container(
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, top: 20, bottom: 20),
                        padding: const EdgeInsets.all(10),
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

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: FloatingActionButton(
                                      heroTag: "BTN-9",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AddFromHomePage(selectedPage: 0),
                                          ),
                                        );
                                      },
                                      backgroundColor: Colors.green,
                                      child: const Icon(Icons.add_home_work),
                                    ),
                                  ),
                                  const Text(
                                    "Community",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: FloatingActionButton(
                                        heroTag: "BTN-10",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFromHomePage(
                                                      selectedPage: 1),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.green,
                                        child: Container(
                                          margin: const EdgeInsets.all(5),
                                          child: Row(
                                            children: const [
                                              Text("+"),
                                              Icon(Icons.grid_view),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  const Text(
                                    "Add Object",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    child: FloatingActionButton(
                                        heroTag: "BTN-11",
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddFromHomePage(
                                                      selectedPage: 2),
                                            ),
                                          );
                                        },
                                        backgroundColor: Colors.green,
                                        child: Container(
                                          margin: const EdgeInsets.all(8),
                                          child: Row(
                                            children: const [
                                              Text("+"),
                                              Icon(Icons.currency_rupee_outlined),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  const Text(
                                    "Add Expense",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 20),
                        child:
                        TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              // clickedCommunity = 0;
                              communityName = "";
                            });
                          },
                        ),
                      ),
                      Column(
                          children:
                          communityDataProvider.communities.isEmpty ? [
                            Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 100),
                                child: Text(
                                  "Hey there! Welcome to UtilMan! Add your first community using the Add Community button above!",
                                  style: TextStyle(fontSize: 30),)
                            )
                          ] :
                          List.of(communityDataProvider.communities.map((e) {
                            if (!e.toLowerCase().contains(
                                searchController.text.toLowerCase().trim())) {
                              return SizedBox(height: 0,);
                            }
                            // int k = communityDataProvider.communities.indexOf(e)+1;
                            return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // int temp = 1 << (k-1);
                                    // if(clickedCommunity >> (k-1) & 1 == 1)
                                    //   clickedCommunity = clickedCommunity ^ temp;
                                    // else{
                                    //   clickedCommunity = 0;
                                    //   clickedCommunity = clickedCommunity | temp;
                                    // }
                                    communityName = e;
                                  });
                                  Navigator.of(context).push(
                                      _createRoute(communityName));
                                },
                                child: AnimatedContainer(
                                  width: 340,
                                  height: 100,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4.0, vertical: 4.0),
                                  padding: const EdgeInsets.only(top: 25.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Colors.green,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    // boxShadow: const [
                                    //   BoxShadow(
                                    //     color: Colors.grey,
                                    //     blurRadius: 15.0, // soften the shadow
                                    //     spreadRadius: 1.0, //extend the shadow
                                    //     offset: Offset(
                                    //       1.0, // Move to right 5  horizontally
                                    //       1.0, // Move to bottom 5 Vertically
                                    //     ),
                                    //   )
                                    // ],
                                  ),
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInOut,
                                  child: Community(
                                    creatorTuple: e,
                                  ),
                                )
                            );
                          })
                          )
                      )
                      // ),
                      // )
                    ],
                  )
              )
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade50,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(width: 16.0, height: 10,),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, bottom: 8, top: 4),
              child: FloatingActionButton(
                heroTag: "BTN-12",
                onPressed: () async {
                  DataProvider dataProvider =
                  Provider.of<DataProvider>(context, listen: false);
                  const snackbar1 = SnackBar(content: Text("Refreshing..."), duration: Duration(seconds: 10),);
                  ScaffoldMessenger.of(context).showSnackBar(snackbar1);
                  await dataProvider.getAllDetails(dataProvider.user!.phoneNo);
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                },
                child: Icon(Icons.sync),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Stream<bool> get connectivityStream =>
      Connectivity().onConnectivityChanged.map((ConnectivityResult result) {
        return result != ConnectivityResult.none;
      });

}

Route _createRoute(String communityName) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        CommunityPage(creatorTuple: communityName),
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