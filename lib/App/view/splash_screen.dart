// ignore_for_file: use_key_in_widget_constructors, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:helix_chat_app/App/view/chat_screen.dart';
import 'package:helix_chat_app/App/view/login_screen.dart';
import 'package:matrix/matrix.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen(this.client);
  Client client;
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    Future.delayed(const Duration(seconds: 3), () async {
      moveToNextPage();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset('images/splash_img.png',fit: BoxFit.cover),
    );
  }
  void moveToNextPage() async {
    widget.client.isLogged() ?  Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const RoomListPage())):
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

}
