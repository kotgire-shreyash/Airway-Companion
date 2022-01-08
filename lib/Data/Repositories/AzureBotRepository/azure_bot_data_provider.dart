import 'dart:convert';

import 'package:http/http.dart' as http;

class AzureBotAPI {
  final String connectionEndpoint =
      "https://ac-qnamaker-service.azurewebsites.net/qnamaker/knowledgebases/f1c8a711-3c10-467c-92ab-0e2c4dbc5855/generateAnswer";
  final String endPointKey = "6f895546-317f-426f-8c93-821eff4a0ce0";

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
