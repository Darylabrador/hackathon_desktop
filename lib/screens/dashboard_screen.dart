import 'package:flutter/material.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/custom_background_scroll.dart';

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
      body: CustomBackgroundScroll(
        Center(
          child: SizedBox(
            width: 800,
            child: Column(
              children: const [
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
                Text("test"),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
