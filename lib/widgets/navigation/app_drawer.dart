import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/auth.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/account_setting_screen.dart';
import '../../screens/login_screen.dart';

import '../../utils/palette.dart';

class AppDrawer extends StatelessWidget {
  final BuildContext? customContext;
  const AppDrawer({this.customContext, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(customContext ?? context).copyWith(
        hoverColor: Colors.grey[800],
        canvasColor: Palette.bluePostale,
      ),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 70,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Palette.bluePostale[100],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          hoverColor: Colors.transparent,
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(customContext ?? context).pop();
                          },
                          icon: const Icon(MdiIcons.arrowLeft),
                        ),
                        const SizedBox(width: 20,),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/default.png"),
                        ),
                      ],
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      hoverColor: Colors.transparent,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(customContext ?? context).pushReplacement(
                            MaterialPageRoute(
                                builder: (ctx) => const LoginScreen()));
                        Navigator.of(customContext ?? context)
                            .pushReplacementNamed(LoginScreen.routeName);
                        Provider.of<Auth>(customContext ?? context,
                                listen: false)
                            .logout();
                      },
                      icon: const Icon(MdiIcons.exitToApp),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                MdiIcons.viewDashboard,
                color: Colors.white,
              ),
              title: Text(
                'Mon dashboard',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
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
              leading: const Icon(
                MdiIcons.accountCog,
                color: Colors.white,
              ),
              title: Text(
                'Mon compte',
                style: Theme.of(customContext ?? context).textTheme.headline4,
              ),
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
      ),
    );
  }
}
