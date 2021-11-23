import 'package:flutter/material.dart';

import '../models/team_by_phase.dart';

import '../widgets/custom_background.dart';
import '../widgets/project_detail/project_detail_card.dart';

class ProjectDetailsScreen extends StatefulWidget {
  static const routeName = "/recapitulatif";
  final TeamByPhase? teamData;
  const ProjectDetailsScreen({
    Key? key,
    this.teamData,
  }) : super(key: key);

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  List<dynamic> get _dataStructure {
    final displayData = [];

    for (var element in widget.teamData!.projectData) {
      var restructuredData = <String, dynamic>{};
      var data = element as Map<String, dynamic>;
      var phaseData = [];

      data.forEach((key, value) {
        if (key == "phase") {
          restructuredData['phase'] = value;
        }

        if (key != "phase" && key != "phaseId") {
          phaseData.add({key: value});
        }
      });

      restructuredData["data"] = phaseData;
      displayData.add(restructuredData);
    }
    return displayData;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Détails du projet : ${widget.teamData!.teamName}"),
      ),
      body: CustomBackground(
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.08),
              Column(
                children: _dataStructure
                    .map((e) => ProjectDetailCard(
                          phaseName: e["phase"],
                          phaseData: e["data"],
                        ))
                    .toList(),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
