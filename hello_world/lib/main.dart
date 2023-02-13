import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'provider/community_data_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(  
    // theme: FlexColorScheme.light(scheme: FlexScheme.bahamaBlue).toTheme,
    // themeMode: ThemeMode.system,
    MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CommunityDataProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
      // theme: FlexColorScheme.light(scheme: FlexScheme.bahamaBlue).toTheme,
      // themeMode: ThemeMode.system,
    );
  }
}