import 'package:flutter/material.dart';

import './horizontal_bar_label_chart.dart';
import './outside_label_pie_chart.dart';

class StatiqueDisplayed extends StatefulWidget {
  final bool isPhaseState;
  const StatiqueDisplayed({required this.isPhaseState, Key? key})
      : super(key: key);

  @override
  _StatiqueDisplayedState createState() => _StatiqueDisplayedState();
}

class _StatiqueDisplayedState extends State<StatiqueDisplayed> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Center(
          child: Column(
            children: [
              Text(
                widget.isPhaseState ? "Equipes par phase" : "Participants",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15,),
        if (!widget.isPhaseState)
          SizedBox(
            height: mediaQuery.size.height * 0.41,
            width: mediaQuery.size.width * 0.7,
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
        if (widget.isPhaseState)
          SizedBox(
            height: mediaQuery.size.height * 0.41,
            width: mediaQuery.size.width * 0.7,
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
      ],
    );
  }
}
