import 'package:flutter/material.dart';

class ProjectDetailCard extends StatefulWidget {
  final String phaseName;
  final List<dynamic> phaseData;
  const ProjectDetailCard({
    Key? key,
    required this.phaseName,
    required this.phaseData,
  }) : super(key: key);

  @override
  State<ProjectDetailCard> createState() => _ProjectDetailCardState();
}

class _ProjectDetailCardState extends State<ProjectDetailCard> {
  List<Widget> get cardContent {
    var widgetList = <Widget>[];
    if (widget.phaseData.isEmpty) return widgetList;
    
    for (var element in widget.phaseData) {
      var data = element as Map<String, dynamic>;
      data.forEach(
        (key, value) {
          widgetList.add(Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  key.toString().toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(value.toString()),
              ],
            ),
          ));
        },
      );
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      width: mediaQuery.size.width * 0.7,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.phaseName,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: mediaQuery.size.width * 0.6,
                      child: const Divider(),
                    ),
                  ],
                ),
              ),
              ...cardContent
            ],
          ),
        ),
      ),
    );
  }
}
