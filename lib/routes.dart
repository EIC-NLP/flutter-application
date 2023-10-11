import 'package:flutter/material.dart';
import 'package:rbc_interface/src/features/landing_page/app/landing_page.dart';
import 'package:rbc_interface/src/features/chat_box/app/chat_box.dart';
import 'package:rbc_interface/src/features/transcription/app/transcription.dart';
class Routes extends StatelessWidget {
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
        backgroundColor: Colors.grey[800],
        title: Text("Sponsers Stuff Here"),
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
          Container(
            color: Colors.grey[700],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[800])),
                  onPressed: () => _navigateToPage(0),
                  child: Text('Landing Page', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[800])), 
                  onPressed: () => _navigateToPage(1),
                  child: Text('Chat Box', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[800])),
                  onPressed: () => _navigateToPage(2),
                  child: Text('Transcription', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}