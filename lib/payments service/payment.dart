import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Online Payment'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: cardNumberController,
              decoration: InputDecoration(labelText: 'Card Number'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: balanceController,
              decoration: InputDecoration(labelText: 'Balance'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (cardNumberController.text.isEmpty || 
                    passwordController.text.isEmpty || 
                    balanceController.text.isEmpty) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }
                
                // Simulate payment process
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment successful!')),
                );

                // Optionally clear the fields
                cardNumberController.clear();
                passwordController.clear();
                balanceController.clear();

              },
              child: Text('Pay'),
            ),
          ],
        ),
      ),
    );
  }
}
