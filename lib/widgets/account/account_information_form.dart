import 'package:flutter/material.dart';
import '../components/gender_select_input.dart';
import '../../utils/palette.dart';

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
                labelText: "Votre nom de famille",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: _surnameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre nom de famille';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Votre prénom",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
              controller: _firstnameController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Veuillez saisir votre prénom';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Votre adresse e-mail",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
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
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Votre age",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Palette.bluePostale, width: 1.0),
                ),
              ),
              textInputAction: TextInputAction.next,
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
