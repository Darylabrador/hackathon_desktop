import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/stats.dart';
import '../../../models/statistique.dart';

import './horizontal_bar_label_chart.dart';
import './outside_label_pie_chart.dart';

class ChartDisplayed extends StatefulWidget {
  final bool isPhaseState;
  const ChartDisplayed({required this.isPhaseState, Key? key})
      : super(key: key);

  @override
  _ChartDisplayedState createState() => _ChartDisplayedState();
}

class _ChartDisplayedState extends State<ChartDisplayed> {
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
        const SizedBox(
          height: 15,
        ),
        if (!widget.isPhaseState)
          FutureBuilder(
            future: Provider.of<Stats>(
              context,
              listen: false,
            ).getStatsParticipants(),
            builder: (ctx, AsyncSnapshot<List<Statistique>?> graphSnapshot) {
              if (graphSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                height: mediaQuery.size.height * 0.41,
                width: mediaQuery.size.width * 0.7,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: PieOutsideLabelChart.display(graphSnapshot.data!),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        if (widget.isPhaseState)
          FutureBuilder(
            future: Provider.of<Stats>(
              context,
              listen: false,
            ).getStatsTeamByPhase(),
            builder: (ctx, AsyncSnapshot<List<Statistique>?> graphSnapshot) {
              if (graphSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SizedBox(
                height: mediaQuery.size.height * 0.41,
                width: mediaQuery.size.width * 0.7,
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: HorizontalBarLabelChart.display(graphSnapshot.data!),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
