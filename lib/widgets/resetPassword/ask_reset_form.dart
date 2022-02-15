import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/password_reset.dart';
import '../../utils/snackbar.dart';
import '../../screens/login_screen.dart';
import '../components/double_button_form.dart';

import '../../services/validator_service.dart';

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
  ValidatorService validator = ValidatorService.getInstance();

  var _loading = false;

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _loading = true;
    });
    try {
      if (!_formKey.currentState!.validate()) {
        setState(() {
          _loading = false;
        });
        return;
      }
      _formKey.currentState!.save();
      final data = await Provider.of<PasswordReset>(context, listen: false)
          .loggedOutResetingAsk(_emailController.text);
      if (data["success"]) {
        widget.handleReseting(data["resetToken"]);
      } else {
        Snackbar.showScaffold(data["message"], false, context);
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
                decoration:
                    const InputDecoration(labelText: "Votre adresse e-mail"),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                controller: _emailController,
                validator: (value) => validator.validateEmail(value)),
            const SizedBox(
              height: 20,
            ),
            DoubleButtonForm(
              cancelHanlder: () {
                Navigator.of(context).pushReplacementNamed(
                  LoginScreen.routeName,
                );
              },
              cancelText: "Retour",
              validHandler: () => _submit(context),
              validText: "Valider",
            ),
          ],
        ),
      ),
    );
  }
}
