import 'package:flutter/material.dart';
import '../../screens/login_screen.dart';

class ResetForm extends StatefulWidget {
  final Function handleReseting;
  const ResetForm({Key? key, required this.handleReseting}) : super(key: key);

  @override
  _ResetFormState createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
        child: Column(
          children: [
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Votre mot de passe"),
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut pas être vide';
                }
                if (value.length < 5) {
                  return 'Il faut 5 caractères minimum';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration:
                  const InputDecoration(labelText: "Confirmation mot de passe"),
              textInputAction: TextInputAction.done,
              controller: _passwordConfirmController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ce champ ne peut pas être vide';
                }
                if (value.length < 5) {
                  return 'Il faut 5 caractères minimum';
                }
                return null;
              },
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => widget.handleReseting(),
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('Valider'),
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
