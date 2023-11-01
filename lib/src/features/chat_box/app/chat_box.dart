import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rbc_interface/routes.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  Timer? _inactiveTimer;

  @override
  void initState() {
    super.initState();
    _startInactiveTimer();
  }

  @override
  void dispose() {
    _inactiveTimer?.cancel();
    super.dispose();
  }

  void _startInactiveTimer() {
  _inactiveTimer = Timer(Duration(seconds: 15), () {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Routes(
          pageIndex: 0, // Replace with the initial page index
          pageController: StreamController<int>.broadcast(), // Replace with your StreamController
        )),
      );
    }
  });
}


  void _resetInactiveTimer() {
    _inactiveTimer?.cancel();
    _startInactiveTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _resetInactiveTimer,
        child: Chat(messages: _messages, onSendPressed: _handleSendPressed, user: _user),
      ),
    );
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );

    _addMessage(textMessage);
    _resetInactiveTimer(); // Reset the timer on send
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}