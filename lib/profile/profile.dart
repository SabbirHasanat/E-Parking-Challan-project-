import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController vehicleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Management'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: vehicleController,
              decoration: InputDecoration(labelText: 'Vehicle Information'),
            ),
            TextField(
              controller: contactController,
              decoration: InputDecoration(labelText: 'Contact Details'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement remove functionality
              },
              child: Text('Remove'),
            ),
          ],
        ),
      ),
    );
  }
}
