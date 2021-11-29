import 'package:flutter/material.dart';
import '../layout/custom_background_scroll.dart';
import '../widgets/resetPassword/display_reset_forms.dart';

class ForgottenPasswordScreen extends StatelessWidget {
  const ForgottenPasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/forgotten";

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: CustomBackgroundScroll(
        Center(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.15),
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
    );
  }
}
