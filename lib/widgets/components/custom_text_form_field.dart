import 'package:flutter/material.dart';
import '../../utils/palette.dart';

class CustomTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.validator,
  }) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Palette.bluePostale, width: 1.0),
        ),
      ),
      textInputAction: TextInputAction.next,
      controller: widget.controller,
      obscureText: true,
      validator: widget.validator
    );
  }
}