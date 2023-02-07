import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  final String name;
  const Community({ Key? key, required this.name }): super(key: key);
  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {

  Choice selectedOption = choices[0];
  handleSelect(Choice choice) {
    setState(() {
      selectedOption = choice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.red[400],
        // boxShadow: const [
        //   BoxShadow(
        //     color: Colors.grey,
        //     blurRadius: 15.0, // soften the shadow
        //     spreadRadius: 5.0, //extend the shadow
        //     offset: Offset(
        //       1.0, // Move to right 5  horizontally
        //       1.0, // Move to bottom 5 Vertically
        //     ),
        //   )
        // ],
      ),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: PopupMenuButton<Choice>(
                onSelected: handleSelect,
                itemBuilder: (BuildContext context) {
                  return choices.skip(0).map((Choice choice) {
                    return PopupMenuItem <Choice>(
                      value: choice,
                      child: Text(choice.name),
                    );
                  }).toList();
                },
                color: Colors.white,
              ),
            )
          ],
      ),
    );
  }
}


class Choice {
  final String name;
  const Choice({ required this.name});
}

const List<Choice> choices = <Choice> [
  Choice(name: 'Delete Community'),
  Choice(name: 'Do something else')
];

