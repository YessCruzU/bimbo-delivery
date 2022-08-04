import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/login_service.dart';
import '../../utils/Var.dart';
import '../../utils/custom_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginService _loginService = Provider.of<LoginService>(context);

    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/bimbo_car.jpg',
                            alignment: Alignment.topCenter,
                            fit: BoxFit.scaleDown,
                            height: 128,
                          ),
                          const Text('Bimbo Delivery'),
                        ],
                      ),
                      const SizedBox(height: 40),
                      _customTextField(
                          1,
                          context,
                          _loginService.userFocus,
                          _loginService.emailController,
                          false,
                          'Usuario',
                          _loginService,
                          formKey),
                      const SizedBox(height: 15),
                      _customTextField(
                          2,
                          context,
                          _loginService.passwordFocus,
                          _loginService.passwordController,
                          _loginService.obscureText,
                          'Contraseña',
                          _loginService,
                          formKey),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        style: Var.raisedButtonStyle,
                        onPressed: () => _loginService.submit(context, formKey),
                        child: const Text('Iniciar sesión'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _customTextField(
      int type,
      BuildContext context,
      FocusNode focusNode,
      TextEditingController controller,
      bool obscure,
      String hint,
      LoginService _loginService,
      GlobalKey<FormState> formKey) {
    return TextFormField(
      cursorColor: CustomColors.dartMainColor,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscure,
      onFieldSubmitted: (String value) {
        if (type == 1) {
          FocusScope.of(context).requestFocus(_loginService.passwordFocus);
        } else {
          _loginService.submit(context, formKey);
        }
      },
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Debes ingresar este campo';
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 15),
        hintText: hint,
        border: const OutlineInputBorder(),
        suffixIcon: type == 2
            ? IconButton(
                onPressed: () =>
                    _loginService.setObscureText = !_loginService.obscureText,
                icon: Icon(
                  _loginService.obscureText
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: CustomColors.mainColor,
                ),
              )
            : null,
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      builder: (context) => _buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  AlertDialog _buildExitDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Por favor confirma'),
      content: const Text('¿Deseas salir de la palicación?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('SI'),
        ),
      ],
    );
  }
}
