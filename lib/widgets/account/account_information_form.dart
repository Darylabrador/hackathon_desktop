import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/account_setting.dart';

import '../../models/gender.dart';
import '../../models/account.dart';

import '../components/gender_select_input.dart';
import '../components/custom_text_form_field.dart';

import '../components/double_button_form.dart';

import '../../utils/snackbar.dart';

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
  late Gender _selectedGender;
  var _isValid = true;
  var _isInit = true;
  late Account savedData;

  Future<void> _submit(BuildContext context) async {
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

    try {
      Map<String, dynamic> repData = await Provider.of<AccountSetting>(
        context,
        listen: false,
      ).updateAccount(
        _emailController.text.trim(),
        _surnameController.text.trim(),
        _firstnameController.text.trim(),
        _selectedGender.id,
        int.parse(_yearOldController.text),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  void _handleSelect(Gender selectedValued) {
    setState(() {
      _selectedGender = selectedValued;
    });
  }

  void _setDataField(Account data) {
    _surnameController.text = data.surname!;
    _firstnameController.text = data.firstname!;
    _emailController.text = data.email!;
    _yearOldController.text = data.yearOld!.toString();
    switch (data.gender!) {
      case "femme":
        _selectedGender = const Gender(id: 0, name: "femme");
        break;
      case "homme":
        _selectedGender = const Gender(id: 1, name: "homme");
        break;
      default:
        _selectedGender = const Gender(id: 2, name: "non spécifié");
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _setDataField(savedData);
    setState(() {
      
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      savedData = widget.accountData;
      _setDataField(widget.accountData);
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
              selectedGender: _selectedGender,
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
