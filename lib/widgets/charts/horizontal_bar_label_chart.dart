import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '../../../models/statistique.dart';

class HorizontalBarLabelChart extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const HorizontalBarLabelChart(
    this.seriesList, {
    Key? key,
    required this.animate,
  }) : super(key: key);

  static display(List<Statistique> data) {
    return HorizontalBarLabelChart(
      _createGraph(data),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: animate,
      vertical: false,
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      domainAxis: const charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }

  static List<charts.Series<Statistique, String>> _createGraph(List<Statistique> data) {
    return [
      charts.Series<Statistique, String>(
          id: 'Stats',
          domainFn: (Statistique sales, _) => sales.label,
          measureFn: (Statistique sales, _) => sales.data,
          data: data,
          labelAccessorFn: (Statistique sales, _) => '${sales.label}: ${sales.data.toString()} équipe(s)',)
    ];
  }
}