import 'package:flutter/material.dart';
import 'community.dart';
import 'add_community.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const MaterialApp(
    // theme: FlexColorScheme.light(scheme: FlexScheme.bahamaBlue).toTheme,
    // themeMode: ThemeMode.system,
    home: Home()
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Utility App'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Community>[
          Community(name: 'Home'),
          Community(name: 'College'),
          Community(name: 'Office'),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCommunity()),
          );
        },
        backgroundColor: Colors.red,
        child: const Text(
          '+',
          style: TextStyle(
            fontSize: 30.0
          )
        )
    ),
    );
  }
}



