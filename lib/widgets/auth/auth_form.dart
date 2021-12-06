import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/forgotten_password_screen.dart';
import '../../utils/snackbar.dart';

import '../../providers/auth.dart';
import '../../services/validator_service.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _submitLogin(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final loginData = await Provider.of<Auth>(context, listen: false).login(
        _emailController.text,
        _passwordController.text,
      );
      Snackbar.showScaffold(
        loginData['message'],
        loginData['success'],
        context,
      );
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Adresse e-mail'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: (value) => ValidatorService.validateEmail(value),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) => ValidatorService.validatePassword(value),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 500,
                  child: ElevatedButton(
                    onPressed: () => _submitLogin(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Se connecter"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      ForgottenPasswordScreen.routeName,
                    );
                  },
                  child: const Text("Mot de passe oublié ?"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
