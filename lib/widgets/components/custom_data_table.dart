import 'package:flutter/material.dart';

class CustomDataTable extends StatefulWidget {
  const CustomDataTable({Key? key}) : super(key: key);

  @override
  State<CustomDataTable> createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  String? _searchValues;
  final _searchController = TextEditingController();

  List<DataRow> rowData = const [
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Sarah')),
        DataCell(Text('19')),
        DataCell(Text('Student')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('Janine')),
        DataCell(Text('43')),
        DataCell(Text('Professor')),
      ],
    ),
    DataRow(
      cells: <DataCell>[
        DataCell(Text('William')),
        DataCell(Text('27')),
        DataCell(Text('Associate Professor')),
      ],
    ),
  ];

  void _searchAction(String searchText) {
    if (searchText.isNotEmpty) {
      print(searchText);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                _searchValues = value;
                _searchAction(value);
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                _searchController.text = "";
                _searchValues = "";
              },
            ),
          ),
        ),
        DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Age',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Role',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: rowData,
        ),
      ],
    );
  }
}
