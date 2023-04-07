import 'package:flutter/material.dart';
import '../../provider/data_provider.dart';
import 'package:provider/provider.dart';

class LogsNotification extends StatefulWidget {
  const LogsNotification({Key? key, required this.communityName, required this.notification})
      : super(key: key);
  final String communityName;
  final List<String> notification;

  @override
  State<LogsNotification> createState() => _LogsNotification();
}

class _LogsNotification extends State<LogsNotification> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    List<String> notifications=widget.notification.reversed.toList();
    
    return Scaffold(
        appBar: AppBar(
          title: Text('Notification: ${widget.communityName}'),
        ),
        body: Container(
          child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(notifications[index]),
                  ),
                );
              }),
        ));
  }
}
