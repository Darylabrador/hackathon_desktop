import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/statistique.dart';
import '../models/particpants.dart';
import '../models/team_by_phase.dart';
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

  Future<List<Participants>> getParticipantsDataTableInfo() async {
    List<Participants> participantList = <Participants>[];
    final url = Uri.parse("${ConstantVariables.startingURL}/users");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      final responseData = jsonDecode(response.body)["data"] as List<dynamic>;

      for (var element in responseData) {
        participantList.add(Participants(
          id: element["id"],
          email: element["email"],
          surname: element["surname"],
          firstname: element["firstname"],
          gender: element["gender"],
          role: element["role"],
          teamName:
              element["team"].toString().isEmpty ? "" : element["team"]["name"],
          createdAt: element["created"],
        ));
      }

      return participantList;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }

  Future<List<TeamByPhase>> getTeamByPhaseDataTableInfo() async {
    List<TeamByPhase> teamPhaseList = <TeamByPhase>[];
    final url = Uri.parse("${ConstantVariables.startingURL}/projects");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );
      final responseData = jsonDecode(response.body)["data"] as List<dynamic>;

      if (responseData.isEmpty) return teamPhaseList;

      print(responseData);
      for (var element in responseData) {
        final team = element["team"];
        final teamName = team["name"];
        final teamMembers = team["members"] as List<dynamic>;
        final teamActualPhase = team["phase_actuel"];
        final leaderInfo =
            teamMembers.firstWhere((data) => data['leader'] == 1)["user"];
        final projectData = element["project"] != null ? element["project"]["project_data"] as List<dynamic> : [];
        final projectId = element["id"];

        teamPhaseList.add(TeamByPhase(
          projectId: projectId,
          teamName: teamName,
          leader: "${leaderInfo['surname']} ${leaderInfo['firstname']}",
          phaseActual: teamActualPhase,
          projectData: projectData,
        ));
      }
      return teamPhaseList;
    } catch (e) {
      print(e.toString());
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }
}
