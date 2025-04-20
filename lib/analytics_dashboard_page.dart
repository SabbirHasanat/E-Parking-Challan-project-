import 'package:flutter/material.dart';

class AnalyticsDashboardPage extends StatelessWidget {
  const AnalyticsDashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analytics Dashboard'),
      ),
      body: Center(
        child: Text(
          'Analytics dashboard features will be implemented here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
