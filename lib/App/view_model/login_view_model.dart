import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier{
  final TextEditingController usernameTextField = TextEditingController();
  final TextEditingController passwordTextField = TextEditingController();
  bool loading=false;
  changeLoading(bool val){
    loading=val;
    notifyListeners();
  }
}