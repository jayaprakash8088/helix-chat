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
        elevation: 0.0,
        centerTitle: true,
        title: const Text('Login',style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: viewModel.loading?
        const Center(
          child:  CircularProgressIndicator(
          ),
        ):
        Column(
          children: [
            const SizedBox(height: 16),
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
            const Expanded(child: SizedBox(height: 16)),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.white),
                onPressed: (){
                  _login(viewModel);
                },
               child: const Text('SIGN IN',style: TextStyle(color: Colors.black,
               fontWeight: FontWeight.bold,fontSize: 18)),
              ),
            ),
            const SizedBox(height:30)
          ],
        ),
      ),
    );
  }
  snackbar(){

  }
  void _login(LoginViewModel viewModel) async {
  if(viewModel.usernameTextField.text.trim().isNotEmpty&&
  viewModel.passwordTextField.text.trim().isNotEmpty){
    viewModel.changeLoading(true);
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
      viewModel.changeLoading(false);
    } catch (e) {
      print(e.toString());
      viewModel.changeLoading(false);
    }
  }else{
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enter UserName and Password'),
      ),
    );
  }

  }
}