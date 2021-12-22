import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../providers/pdf_provider.dart';
import '../../../providers/stats.dart';
import '../../../models/phase.dart';
import '../../../models/team_by_phase.dart';

import '../../../screens/pdf_viewer_screen.dart';
import '../../../screens/project_details_screen.dart';
import '../../../utils/snackbar.dart';

class TeamByPhaseDataTable extends StatefulWidget {
  final List<Phase> phaseList;
  const TeamByPhaseDataTable({
    required this.phaseList,
    Key? key,
  }) : super(key: key);

  @override
  State<TeamByPhaseDataTable> createState() => _TeamByPhaseDataTableState();
}

class _TeamByPhaseDataTableState extends State<TeamByPhaseDataTable> {
  var _isInit = true;
  final _searchController = TextEditingController();
  Iterable<TeamByPhase> iterableRows = [];
  Iterable<TeamByPhase> rowsDataTeamByPhase = [];

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      try {
        final structuredData = <TeamByPhase>[];
        final initialData = await Provider.of<Stats>(
          context,
          listen: false,
        ).getTeamByPhaseDataTableInfo();
        for (var element in initialData) {
          var phaseName = widget.phaseList.firstWhere(
            (phase) => phase.id.toString() == element.phaseActual.toString(),
          );
          structuredData.add(
            TeamByPhase(
              projectId: element.projectId,
              teamName: element.teamName,
              leader: element.leader,
              phaseActual: element.phaseActual,
              projectData: element.projectData,
              phaseName: phaseName.name,
            ),
          );
        }

        iterableRows = structuredData;
        rowsDataTeamByPhase = structuredData;
      } catch (e) {
        // print(e.toString());
      }
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  List<DataRow> get rowData {
    List<DataRow> data = <DataRow>[];
    if (iterableRows.isEmpty) return data;
    for (var element in iterableRows) {
      data.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.teamName)),
            DataCell(Text(element.leader)),
            DataCell(Text(element.phaseName!)),
            DataCell(
              Row(
                children: [
                  if(element.phaseActual != 1) IconButton(
                    padding: EdgeInsets.zero,
                    hoverColor: Colors.transparent,
                    color: Colors.blueGrey,
                    icon: const Icon(MdiIcons.eye),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => ProjectDetailsScreen(
                            teamData: element,
                          ),
                        ),
                      );
                    },
                  ),
                  if(element.phaseActual != 1) IconButton(
                    padding: EdgeInsets.zero,
                    hoverColor: Colors.transparent,
                    color: Colors.red,
                    icon: const Icon(MdiIcons.filePdf),
                    onPressed: () async {
                      try {
                        final document = await Provider.of<PDFProvider>(
                          context,
                          listen: false,
                        ).getSinglePdfFile(element.projectId);

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PDFViewerScreen(
                              teamName: element.teamName,
                              document: document,
                            ),
                          ),
                        );
                      } catch (e) {
                        Snackbar.showScaffold(e.toString(), false, context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return data;
  }

  void _searchAction(String searchText) {
    if (searchText.isNotEmpty) {
      final result = rowsDataTeamByPhase.where(
        (element) =>
            element.teamName.toString().toLowerCase().contains(searchText) ||
            element.leader.toString().toLowerCase().contains(searchText) ||
            element.phaseName!.toString().toLowerCase().contains(searchText) ||
            element.teamName.toString().contains(searchText) ||
            element.leader.toString().contains(searchText) ||
            element.phaseName!.toString().contains(searchText),
      );
      setState(() {
        iterableRows = result;
      });
    } else {
      setState(() {
        iterableRows = rowsDataTeamByPhase;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    if (_isInit) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            children: const [
              Text(
                "Equipes par phase",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Divider(),
            ],
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Rechercher',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                _searchAction(value);
              },
            ),
            trailing: IconButton(
              padding: EdgeInsets.zero,
              hoverColor: Colors.transparent,
              icon: const Icon(Icons.cancel),
              onPressed: () {
                _searchController.text = "";
                setState(() {
                  iterableRows = rowsDataTeamByPhase;
                });
              },
            ),
          ),
        ),
        SizedBox(
          height: mediaQuery.size.height * 0.4,
          child: SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    "Equipes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Chefs d'equipe",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Phase actuelle",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    "Actions",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: rowData,
            ),
          ),
        ),
      ],
    );
  }
}
