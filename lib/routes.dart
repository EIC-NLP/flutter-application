import 'package:flutter/material.dart';
import 'package:rbc_interface/src/features/landing_page/app/landing_page.dart';
import 'package:rbc_interface/src/features/chat_box/app/chat_box.dart';
import 'package:rbc_interface/src/features/transcription/app/transcription.dart';

class AppRoutes {
  static const String landingPage = '/';
  static const String chatBox = '/chat_box';
  static const String transcription = '/transcription';
}

class NavigatorHelper {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.landingPage:
        return MaterialPageRoute(builder: (_) => LandingPage());
      case AppRoutes.chatBox:
        return MaterialPageRoute(builder: (_) => ChatBox());
      case AppRoutes.transcription:
        return MaterialPageRoute(builder: (_) => Transcription());
      default:
        return MaterialPageRoute(builder: (_) => UnknownRoutePage());
    }
  }
}

class UnknownRoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown Route'),
      ),
      body: Center(
        child: Text('404 - Page not found'),
      ),
    );
  }
}
