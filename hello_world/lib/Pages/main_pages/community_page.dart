import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';
import 'package:provider/provider.dart';
import '../../components/object.dart';
import '../../provider/data_provider.dart';
import '../../components/community.dart';
import 'package:hello_world/Pages/main_pages/object_page.dart';
import 'package:hello_world/Pages/profile_pages/profile_page.dart';
import 'package:hello_world/Pages/main_pages/navigation_page.dart';

import '../add_from_pages/add_from_community_page.dart';
import '../group_member_pages/community_info_page.dart';


class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key, required this.communityName}) : super(key: key);
  final String communityName;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {

  int clickedObject = 0;
  String objectName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: clickedObject != 0 ? FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => ObjectPage(objectName: objectName, communityName: widget.communityName),
      //       ),
      //     );
      //   },
      //   backgroundColor: Colors.green,
      //   child: const Icon(Icons.arrow_forward_ios, size: 20,),
      // ) : null,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
            );
          },
        ),
        title: Text(widget.communityName),
        actions:  [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommunityInfo(communityName: widget.communityName,),
                  ),
                );
              },
              child: const Icon(Icons.group, size: 30,),
            )
          ),
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(1),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
                child:
                Container(
                  margin: const EdgeInsets.all(5),
                  // padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/avatar.png',
                    width: 30,
                    height: 30,
                    errorBuilder: ( context,  exception,  stackTrace) {
                        return Image.asset(
                              'assets/img1.png',
                              width: 30,
                              height: 30,
                            );                  
                    },
                  ),
                )
            )
          )
        ],
      ),
      body: Consumer<DataProvider>(
        builder: (context, objectDataProvider, child) {
          return Container(
            child: SingleChildScrollView(
              child:
                Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddFromCommunityPage(selectedPage: 0, communityName: widget.communityName),
                                      ),
                                    );
                                  },
                                  child: const Icon(Icons.check_circle_outline),
                                ),
                              ),
                              const Text(
                                "Resolve",
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddFromCommunityPage(selectedPage: 1, communityName: widget.communityName),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(8),
                                    child:  Row(
                                      children: const [
                                        Text("+"),
                                        Icon(Icons.currency_rupee_outlined),
                                      ],
                                    ),
                                  ),
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
                        // Container(
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       Container(
                        //         height: 50,
                        //         width: 50,
                        //         child: FloatingActionButton(
                        //           onPressed: () {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                 builder: (context) => AddFromCommunityPage(selectedPage: 2, communityName: widget.communityName),
                        //               ),
                        //             );
                        //           },
                        //           child: const Icon(Icons.home_repair_service),
                        //         ),
                        //       ),
                        //       const Text(
                        //         "Service",
                        //         style: TextStyle(
                        //           fontSize: 12,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AddFromCommunityPage(selectedPage: 2, communityName: widget.communityName)
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    child:  Row(
                                      children: const [
                                        Text("+"),
                                        Icon(Icons.data_object),
                                      ],
                                    ),
                                  ),
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
                      ],
                    ),
                  ),
                  Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: List.of(objectDataProvider.communityObjectMap[widget.communityName]!.map((e) {
                        int k = objectDataProvider.communityObjectMap[widget.communityName]!.indexOf(e) + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              int temp = 1 << (k-1);
                              if(clickedObject >> (k-1) & 1 == 1)
                                clickedObject = clickedObject ^ temp;
                              else {
                                clickedObject = 0;
                                clickedObject = clickedObject | temp;
                              }
                              objectName = e;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ObjectPage(objectName: objectName, communityName: widget.communityName),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            width: 150,
                            height: 150,
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.only(left: 20.0),
                            decoration: BoxDecoration(
                              color: (clickedObject >> (k-1) & 1) == 1 ? Colors.green.shade50 : Colors.grey.shade100,
                              border: Border.all(
                                color: (clickedObject >> (k-1) & 1) == 1 ? Colors.green : Colors.green.withOpacity(0),
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 15.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                  offset: Offset(
                                    1.0, // Move to right 5  horizontally
                                    1.0, // Move to bottom 5 Vertically
                                  ),
                                )
                              ],
                            ),
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            child: Object(
                              name: e,
                              communityName: widget.communityName,
                            ),
                          )
                        );
                      }))
                  ),
                ],
              )
            ),
          );
        },
      ),
    );
  }
}
