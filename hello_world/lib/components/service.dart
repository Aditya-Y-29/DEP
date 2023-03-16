import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class Service extends StatefulWidget {
  const Service({Key? key, required this.objectName, required this.creator, required this.description, required this.isResolved,required this.communityName}) : super(key: key);
  final String creator;
  final String description;
  final bool isResolved;
  final String objectName;
  final String communityName;

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {

    final providerCommunity = Provider.of<DataProvider>(context, listen: true);

    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.isResolved ? Colors.grey[100] : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 0.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.creator,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.description,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ]
          ),
          if(!widget.isResolved)
            GestureDetector(
              onTap: () {
                Service service = Service(
                  creator: widget.creator,
                  description: widget.description,
                  isResolved: false,
                  objectName: widget.objectName,
                  communityName: widget.communityName,
                );
                providerCommunity.resolveService(service);
              },
              child: const Icon(Icons.check_circle_outline, color: Colors.green, size: 35,),
            )
        ],
      ),
    );
  }
}
