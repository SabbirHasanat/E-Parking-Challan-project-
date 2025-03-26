import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Add functionality to filter reports
            },
            child: Text('Filter Reports'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('User Activity Report'),
                  subtitle: Text('Details about user activities'),
                ),
                ListTile(
                  title: Text('Payment History Report'),
                  subtitle: Text('Details about payment transactions'),
                ),
                // Add more report items as needed
              ],
            ),
          ),
        ],
      ),

    );
  }
}
