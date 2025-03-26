import 'package:flutter/material.dart';

class PaymentHandlingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Handling'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              // Add functionality to process payments
            },
            child: Text('Process Payment'),
          ),
          ElevatedButton(
            onPressed: () {
              // Add functionality to handle disputes
            },
            child: Text('Handle Disputes'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('Payment 1'),
                  subtitle: Text('Amount: \$10.00'),
                ),
                ListTile(
                  title: Text('Payment 2'),
                  subtitle: Text('Amount: \$20.00'),
                ),
                // Add more payment items as needed
              ],
            ),
          ),
        ],
      ),

    );
  }
}
