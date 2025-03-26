import 'package:flutter/material.dart';

class NewNotificationsPage extends StatefulWidget {
  final List<String> notifications = []; // List to hold notifications

  @override
  _NewNotificationsPageState createState() => _NewNotificationsPageState();
}

class _NewNotificationsPageState extends State<NewNotificationsPage> {
  void addNotification(String notification) { // Method to add notifications
    setState(() {
      widget.notifications.add(notification);
    });
  }

  @override
  void initState() {
    super.initState();
    // Example of adding a notification for unpaid fines
    addNotification('Unpaid fine for parking violation on 2025-01-01');
  }

  @override
  Widget build(BuildContext context) { // Build method for the UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.notifications[index]),
          );
        },
      ),
    );
  }
}
