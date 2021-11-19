import 'package:flutter/material.dart';
import '../widgets/custom_background_scroll.dart';
import '../widgets/auth/auth_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundScroll(
        Center(
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
                        "Connexion",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      const SizedBox(height: 5),
                      const Divider(),
                      const AuthForm(),
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
