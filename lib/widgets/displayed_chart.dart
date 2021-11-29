import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/statistique.dart';

import './charts/chart_displayed.dart';
import 'datatable/participant_data_table.dart';
import 'datatable/team_by_phase_data_table.dart';

import '../providers/phase_provider.dart';

class DisplayedChart extends StatefulWidget {
  const DisplayedChart({Key? key}) : super(key: key);

  @override
  _DisplayedChartState createState() => _DisplayedChartState();
}

class _DisplayedChartState extends State<DisplayedChart> {
  late List<Statistique> graphDataParticipant;
  late List<Statistique> graphDataTeamByPhase;

  var _isPhaseStats = false;
  var _isShowingTable = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        if (!_isShowingTable) ChartDisplayed(isPhaseState: _isPhaseStats),
        if (_isShowingTable)
          Consumer<PhaseProvider>(
            builder: (ctx, phaseData, child) {
              if (phaseData.phaseList != null) {
                return SizedBox(
                  width: mediaQuery.size.width * 0.7,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _isPhaseStats
                          ? TeamByPhaseDataTable(
                              phaseList: phaseData.phaseList!,
                            )
                          : ParticipantDataTable(
                              phaseList: phaseData.phaseList!,
                            ),
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            child: null,
          ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isShowingTable = !_isShowingTable;
                });
              },
              child: Text(
                _isShowingTable ? "Voir les graphiques" : "Voir les tableaux",
              ),
            ),
            const SizedBox(width: 40),
            if (!_isShowingTable)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPhaseStats = !_isPhaseStats;
                  });
                },
                child: const Text("Changer de graphique"),
              ),
            if (_isShowingTable)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPhaseStats = !_isPhaseStats;
                  });
                },
                child: const Text("Changer de tableau"),
              )
          ],
        ),
      ],
    );
  }
}
