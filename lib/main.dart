import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';
import 'register_with_roles.dart';
import 'profile.dart';
import 'challan_info.dart';
import 'payment.dart';
import 'history.dart';
import 'new_notifications.dart';
import 'location_tracking.dart';
import 'new_pdf_challan.dart';
import 'admin_panel.dart';
import 'home.dart';
import 'payment_handling_page.dart';
import 'reports_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Firebase initialization error: $e');
  }
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
        '/register': (context) => RegisterWithRolesPage(),
        '/profile': (context) => ProfilePage(),
        '/challan_info': (context) => ChallanInfoPage(),
        '/payment': (context) => PaymentPage(),
        '/payment_handling': (context) => PaymentHandlingPage(),
        '/reports': (context) => ReportsPage(),
        '/history': (context) => HistoryPage(),
        '/notifications': (context) => NewNotificationsPage(),
        '/location_tracking': (context) => LocationTracking(),
        '/pdf_challan': (context) => NewPDFChallan(),
        '/admin_panel': (context) => AdminPanel(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
