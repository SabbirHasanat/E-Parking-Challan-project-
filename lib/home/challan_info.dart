import 'package:flutter/material.dart';

class ChallanInfoPage extends StatefulWidget {
  @override
  _ChallanInfoPageState createState() => _ChallanInfoPageState();
}

class _ChallanInfoPageState extends State<ChallanInfoPage> {
  // Placeholder data
  List<Map<String, String>> challanData = [
    {'date': '2023-01-01', 'violation': 'No Parking', 'fine': '\$50'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Challan Information'),
      ),
      body: ListView.builder(
        itemCount: challanData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Violation: ${challanData[index]['violation']}'),
            subtitle: Text('Fine: ${challanData[index]['fine']}'),
            trailing: Text('Date: ${challanData[index]['date']}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add challan functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
