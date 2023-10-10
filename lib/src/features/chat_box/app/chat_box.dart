import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Box'),
      ),
      body: Center(
        child: Text('This is the Chat Box Page!'),
      ),
    );
  }
}
