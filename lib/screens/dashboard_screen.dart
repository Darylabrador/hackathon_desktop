import 'package:flutter/material.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/custom_background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      drawer: const AppDrawer(),
      body: const CustomBackground(
        Center(
          child: Text('dashboard'),
        ),
      ),
    );
  }
}
