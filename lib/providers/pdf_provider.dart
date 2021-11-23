import 'dart:async';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/http_exception.dart';
import '../utils/constant_variables.dart';

class PDFProvider with ChangeNotifier {
  final String? authToken;
  PDFProvider({this.authToken});

  Future<Uint8List> getSinglePdfFile(int projectId) async {
    final url = Uri.parse(
      "${ConstantVariables.startingURL}/projects/$projectId",
    );

    try {
      final response = await http.readBytes(
        url,
        headers: {
          "Authorization": "Bearer $authToken",
        },
      );
      return response;
    } catch (e) {
      throw HttpException("Veuillez réessayer ultérieurement");
    }
  }
}
