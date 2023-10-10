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
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _navigateToPage(0),
                  child: Text('Landing Page'),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToPage(1),
                  child: Text('Chat Box'),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToPage(2),
                  child: Text('Transcription'),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.lightBlue, // Different shade of blue
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Maybe more sponsers stuff here',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
