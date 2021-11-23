import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/account_setting.dart';
import '../providers/auth.dart';
import '../screens/login_screen.dart';

import '../widgets/components/custom_text_form_field.dart';
import '../widgets/components/double_button_form.dart';
import '../widgets/custom_background_scroll.dart';

import '../utils/snackbar.dart';

class AccountDeleteConfirmScreen extends StatefulWidget {
  static const routeName = "/confirm-delete";
  const AccountDeleteConfirmScreen({Key? key}) : super(key: key);

  @override
  _AccountDeleteConfirmScreenState createState() =>
      _AccountDeleteConfirmScreenState();
}

class _AccountDeleteConfirmScreenState
    extends State<AccountDeleteConfirmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    try {
      Map<String, dynamic> repData = await Provider.of<AccountSetting>(
        context,
        listen: false,
      ).deleteAccount(
        _passwordController.text.trim(),
        _passwordConfirmController.text.trim(),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
      if (repData['success']) {
        Provider.of<Auth>(context).logout();
        Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suppression de compte"),
      ),
      body: CustomBackgroundScroll(
        Center(
          child: SizedBox(
            width: 570,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.size.height * 0.25),
                  const Text(
                    "Vous nous quittez déjà ?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Saissisez votre mot de passe pour confirmer la suppression",
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(
                    labelText: "Mot de passe",
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez saisir votre mot de passe";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    labelText: "Confirmation mot de passe",
                    controller: _passwordConfirmController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez saisir votre confirmation mot de passe";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DoubleButtonForm(
                    cancelHanlder: () => Navigator.of(context).pop(),
                    cancelText: "Annuler",
                    validHandler: () => _submit(context),
                    validText: "Valider",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
