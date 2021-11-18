import 'package:flutter/material.dart';
import '../widgets/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';

import '../widgets/account/account_informations.dart';
import '../widgets/account/account_password.dart';

class AccountSettingScreen extends StatelessWidget {
  const AccountSettingScreen({Key? key}) : super(key: key);
  static const routeName = "/settings";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: AppDrawer(customContext: context),
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(
                width: 30,
              )
            ],
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
            onPressed: () {},
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
