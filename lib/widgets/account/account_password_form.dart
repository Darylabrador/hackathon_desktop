import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/password_reset.dart';

import '../components/custom_text_form_field.dart';
import '../components/double_button_form.dart';

import '../../services/validator_service.dart';
import '../../utils/snackbar.dart';

class AccountPasswordForm extends StatefulWidget {
  const AccountPasswordForm({Key? key}) : super(key: key);

  @override
  _AccountPasswordFormState createState() => _AccountPasswordFormState();
}

class _AccountPasswordFormState extends State<AccountPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  ValidatorService validator = ValidatorService.getInstance();

  var _isHidden = true;

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    try {
      Map<String, dynamic> repData = await Provider.of<PasswordReset>(
        context,
        listen: false,
      ).loggedInResetingPassword(
        _oldPasswordController.text.trim(),
        _passwordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
      if (repData['success']) {
        _resetForm();
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void _showPassword() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _oldPasswordController.text = "";
    _passwordController.text = "";
    _confirmPasswordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 570,
        child: Column(
          children: [
            CustomTextFormField(
              labelText: "Ancien mot de passe",
              controller: _oldPasswordController,
              obscureText: _isHidden,
              validator: (value) => validator.validateField(value)
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Nouveau mot de passe",
              controller: _passwordController,
              obscureText: _isHidden,
              validator: (value) => validator.validatePassword(value)
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Confirmation mot de passe",
              controller: _confirmPasswordController,
              obscureText: _isHidden,
              validator: (value) => validator.validatePassword(value)
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _showPassword,
              child: Text(
                _isHidden
                    ? "Afficher le mot de passe"
                    : "Cacher le mot de passe",
              ),
            ),
            const SizedBox(height: 20),
            DoubleButtonForm(
              cancelHanlder: _resetForm,
              cancelText: "Annuler",
              validHandler: () => _submit(context),
              validText: "Valider",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
