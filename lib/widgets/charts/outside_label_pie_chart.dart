import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../../models/statistique.dart';

class PieOutsideLabelChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  const PieOutsideLabelChart(
    this.seriesList, {
    Key? key,
    required this.animate,
  }) : super(key: key);

  static display(List<Statistique> data) {
    return PieOutsideLabelChart(
      _createGraph(data),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: charts.ArcRendererConfig(
        arcRendererDecorators: [
          charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.outside,
          )
        ],
      ),
    );
  }

  static List<charts.Series<Statistique, int>> _createGraph(List<Statistique> data) {
    return [
      charts.Series<Statistique, int>(
        id: 'Stats',
        domainFn: (Statistique sales, _) => sales.id,
        measureFn: (Statistique sales, _) => sales.data,
        data: data,
        labelAccessorFn: (Statistique row, _) => '${row.label} (${row.data})',
      )
    ];
  }
}
