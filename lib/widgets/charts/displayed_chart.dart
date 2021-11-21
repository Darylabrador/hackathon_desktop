import 'package:flutter/material.dart';

import './statistique_displayed.dart';
import './participant_data_table.dart';
import './team_by_phase_data_table.dart';

class DisplayedChart extends StatefulWidget {
  const DisplayedChart({Key? key}) : super(key: key);

  @override
  _DisplayedChartState createState() => _DisplayedChartState();
}

class _DisplayedChartState extends State<DisplayedChart> {
  Iterable<Map<String, dynamic>> rows = [
    {
      "name": "Sarah",
      "age": "19",
      "role": "Student",
    },
    {
      "name": "Janine",
      "age": "43",
      "role": "Professor",
    },
    {
      "name": "William",
      "age": "27",
      "role": "Associate Professor",
    },
    {
      "name": "William",
      "age": "27",
      "role": "Associate Professor",
    },
    {
      "name": "William",
      "age": "27",
      "role": "Associate Professor",
    },
    {
      "name": "William",
      "age": "27",
      "role": "Associate Professor",
    },
    {
      "name": "William",
      "age": "27",
      "role": "Associate Professor",
    },
  ];

  Iterable<Map<String, dynamic>> rows2 = [
    {
      "name": "Olivier",
      "age": "19",
      "role": "Informaticien",
    },
    {
      "name": "John",
      "age": "43",
      "role": "Développeur",
    },
    {
      "name": "David",
      "age": "27",
      "role": "Journaliste",
    },
    {
      "name": "Olivier",
      "age": "19",
      "role": "Informaticien",
    },
    {
      "name": "John",
      "age": "43",
      "role": "Développeur",
    },
    {
      "name": "David",
      "age": "27",
      "role": "Journaliste",
    },
    {
      "name": "Olivier",
      "age": "19",
      "role": "Informaticien",
    },
    {
      "name": "John",
      "age": "43",
      "role": "Développeur",
    },
    {
      "name": "David",
      "age": "27",
      "role": "Journaliste",
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
                        rowData: rows2,
                      )
                    : ParticipantDataTable(rowData: rows),
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
