import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_world/Pages/main_pages/home_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hello_world/constants.dart';
import 'package:hello_world/widgets/profile_list_item.dart';

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
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // theme: ThemeProvider.of(context),
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 896, width: 414, allowFontScaling: true);

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
            'Aditya',
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            'Aditya@gmail.com',
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),

        ],
      ),
    );

    // var themeSwitcher = ThemeSwitcher(
    //   builder: (context) {
    //     return AnimatedCrossFade(
    //       duration: Duration(milliseconds: 200),
    //       crossFadeState:
    //       ThemeProvider.of(context).brightness == Brightness.dark
    //           ? CrossFadeState.showFirst
    //           : CrossFadeState.showSecond,
    //       firstChild: GestureDetector(
    //         onTap: () =>
    //             ThemeSwitcher.of(context).changeTheme(theme: kLightTheme),
    //         child: Icon(
    //           LineAwesomeIcons.sun,
    //           size: 25,
    //         ),
    //       ),
    //       secondChild: GestureDetector(
    //         onTap: () =>
    //             ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme),
    //         child: Icon(
    //           LineAwesomeIcons.moon,
    //           size: 25,
    //         ),
    //       ),
    //     );
    //   },
    // );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SizedBox(width: kSpacingUnit.w * 0.1),
        // ======================================
        // IconButton(
        //   iconSize: 0,
        //   // color: Colors.black,
        //   onPressed: () {
        //     // ScaffoldMessenger.of(context).showSnackBar(
        //     //     SnackBar(content: Text('Icon button is pressed')));
        //     // Navigator.pop(context);
        //     // Navigator.pop(context);
        //     // Scaffold.of(context).openEndDrawer();
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => const MyHomePage()),
        //     // );
        //   },
        //   icon: Icon(
        //     LineAwesomeIcons.arrow_left,
        //     size: 25,
        //   ),
        // ),
        // --------------------------------------------------


        profileInfo,
        // themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    TextEditingController description1 = TextEditingController();
    TextEditingController description2= TextEditingController();
    TextEditingController description3 = TextEditingController();

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 4),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      // SizedBox(width: kSpacingUnit.w * 5),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Username',
                        ),
                        controller: description1,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'phone Number',
                        ),
                        controller: description2,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Email Id',
                        ),
                        controller: description3,
                      ),
                      SizedBox(height: 10,),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              // print(objectDropDown);
                              // providerCommunity.addExpense(objectDropDown, "Creator", int.parse(amountInvolved.text), description.text,communityDropDown);
                              // Navigator.pop(context);
                            },
                            child: const Icon(Icons.check),
                          )),
                      SizedBox(height: 80,),
                      ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Logout',
                        hasNavigation: false,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}