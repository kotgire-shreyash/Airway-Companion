import 'dart:convert';

import 'package:http/http.dart' as http;

class AzureBotAPI {
  final String connectionEndpoint =
      "https://airwaycompanionqnamaker.azurewebsites.net/qnamaker/knowledgebases/5ace3c88-f973-4cdd-8392-991a85bc25d0/generateAnswer";
  final String endPointKey = "c8716b2e-b7f3-476d-ad27-134e1a941093";

  Future<http.Response> getAzureBotQueryResponse(String question) async {
    try {
      return await http.post(
        Uri.parse(connectionEndpoint),
        headers: <String, String>{
          "Authorization": endPointKey,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'question': question,
        }),
      );
    } catch (e) {
      rethrow;
    }
  }
}
