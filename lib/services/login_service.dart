import 'package:flutter/material.dart';

class LoginService with ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode userFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool obscureText = true;

  set setObscureText(bool value) {
    obscureText = value;
    notifyListeners();
  }

  LoginService();

  submit(BuildContext context,GlobalKey<FormState> formKey) async {
    final form = formKey.currentState;
    if (form!.validate()) {

    }
  }
}