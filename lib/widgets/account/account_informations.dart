import 'package:flutter/material.dart';
import './account_information_form.dart';

class AccountInformations extends StatelessWidget {
  const AccountInformations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 130,
              height: 130,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/default.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const AccountInformationForm()
          ],
        ),
      ),
    );
  }
}
