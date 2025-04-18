import 'package:flutter/material.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot Support'),
      ),
      body: Center(
        child: Text(
          'Chatbot support features will be implemented here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
