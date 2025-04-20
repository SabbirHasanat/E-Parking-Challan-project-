import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'analytics_dashboard_page.dart';
import 'live_violation_reporting_page.dart';
import 'fine_recommendation_page.dart';
import 'reminders_notifications_page.dart';
import 'chatbot_page.dart';
import 'reports_page.dart';
// import 'user_management.dart';
// import 'notifications.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool _isLoggingOut = false;

  Widget _buildDashboardOverviewCard(String title, String value, Color color) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      child: Container(
        padding: EdgeInsets.all(16),
        width: 160,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureButton(String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: 140,
      height: 140,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 60),
            SizedBox(height: 12),
            Flexible(
              child: Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          ElevatedButton(
            child: Text('Logout'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      _performLogout(context);
    }
  }

  Future<void> _performLogout(BuildContext context) async {
    setState(() {
      _isLoggingOut = true;
    });
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      setState(() {
        _isLoggingOut = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: \$e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Panel',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          _isLoggingOut
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : IconButton(
                  icon: Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () => _confirmLogout(context),
                ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildDashboardOverviewCard('Total Violations', '37', Colors.red),
                  _buildDashboardOverviewCard('Fines Collected', '\$4303', Colors.green),
                  _buildDashboardOverviewCard('Pending Payments', '7', Colors.orange),
                  _buildDashboardOverviewCard('Active Users', '4', Colors.blue),
                ],
              ),
              SizedBox(height: 40),
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  _buildFeatureButton('View Reports', Icons.report, () => _navigateTo(context, ReportsPage())),
                  _buildFeatureButton('Analytics Dashboard', Icons.analytics, () => _navigateTo(context, AnalyticsDashboardPage())),
                  _buildFeatureButton('Live Violation Reporting', Icons.traffic, () => _navigateTo(context, LiveViolationReportingPage())),
                  _buildFeatureButton('AI Fine Recommendation', Icons.gavel, () => _navigateTo(context, FineRecommendationPage())),
                  _buildFeatureButton('Reminders & Notifications', Icons.notifications_active, () => _navigateTo(context, RemindersNotificationsPage())),
                  _buildFeatureButton('Chatbot Support', Icons.chat, () => _navigateTo(context, ChatbotPage())),
                  // Uncomment and implement these pages as needed
                  // _buildFeatureButton('User & Role Management', Icons.group, () => _navigateTo(context, UserManagementPage())),
                  // _buildFeatureButton('Notifications & Alerts', Icons.notification_important, () => _navigateTo(context, NotificationsPage())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
