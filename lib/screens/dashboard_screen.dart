import 'package:flutter/material.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/custom_background_scroll.dart';

import '../widgets/charts/outside_label_pie_chart.dart';
import '../widgets/charts/horizontal_bar_label_chart.dart';
import '../widgets/components/custom_data_table.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const routeName = '/dashboard';

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
              const SizedBox(height: 80),
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
              const SizedBox(height: 50),
              SizedBox(
                height: mediaQuery.size.height * 0.4,
                width: mediaQuery.size.width * 0.6,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: PieOutsideLabelChart.withSampleData(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: mediaQuery.size.height * 0.4,
                width: mediaQuery.size.width * 0.6,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: HorizontalBarLabelChart.withSampleData(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: mediaQuery.size.width * 0.6,
                child: const Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomDataTable(),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
