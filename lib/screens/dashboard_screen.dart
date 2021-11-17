import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: const Center(
        child: Text('dashboard'),
      ),
    );
  }
}
