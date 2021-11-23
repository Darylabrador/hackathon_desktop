import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/stats.dart';
import '../../../models/phase.dart';
import '../../../models/particpants.dart';

class ParticipantDataTable extends StatefulWidget {
  final List<Phase> phaseList;
  const ParticipantDataTable({
    required this.phaseList,
    Key? key,
  }) : super(key: key);

  @override
  State<ParticipantDataTable> createState() => _ParticipantDataTableState();
}

class _ParticipantDataTableState extends State<ParticipantDataTable> {
  final _searchController = TextEditingController();
  Iterable<Participants> iterableRows = [];
  Iterable<Participants> rowsDataParticipant = [];

  var _isInit = true;

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      final initialData = await Provider.of<Stats>(context, listen: false)
          .getParticipantsDataTableInfo();
      iterableRows = initialData.toList();
      rowsDataParticipant = initialData.toList();
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  List<DataRow> get setRowData {
    List<DataRow> data = <DataRow>[];
    if (iterableRows.isEmpty) return data;
    for (var element in iterableRows) {
      data.add(
        DataRow(
          cells: <DataCell>[
            DataCell(Text(element.createdAt)),
            DataCell(Text(element.surname)),
            DataCell(Text(element.firstname)),
            DataCell(Text(element.email)),
            DataCell(Text(element.teamName)),
            DataCell(Text(element.role)),
          ],
        ),
      );
    }
    return data;
  }

  void _searchAction(String searchText) {
    if (searchText.isNotEmpty) {
      final result = rowsDataParticipant.where(
        (element) =>
            element.email.toString().toLowerCase().contains(searchText) ||
            element.surname.toString().toLowerCase().contains(searchText) ||
            element.firstname.toString().toLowerCase().contains(searchText) ||
            element.gender.toString().toLowerCase().contains(searchText) ||
            element.role.toString().toLowerCase().contains(searchText) ||
            element.teamName.toString().toLowerCase().contains(searchText) ||
            element.createdAt.toString().toLowerCase().contains(searchText) ||
            element.email.toString().contains(searchText) ||
            element.surname.toString().contains(searchText) ||
            element.firstname.toString().contains(searchText) ||
            element.gender.toString().contains(searchText) ||
            element.role.toString().contains(searchText) ||
            element.teamName.toString().contains(searchText) ||
            element.createdAt.toString().contains(searchText),
      );

      setState(() {
        iterableRows = result.toList();
      });
    } else {
      setState(() {
        iterableRows = rowsDataParticipant;
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
                "Participants",
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
                  iterableRows = rowsDataParticipant;
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
                    'Inscrit le',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Noms',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Prénoms',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Mails',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Equipes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Roles',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: setRowData,
            ),
          ),
        ),
      ],
    );
  }
}
