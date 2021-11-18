import 'package:flutter/material.dart';
import '../../models/gender.dart';
import '../../utils/palette.dart';

class GenderSelectInput extends StatefulWidget {
  final bool isValid;
  final Function handleSelect;
  const GenderSelectInput(
      {required this.isValid, required this.handleSelect, Key? key})
      : super(key: key);

  @override
  _GenderSelectInputState createState() => _GenderSelectInputState();
}

class _GenderSelectInputState extends State<GenderSelectInput> {
  final genderList = [
    Gender(id: 0, name: "Femme"),
    Gender(id: 1, name: "Homme"),
    Gender(id: 2, name: "Non spécifié"),
  ];

  Gender? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Gender>(
      decoration: InputDecoration(
        labelText: "Votre sexe",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isValid ? Palette.bluePostale : Colors.red,
            width: 1.0,
          ),
        ),
      ),
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      onChanged: (Gender? newValue) {
        widget.handleSelect(newValue);
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: genderList.map<DropdownMenuItem<Gender>>((value) {
        return DropdownMenuItem<Gender>(
          value: value,
          child: Text(value.name),
        );
      }).toList(),
    );
  }
}
