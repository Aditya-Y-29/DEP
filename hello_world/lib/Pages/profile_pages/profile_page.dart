import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hello_world/constants.dart';
import 'package:hello_world/widgets/profile_list_item.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kLightTheme,
      child: Builder(
        builder: (context) {
          return ProfileScreen();
        },
      ),
    );
  }
}


class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);
    final providerCommunity = Provider.of<DataProvider>(context, listen: false);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 18,
            width: kSpacingUnit.w * 18,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 10,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 4,
                    width: kSpacingUnit.w * 5,
                    decoration: BoxDecoration(
                      color: Color(0xFFDCEDC8),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,

                      child: Icon(
                        LineAwesomeIcons.pen,
                        color: kDarkPrimaryColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            "${providerCommunity.user?.username}",
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            "${providerCommunity.user?.email}",
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),

        ],
      ),
    );


    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );


    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 4),
                header,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.green,
                      shadowColor: Colors.greenAccent,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      fixedSize: const Size(150, 5)
                  ),
                  onPressed: () {
                    providerCommunity.deleteState();
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: Text('Logout'),

                )
                // Expanded(
                // child: ListView(
                // children: <Widget>[
                //   TextFormField(
                //     // decoration: const InputDecoration(
                //     //   icon: Icon(Icons.edit),

                //     // ),
                //     initialValue: "UserName: ${providerCommunity.user?.username}",
                //   ),
                //   SizedBox(height: 10,),
                //   TextFormField(
                //     // decoration: const InputDecoration(
                //     //   icon: Icon(Icons.edit),
                //     //   hintText: 'phone Number',
                //     // ),
                //     initialValue: "Phone Number: ${providerCommunity.user?.phoneNo}",
                //   ),
                //   SizedBox(height: 10,),
                //   TextFormField(
                //     // decoration: const InputDecoration(
                //     //   icon: Icon(Icons.edit),
                //     //   hintText: 'Email Id',
                //     // ),
                //     initialValue: "Email Id: ${providerCommunity.user?.email}",
                //   ),
                //   SizedBox(height: 10,),
                //   // Container(
                //   //     margin: const EdgeInsets.only(top: 20.0),
                //   //     child: FloatingActionButton(
                //   //       onPressed: () {
                //   //       },
                //   //       child: const Icon(Icons.check),
                //   //     )),
                //   SizedBox(height: 80,),
                //   ProfileListItem(
                //     icon: LineAwesomeIcons.alternate_sign_out,
                //     text: 'Logout',
                //     hasNavigation: false,

                //   ),
                // ],
                // ),

                // )
              ],
            ),
          );
        },
      ),
    );
  }
}