import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/password_reset.dart';

import '../../screens/login_screen.dart';

import '../../utils/snackbar.dart';

import '../components/double_button_form.dart';
import '../../services/validator_service.dart';

class ResetForm extends StatefulWidget {
  final Function handleReseting;
  final String? resetToken;
  const ResetForm({
    Key? key,
    this.resetToken,
    required this.handleReseting,
  }) : super(key: key);

  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  Future<void> _submit(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final data = await Provider.of<PasswordReset>(context, listen: false)
          .loggedOutResetingPassword(
        _passwordController.text,
        _passwordConfirmController.text,
        widget.resetToken,
      );
      Snackbar.showScaffold(data["message"], data["success"], context);
      if (data["success"]) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Column(
          children: [
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Votre mot de passe"),
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              validator: (value) => ValidatorService.validatePassword(value)
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Confirmation mot de passe"),
              textInputAction: TextInputAction.done,
              controller: _passwordConfirmController,
              validator: (value) => ValidatorService.validatePassword(value)
            ),
            const SizedBox(
              height: 20,
            ),
            DoubleButtonForm(
              cancelHanlder: () => widget.handleReseting(),
              cancelText: "Annuler",
              validHandler: () => _submit(context),
              validText: "Valider",
            ),
          ],
        ),
      ),
    );
  }
}
