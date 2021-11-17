import 'package:flutter/material.dart';
import '../../screens/login_screen.dart';

class AskResetForm extends StatefulWidget {
  final Function handleReseting;
  const AskResetForm({Key? key, required this.handleReseting})
      : super(key: key);

  @override
  _AskResetFormState createState() => _AskResetFormState();
}

class _AskResetFormState extends State<AskResetForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

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
                  const InputDecoration(labelText: "Votre adresse e-mail"),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre adresse e-mail';
                }
                if (!value.contains("@")) return 'Adresse e-mail invalide';
                return null;
              },
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
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: const Text('Retour'),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => widget.handleReseting(),
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
