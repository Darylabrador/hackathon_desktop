import 'package:flutter/material.dart';

import './statistique_displayed.dart';
import './participant_data_table.dart';
import './team_by_phase_data_table.dart';

import '../../models/statistique.dart';

class DisplayedChart extends StatefulWidget {
  const DisplayedChart({Key? key}) : super(key: key);

  @override
  _DisplayedChartState createState() => _DisplayedChartState();
}

class _DisplayedChartState extends State<DisplayedChart> {
  late List<Statistique> graphDataParticipant;
  late List<Statistique> graphDataTeamByPhase;

  Iterable<Map<String, dynamic>> rowsDataParticipant = [
    {
      "name": "Sarah",
      "age": "19",
      "role": "Student",
    },
  ];

  Iterable<Map<String, dynamic>> rowsDataTeamByPhase = [
    {
      "name": "Olivier",
      "age": "19",
      "role": "Informaticien",
    },
  ];

  var _isPhaseStats = false;
  var _isShowingTable = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        if (!_isShowingTable) StatiqueDisplayed(isPhaseState: _isPhaseStats),
        if (_isShowingTable)
          SizedBox(
            width: mediaQuery.size.width * 0.7,
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: _isPhaseStats
                    ? TeamByPhaseDataTable(
                        rowData: rowsDataTeamByPhase,
                      )
                    : ParticipantDataTable(rowData: rowsDataParticipant),
              ),
            ),
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
