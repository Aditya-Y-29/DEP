import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/Pages/main_pages/home_page.dart';
import 'Pages/auth_pages/login_page.dart';
import 'provider/data_provider.dart';
import 'package:provider/provider.dart';

import 'Pages/auth_pages/phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'OpenSans',
          scaffoldBackgroundColor: Colors.green.shade50
        ),
        home: const MyPhone(),
      ),
    );
  }
}


