import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:rbc_interface/src/features/landing_page/app/landing_page.dart';
import 'package:rbc_interface/src/features/chat_box/app/chat_box.dart';
import 'package:rbc_interface/src/features/transcription/app/transcription.dart';

class Routes extends StatefulWidget {
  final int pageIndex;
  final StreamController<int> pageController;

  Routes({required this.pageIndex, required this.pageController});

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {
  late WebSocket _socket;
  String _currentPage = '';

  @override
  void initState() {
    super.initState();
    _connectToWebSocket();
  }

  Future<void> _connectToWebSocket() async {
    try {
      _socket = await WebSocket.connect('ws://127.0.0.1:6969');
      _socket.listen((data) {
        final message = jsonDecode(data);
        if (message['page'] != null) {
          setState(() {
            _currentPage = message['page'];
          });
        }
      });
    } catch (e) {
      print('Error connecting to WebSocket server: $e');
    }
  }

  @override
  void dispose() {
    _socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;

    if (_currentPage == 'landing') {
      pageIndex = 0;
    } else if (_currentPage == 'chat') {
      pageIndex = 1;
    } else if (_currentPage == 'transcription') {
      pageIndex = 2;
    }

    return StreamBuilder<int>(
      initialData: widget.pageIndex,
      stream: widget.pageController.stream,
      builder: (context, snapshot) {
        return IndexedStack(
          index: pageIndex, // Use pageIndex instead of snapshot.data
          children: [
            LandingPage(),
            ChatBox(),
            Transcription(),
            Center(
              child: Text(_currentPage),
            ),
          ],
        );
      },
    );
  }
}
