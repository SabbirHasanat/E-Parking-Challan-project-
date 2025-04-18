import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'payment_service.dart';

class PaymentHandlingPage extends StatefulWidget {
  @override
  _PaymentHandlingPageState createState() => _PaymentHandlingPageState();
}

class _PaymentHandlingPageState extends State<PaymentHandlingPage> {
  final PaymentService _paymentService = PaymentService();
  User? _currentUser;
  List<Map<String, dynamic>> _payments = [];
  bool _isLoading = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _finedIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _loadPayments();
  }

  Future<void> _loadPayments() async {
    if (_currentUser != null) {
      try {
        final payments = await _paymentService.getPayments(_currentUser!.uid);
        setState(() {
          _payments = payments;
          _isLoading = false;
        });
      } catch (e) {
        print('Error loading payments: $e');
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _pay() async {
    if (_formKey.currentState!.validate() && _currentUser != null) {
      try {
        final newPayment = {
          'fineId': _finedIdController.text,
          'name': _nameController.text,
          'cardNumber': _cardNumberController.text,
          'amount': double.tryParse(_amountController.text) ?? 0,
          'password': _passwordController.text,
          'status': 'paid',
          'timestamp': DateTime.now().toIso8601String(),
        };
        await _paymentService.addPayment(_currentUser!.uid, newPayment);
        _finedIdController.clear();
        _nameController.clear();
        _cardNumberController.clear();
        _amountController.clear();
        _passwordController.clear();
        print('Payment done successfully');
        await _loadPayments();
      } catch (e) {
        print('Error processing payment: $e');
      }
    }
  }

  Future<void> _deletePayment(String paymentId) async {
    if (_currentUser != null) {
      try {
        await _paymentService.deletePayment(_currentUser!.uid, paymentId);
        print('Payment deleted successfully');
        await _loadPayments();
      } catch (e) {
        print('Error deleting payment: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Handling'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _finedIdController,
                            decoration: InputDecoration(labelText: 'Fine ID'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter fined ID';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _cardNumberController,
                            decoration: InputDecoration(labelText: 'Card Number'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your card number';
                              }
                              if (value.length < 12) {
                                return 'Card number must be at least 12 digits';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(labelText: 'Amount'),
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _pay,
                            child: Text('Pay'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _payments.length,
                      itemBuilder: (context, index) {
                        final payment = _payments[index];
                        return ListTile(
                          title: Text('Payment ${index + 1} - \$${payment['amount']}'),
                          subtitle: Text('Fined ID: ${payment['finedId']} - Name: ${payment['name']}'),
                          trailing: ElevatedButton(
                            onPressed: () => _deletePayment(payment['id']),
                            child: Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
