import 'package:flutter/material.dart';
import 'package:hello_world/components/service.dart';

class ObjectServiceScreen extends StatefulWidget {
  const ObjectServiceScreen({Key? key}) : super(key: key);

  @override
  State<ObjectServiceScreen> createState() => _ObjectServiceScreenState();
}

class _ObjectServiceScreenState extends State<ObjectServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Service(creator: "Pranav", description: "Service", isResolved: false),
        Service(creator: "Akshat", description: "Repair", isResolved: false),
        Service(creator: "Deepika", description: "Speaker", isResolved: false),
        Container(
          margin: const EdgeInsets.all(5),
          child: Text(
            "Resolved Services",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        Service(creator: "Aditya", description: "Display", isResolved: true),
      ],
    );
  }
}
