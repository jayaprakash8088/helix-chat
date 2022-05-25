import 'package:flutter/material.dart';
import 'package:helix_chat_app/App/utils/string_constants.dart';
import 'package:helix_chat_app/App/view/login_screen.dart';
import 'package:helix_chat_app/App/view/splash_screen.dart';
import 'package:helix_chat_app/App/view_model/login_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginViewModel()),
    ],
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>  SplashScreen(),
        '/login': (context) =>  LoginScreen()
      },
    );
  }
}
