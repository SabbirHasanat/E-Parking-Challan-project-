import 'package:flutter/material.dart';
import 'user_management.dart'; // Importing User Management Page
import 'reports_page.dart'; // Importing Reports Page
import 'payment_handling_page.dart'; // Importing Payment Handling Page

class AdminPanel extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Welcome to the Admin Panel', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagementPage()), // Navigate to User Management
                );
              },
              child: Text('Manage Users'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReportsPage()), // Navigate to Reports Page
                );
              },
              child: Text('View Reports'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentHandlingPage()), // Navigate to Payment Handling Page
                );
              },
              child: Text('Handle Payments'),
            ),
          ],
        ),
      ),
    );
  }
}
