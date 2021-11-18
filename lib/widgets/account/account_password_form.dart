import 'package:flutter/material.dart';
import '../../utils/palette.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        width: 570,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Ancien mot de passe",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: _oldPasswordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre ancien mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Nouveau mot de passe",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre nouveau mot de passe';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Confirmation mot de passe",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: _confirmPasswordController,
              obscureText: true,
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
                const SizedBox(width: 15,),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => {},
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
