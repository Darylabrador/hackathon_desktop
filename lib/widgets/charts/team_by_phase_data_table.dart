import 'package:flutter/material.dart';

class TeamByPhaseDataTable extends StatefulWidget {
  final Iterable<Map<String, dynamic>> rowData;
  const TeamByPhaseDataTable({required this.rowData, Key? key})
      : super(key: key);

  @override
  State<TeamByPhaseDataTable> createState() => _TeamByPhaseDataTableState();
}

class _TeamByPhaseDataTableState extends State<TeamByPhaseDataTable> {
  final _searchController = TextEditingController();
  var _isInit = true;
  late Iterable<Map<String, dynamic>> iterableRows;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      iterableRows = widget.rowData;
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<DataRow> get rowData {
    List<DataRow> data = <DataRow>[];
    for (var element in iterableRows) {
      data.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(element["name"])),
          DataCell(Text(element["age"])),
          DataCell(Text(element["role"])),
        ],
      ));
    }
    return data;
  }

  void _searchAction(String searchText) {
    if (searchText.isNotEmpty) {
      final result = widget.rowData.where(
        (element) =>
            element["name"].toString().toLowerCase().contains(searchText) ||
            element['age'].toString().toLowerCase().contains(searchText) ||
            element['role'].toString().toLowerCase().contains(searchText) ||
            element["name"].toString().contains(searchText) ||
            element['age'].toString().contains(searchText) ||
            element['role'].toString().contains(searchText),
      );
      setState(() {
        iterableRows = result;
      });
    } else {
      setState(() {
        iterableRows = widget.rowData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
              icon: const Icon(Icons.cancel),
              onPressed: () {
                _searchController.text = "";
                setState(() {
                  iterableRows = widget.rowData;
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
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Age',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Role',
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
