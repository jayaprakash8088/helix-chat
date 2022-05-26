// ignore_for_file: use_key_in_widget_constructors, implementation_imports

import 'package:flutter/material.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:helix_chat_app/App/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
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
    return Container();
  }
  void moveToNextPage() async {
//    var isLoggedUser = await sharedPreferences.isLoggedUser();
//    if (isLoggedUser != null && isLoggedUser) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
//    } else {
//      Navigator.pushReplacement(
//          context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
    }

}
