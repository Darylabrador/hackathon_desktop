import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/phase.dart';
import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class PhaseProvider with ChangeNotifier {
  final String? authToken;
  PhaseProvider({this.authToken});
  List<Phase>? _phases;

  List<Phase>? get phaseList {
    if (_phases!.isEmpty) {
      return null;
    }
    return _phases;
  }

  Future<void> getPhaseList() async {
    final url = Uri.parse("${ConstantVariables.startingURL}/phases");
    List<Phase>? phasesList = <Phase>[];

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $authToken",
          "Content-Type": "application/json",
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw HttpException(jsonDecode(response.body)['message']);
      }

      final dataArray = responseData["data"] as List<dynamic>;

      for (var element in dataArray) {
        phasesList.add(
          Phase(
              id: element['id'],
              current: element['current'],
              name: element['name']),
        );
      }

      _phases = phasesList;
      notifyListeners();
    } catch (e) {
      throw HttpException(e.toString());
    }
  }
}
