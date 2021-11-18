import 'package:flutter/material.dart';
import '../components/custom_text_form_field.dart';

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

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre ancien mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Nouveau mot de passe",
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre nouveau mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Confirmation mot de passe",
              controller: _confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez confirmer votre mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black45),
                    ),
                    onPressed: () => {},
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Valider'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
