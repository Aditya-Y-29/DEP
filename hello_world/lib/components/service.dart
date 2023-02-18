import 'package:flutter/material.dart';

class Service extends StatefulWidget {
  const Service({Key? key, required this.creator, required this.description, required this.isResolved}) : super(key: key);
  final String creator;
  final String description;
  final bool isResolved;

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ]
          ),
          if(!widget.isResolved)
            Icon(Icons.check_circle_outline, color: Colors.green, size: 35,),
        ],
      ),
    );
  }
}
