import 'package:flutter/material.dart';

class LoginViewModel with ChangeNotifier {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool enableLogin = false;
  bool inProgress = false;

  LoginViewModel() {
    idController.addListener(_onTextChanged);
    passwordController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    enableLogin =
        idController.text.isNotEmpty && passwordController.text.isNotEmpty;
    notifyListeners();
  }

  Future<bool> login() async {
    inProgress = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 3));
    inProgress = false;
    notifyListeners();
    final result = idController.text == 'aaa' && passwordController.text == 'aaa';
    return result;
  }
}
