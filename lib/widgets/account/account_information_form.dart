import 'package:flutter/material.dart';
import '../components/gender_select_input.dart';
import '../components/custom_text_form_field.dart';

class AccountInformationForm extends StatefulWidget {
  const AccountInformationForm({Key? key}) : super(key: key);

  @override
  _AccountInformationFormState createState() => _AccountInformationFormState();
}

class _AccountInformationFormState extends State<AccountInformationForm> {
  final _formKey = GlobalKey<FormState>();
  final _surnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _yearOldController = TextEditingController();

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
              labelText: "Votre nom de famille",
              controller: _surnameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre nom de famille';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre prénom",
              controller: _firstnameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre prénom';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre adresse e-mail",
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre adresse e-mail';
                }
                if (!value.contains("@")) {
                  return 'Adresse e-mail invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Votre age",
              controller: _yearOldController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre age';
                }
                if (!value.contains(RegExp(r'^[0-9]{2}'))) {
                  return 'Il faut que des chiffres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const GenderSelectInput(),
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}