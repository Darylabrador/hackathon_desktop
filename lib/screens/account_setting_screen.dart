import 'package:flutter/material.dart';

import '../screens/account_delete_confirm_screen.dart';

import '../layout/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/account/account_informations.dart';
import '../widgets/account/account_password.dart';

import '../utils/palette.dart';


class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Palette.bluePostale,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(primary: Palette.yellowPostale[200]),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline1: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              headline3: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              headline4: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AppDrawer(customContext: context),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.info),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Vos informations"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.vpn_key),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Mot de passe"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: const CustomBackground(
            TabBarView(
              children: [
                AccountInformations(),
                AccountPassword(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFFFFDB00),
            onPressed: () async {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  content: const Text(
                    "Voulez-vous vraiment supprimer votre compte ?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: const Text(
                        "Non",
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          AccountDeleteConfirmScreen.routeName,
                        );
                      },
                      child: const Text(
                        "Oui",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
    );
  }
}
