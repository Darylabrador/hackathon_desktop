import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../models/account.dart';
import '../components/gender_select_input.dart';
import '../components/custom_text_form_field.dart';

class AccountInformationForm extends StatefulWidget {
  final Account accountData;
  const AccountInformationForm({
    required this.accountData,
    Key? key,
  }) : super(key: key);

  @override
  _AccountInformationFormState createState() => _AccountInformationFormState();
}

class _AccountInformationFormState extends State<AccountInformationForm> {
  final _formKey = GlobalKey<FormState>();
  final _surnameController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _yearOldController = TextEditingController();
  Gender? _selectedGender;
  var _isValid = true;
  var _isInit = true;

  void _submit() {
    if (_selectedGender is Gender) {
      setState(() {
        _isValid = true;
      });
    } else {
      setState(() {
        _isValid = false;
      });
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
  }

  void _handleSelect(Gender selectedValued) {
    setState(() {
      _selectedGender = selectedValued;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _surnameController.text = widget.accountData.surname!;
      _firstnameController.text = widget.accountData.firstname!;
      _emailController.text = widget.accountData.email!;
      _yearOldController.text = widget.accountData.yearOld!.toString();
    }
    _isInit = false;
    super.didChangeDependencies();
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
            GenderSelectInput(
              isValid: _isValid,
              handleSelect: _handleSelect,
              gender: widget.accountData.gender!,
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
