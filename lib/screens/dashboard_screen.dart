import 'package:flutter/material.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/custom_background_scroll.dart';
import '../widgets/charts/displayed_chart.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
        final mediaQuery = MediaQuery.of(context);

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
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.08),
              Text(
                "Hackathon",
                style: Theme.of(context).textTheme.headline1,
              ),
              Text(
                "Alternatives au cash",
                style: Theme.of(context).textTheme.headline1,
              ),
              const SizedBox(
                width: 250.0,
                child: Divider(),
              ),
              const SizedBox(height: 30),
              const DisplayedChart(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
