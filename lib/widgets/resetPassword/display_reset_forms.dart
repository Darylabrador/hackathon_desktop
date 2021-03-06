import 'package:flutter/material.dart';

import './ask_reset_form.dart';
import './reset_form.dart';

class DisplayResetForms extends StatefulWidget {
  const DisplayResetForms({Key? key}) : super(key: key);

  @override
  _DisplayResetFormsState createState() => _DisplayResetFormsState();
}

class _DisplayResetFormsState extends State<DisplayResetForms> {
  var isResetting = false;

  void handleResetting(String? tokenValue) {
    if (tokenValue != null) {
      setState(() {
        isResetting = !isResetting;
      });
    } else {
      setState(() {
        isResetting = !isResetting;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isResetting) return AskResetForm(handleReseting: handleResetting);
    return ResetForm(handleReseting: handleResetting);
  }
}
