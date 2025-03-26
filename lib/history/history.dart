import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, String>> historyData = [
    {'date': '2023-01-01', 'amount': '\$50', 'status': 'Paid'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Amount: ${historyData[index]['amount']}'),
            subtitle: Text('Status: ${historyData[index]['status']}'),
            trailing: Text('Date: ${historyData[index]['date']}'),
          );
        },
      ),
    );
  }
}
