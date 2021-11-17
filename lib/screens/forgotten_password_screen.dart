import 'package:flutter/material.dart';

import '../widgets/custom_background.dart';
import '../widgets/resetPassword/display_reset_forms.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  const ForgottenPasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/forgotten";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Hackathon",
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  "Alternatives au cash",
                  style: Theme.of(context).textTheme.headline1,
                ),
                const SizedBox(
                  width: 250.0,
                  child: Divider(),
                ),
                const SizedBox(height: 50),
                Card(
                  elevation: 5,
                  child: Container(
                    width: 590.0,
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          "Mot de passe oublié",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        const SizedBox(height: 5),
                        const Divider(),
                        const DisplayResetForms()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
