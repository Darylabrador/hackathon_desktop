import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/password_reset.dart';

import '../../screens/login_screen.dart';

import '../../utils/snackbar.dart';

import '../components/double_button_form.dart';
import '../../services/validator_service.dart';

class ResetForm extends StatefulWidget {
  final Function handleReseting;
  const ResetForm({
    Key? key,
    required this.handleReseting,
  }) : super(key: key);

  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  var _loading = false;

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final data = await Provider.of<PasswordReset>(context, listen: false)
          .loggedOutResetingPassword(
        _codeController.text.trim(),
        _passwordController.text.trim(),
        _passwordConfirmController.text.trim(),
      );
      Snackbar.showScaffold(data["message"], data["success"], context);
      if (data["success"]) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Code de validation",
              ),
              textInputAction: TextInputAction.next,
              controller: _codeController,
              validator: (value) => ValidatorService.validatePassword(value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Votre mot de passe",
              ),
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              validator: (value) => ValidatorService.validatePassword(value),
            ),
            const SizedBox(height: 20),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirmation mot de passe",
              ),
              textInputAction: TextInputAction.done,
              controller: _passwordConfirmController,
              validator: (value) => ValidatorService.validatePassword(value),
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
