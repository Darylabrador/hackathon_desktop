import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/auth.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/account_setting_screen.dart';
import '../../screens/login_screen.dart';

import '../../utils/palette.dart';
import '../../services/route_service.dart';

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
              height: 95,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Palette.bluePostale[100],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        hoverColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(MdiIcons.arrowLeft),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/images/default.png"),
                              ),
                              FittedBox(
                                child: Text(
                                  Provider.of<Auth>(customContext ?? context)
                                      .identity as String,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        hoverColor: Colors.transparent,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(customContext ?? context)
                              .pushReplacementNamed(
                            LoginScreen.routeName,
                          );
                          Provider.of<Auth>(customContext ?? context,
                                  listen: false)
                              .logout();
                        },
                        icon: const Icon(MdiIcons.exitToApp),
                      ),
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
                RouteService.welcomeRoute(
                  DashboardScreen.routeName,
                  customContext ?? context,
                );
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
                RouteService.generalRoute(
                  AccountSettingScreen.routeName,
                  customContext ?? context,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
