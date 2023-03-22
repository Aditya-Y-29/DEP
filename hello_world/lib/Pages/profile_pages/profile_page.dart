import 'package:flutter/material.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hello_world/constants.dart';
import 'package:hello_world/widgets/profile_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

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


    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    TextEditingController userNameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();

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
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Username',
                        ),
                        controller: userNameController,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'phone Number',
                        ),
                        controller: phoneNumberController,
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.edit),
                          hintText: 'Email Id',
                        ),
                        controller: emailController,
                      ),
                      SizedBox(height: 10,),
                      Container(
                          margin: const EdgeInsets.only(top: 20.0),
                          child: FloatingActionButton(
                            onPressed: () {
                            },
                            child: const Icon(Icons.check),
                          )),
                      SizedBox(height: 80,),
                      ElevatedButton(child: Text("Logout"),onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);

                      })
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