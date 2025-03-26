import 'package:flutter/material.dart';
import 'login.dart';
import 'register_with_roles.dart'; // Ensure the correct import for the new registration page
import 'profile.dart';
import 'challan_info.dart';
import 'payment.dart';
import 'history.dart';
import 'new_notifications.dart';
import 'location_tracking.dart';
import 'new_pdf_challan.dart';
import 'admin_panel.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Parking Challan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterWithRolesPage(), // Updated to use the new registration page




        '/profile': (context) => ProfilePage(),
        '/challan_info': (context) => ChallanInfoPage(),
        '/payment': (context) => PaymentPage(),
        '/history': (context) => HistoryPage(),
        '/notifications': (context) => NewNotificationsPage(), // Updated to use the new notifications page




        '/location_tracking': (context) => LocationTracking(), // Route for location tracking
        '/pdf_challan': (context) => NewPDFChallan(), // Route for PDF generation
        '/admin_panel': (context) => AdminPanel(), // Admin panel route


        '/home': (context) => HomePage(),
      },
    );
  }
}
