import 'package:flutter/material.dart';
import 'community.dart';
import 'add_expense_service_community.dart';
// import 'package:flex_color_scheme/flex_color_scheme.dart';

// class Home extends StatelessWidget {
//   const Home({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Utility App'),
//         centerTitle: true,
//         backgroundColor: Colors.red,
//       ),
//       body: GridView.count(
//         crossAxisCount: 2,
//         children: const <Community>[
//           Community(name: 'Home'),
//           Community(name: 'College'),
//           Community(name: 'Office'),
//         ],
//       ),  
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const AddCommunity()),
//           );
//         },
//         backgroundColor: Colors.red,
//         child: const Text(
//           '+',
//           style: TextStyle(
//             fontSize: 30
//           )
//         )
//     ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> items = ["Home", "Office"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Communities"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio:  3,
        children: List.generate(items.length, (index) {
          return Community(name: items[index],);
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddExpenseServiceCommunity()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

