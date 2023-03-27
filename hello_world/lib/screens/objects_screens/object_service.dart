// import 'package:flutter/material.dart';
// import 'package:hello_world/components/service.dart';
// import 'package:hello_world/provider/data_provider.dart';
// import 'package:provider/provider.dart';

// class ObjectServiceScreen extends StatefulWidget {
//   const ObjectServiceScreen({Key? key, required this.objectName, required this.communityName}) : super(key: key);
//   final String objectName;
//   final String communityName;

//   @override
//   State<ObjectServiceScreen> createState() => _ObjectServiceScreenState();
// }

// class _ObjectServiceScreenState extends State<ObjectServiceScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<DataProvider>(
//       builder: (context, objectDataProvider, child) {
//         return Column(
//             children: [
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: List.of(objectDataProvider.objectUnresolvedServices[widget.communityName]![widget.objectName] as Iterable<Widget>)
//               ),
//               Container (
//                 padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
//                 child: const Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Resolved Services",
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//               ),
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: List.of(objectDataProvider.objectResolvedServices[widget.communityName]![widget.objectName] as Iterable<Widget>)
//               ),
//             ]
//         );
//       },
//     );
//   }
// }
