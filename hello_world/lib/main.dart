import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/home_page.dart';
import 'Pages/auth_pages/phone.dart';
import 'provider/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var isLoggedIn = await getLoginState();
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final String? isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'OpenSans',
          scaffoldBackgroundColor: Colors.green.shade50,
        ),
        debugShowCheckedModeBanner: false,
        home: isLoggedIn == null ? const MyPhone() : const MyHomePage(),
        routes: {
        '/home': (context) => const MyHomePage(),
      },
      ),
    );
  }
}

void saveLoginState(String phone) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('login', "yes");
  prefs.setString('phone', phone);
}

Future<String?> getLoginState() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //uncomment this line and restart to logout, then comment it again
  // prefs.clear();
  String? login = prefs.getString('login');
  return login;
}

void logoutAndClearPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

