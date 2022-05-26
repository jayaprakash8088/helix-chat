// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:helix_chat_app/App/view/chat_screen.dart';
import 'package:helix_chat_app/App/view_model/login_view_model.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel=Provider.of<LoginViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: viewModel.usernameTextField,
              autocorrect: false,
            style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: viewModel.passwordTextField,
              autocorrect: false,
              obscureText: true
                ,style: TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: (){
                  _login(viewModel);
                },
               child: const Text('Login',style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _login(LoginViewModel viewModel) async {
//    setState(() {
//      _loading = true;
//    });
    try {
      final client = Provider.of<Client>(context, listen: false);
      await client
          .checkHomeserver(Uri.https('matrix.helixbeat.com', ''));
      await client.login(
        LoginType.mLoginPassword,
        password: viewModel.passwordTextField.text,
        identifier: AuthenticationUserIdentifier(user: viewModel.usernameTextField.text),
      );
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RoomListPage()),
            (route) => false,
      );
    } catch (e) {
//      ScaffoldMessenger.of(context).showSnackBar(
//        SnackBar(
//          content: Text(e.toString()),
//        ),
//      );
//      setState(() {
//        _loading = false;
//      });
    print(e.toString());
    }
  }
}