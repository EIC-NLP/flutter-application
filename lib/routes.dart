import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'package:rbc_interface/src/features/landing_page/app/landing_page.dart';
import 'package:rbc_interface/src/features/chat_box/app/chat_box.dart';
import 'package:rbc_interface/src/features/transcription/app/transcription.dart';

class Routes extends StatefulWidget {
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  final PageController _pageController = PageController(initialPage: 0);
    late final WebSocketChannel channel;

  @override
  void initState() {
    super.initState();

    // Connect to the WebSocket server
    channel = IOWebSocketChannel.connect('ws://127.0.0.1:5000/ws');

    // Listen for incoming messages
    channel.stream.listen((message) {
      Map<String, dynamic> data = jsonDecode(message);
      String page = data['page'];
      _navigateToPageByName(page);
    });
  }

  @override
  void dispose() {
    // Close the WebSocket connection when the widget is disposed
    channel.sink.close();
    super.dispose();
  }

  Future<void> sendControlData() async {
    final Map<String, dynamic> jsonData = {
      'page': 'chat',
      'command': 'append',
      'content': 'find me a bottle',
    };

    channel.sink.add(jsonEncode(jsonData));
  }

  void _navigateToPageByName(String pageName) {
    int pageIndex;
    switch (pageName) {
      case 'idle':
        pageIndex = 0;
        break;
      case 'llm':
        pageIndex = 1;
        break;
      case 'transcription':
        pageIndex = 2;
        break;
      default:
        pageIndex = 0; // Default to Landing Page if pageName is not recognized
        break;
    }
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: Text("Sponsors Stuff Here"),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                LandingPage(),
                ChatBox(),
                Transcription(),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[800]),
            ),
            onPressed: sendControlData,
            child: Text('Send Control Data', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}