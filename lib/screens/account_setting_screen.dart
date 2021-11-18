import 'package:flutter/material.dart';
import '../widgets/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';

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
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
