import 'package:flutter/material.dart';
import 'package:rbc_interface/src/features/chat_box/app/chat_box.dart';
import 'package:rbc_interface/src/features/transcription/app/transcription.dart';

class LandingPage extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  void _navigateToPage(int pageIndex) {
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
        title: Text('Landing Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                ChatBox(),
                Transcription(),
              ],
            ),
          ),
          Container(
            color: Colors.blue, // Change color as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToPage(0),
                  child: Text('Chat Box'),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToPage(1),
                  child: Text('Transcription'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
