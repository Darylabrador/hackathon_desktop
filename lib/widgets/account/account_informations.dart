import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './account_information_form.dart';
import '../../models/account.dart';
import '../../providers/account_setting.dart';
import '../../services/error_service.dart';

class AccountInformations extends StatefulWidget {
  const AccountInformations({Key? key}) : super(key: key);

  @override
  State<AccountInformations> createState() => _AccountInformationsState();
}

class _AccountInformationsState extends State<AccountInformations> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: Provider.of<AccountSetting>(context, listen: false)
            .getAccountInformations(),
        builder: (ctx, AsyncSnapshot<Map<String, dynamic>> accountSnapshot) {
          if (accountSnapshot.connectionState == ConnectionState.done) {
            if (!accountSnapshot.hasData) {
              return ErrorService.showError("Service indisponible");
            }

            Account accountData = Account(
              id: accountSnapshot.data!["id"],
              email: accountSnapshot.data!["email"],
              surname: accountSnapshot.data!["surname"],
              firstname: accountSnapshot.data!["firstname"],
              gender: accountSnapshot.data!["gender"],
              yearOld: accountSnapshot.data!["age"],
            );

            return SingleChildScrollView(
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
                  AccountInformationForm(accountData: accountData)
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
