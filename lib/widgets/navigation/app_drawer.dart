import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/auth.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/account_setting_screen.dart';
import '../../screens/login_screen.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext? customContext;
  const AppDrawer({this.customContext, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: const [
                    Text('text'),
                    Text('text'),
                    Text('text'),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(customContext ?? context).pushReplacement(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
                    Navigator.of(customContext ?? context).pushReplacementNamed(LoginScreen.routeName);
                    Provider.of<Auth>(customContext ?? context, listen: false).logout();
                  },
                  icon: const Icon(MdiIcons.exitToApp),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(MdiIcons.viewDashboard),
            title: const Text('Mon dashboard'),
            onTap: () {
              if (ModalRoute.of(customContext ?? context)!
                          .settings
                          .name
                          .toString() ==
                      "/" ||
                  ModalRoute.of(customContext ?? context)!
                          .settings
                          .name
                          .toString() ==
                      DashboardScreen.routeName) {
                return;
              }
              Navigator.of(customContext ?? context)
                  .pushReplacementNamed(DashboardScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(MdiIcons.accountCog),
            title: const Text('Mon compte'),
            onTap: () {
              if (ModalRoute.of(customContext ?? context)!
                      .settings
                      .name
                      .toString() ==
                  AccountSettingScreen.routeName) {
                return;
              }
              Navigator.of(customContext ?? context)
                  .pushReplacementNamed(AccountSettingScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
