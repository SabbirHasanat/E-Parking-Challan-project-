import 'package:flutter/material.dart';

class RemindersNotificationsPage extends StatelessWidget {
  const RemindersNotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Reminders & Notifications'),
      ),
      body: Center(
        child: Text(
          'Smart reminders and notifications features will be implemented here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
