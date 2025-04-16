import 'package:flutter/material.dart';
import 'location_tracking.dart'; // Importing location tracking
import 'new_pdf_challan.dart'; // Importing PDF generation
import 'new_notifications.dart'; // Importing notifications
import 'payment_handling_page.dart'; // Importing payment handling
import 'auth_service.dart'; // Importing AuthService for logout functionality

class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Recommended: super.key for StatelessWidget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Navigation',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('User Management'),
              onTap: () {
                Navigator.pushNamed(context, '/user_management');
              },
            ),
            ListTile(
              title: const Text('Reports'),
              onTap: () {
                Navigator.pushNamed(context, '/reports');
              },
            ),
            ListTile(
              title: const Text('Payment Handling'),
              onTap: () {
                Navigator.pushNamed(context, '/payment_handling');
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                AuthService().logout(); // Call the logout method
                Navigator.pushReplacementNamed(context, '/login'); // Navigate to login page
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Welcome to the E-Parking Challan App!', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPDFChallan()), // Navigate to PDF generation
                );
              },
              child: const Text('Generate PDF'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocationTracking()), // Navigate to location tracking
                );
              },
              child: const Text('Trace Location'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewNotificationsPage()), // Navigate to notifications
                );
              },
              child: const Text('View Notifications'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to challan management page (to be implemented)
              },
              child: const Text('Manage Challan'),
            ),
          ],
        ),
      ),
    );
  }
}
