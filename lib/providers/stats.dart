import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/statistique.dart';
import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class Stats with ChangeNotifier {
  final String? authToken;
  Stats({this.authToken});

  List<Statistique>? _setDataGraph(
    List<dynamic> labels,
    List<dynamic> data,
    int total,
  ) {
    if (labels.isEmpty) {
      return null;
    }

    List<Statistique> graphData = <Statistique>[];
    for (var i = 0; i < labels.length; i++) {
      graphData.add(Statistique(i, data[i], labels[i]));
    }
    return graphData;
  }

  Future<List<Statistique>?> getStatsParticipants() async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/stats/participants",
    );
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $authToken"},
      );
      final responseData = jsonDecode(response.body);
      return _setDataGraph(
        responseData["labels"] as List<dynamic>,
        responseData["data"] as List<dynamic>,
        responseData["total"] as int,
      );
    } catch (e) {
      throw HttpException("Veuillez réssayer ultérieurement");
    }
  }

  Future<List<Statistique>?> getStatsTeamByPhase() async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/stats/phases",
    );
    try {
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $authToken"},
      );
      final responseData = jsonDecode(response.body);
      return _setDataGraph(
        responseData["labels"] as List<dynamic>,
        responseData["data"] as List<dynamic>,
        responseData["total"] as int,
      );
    } catch (e) {
      throw HttpException("Veuillez réssayer ultérieurement");
    }
  }
}
