import 'dart:convert';
import 'package:http/http.dart' as http;

//  Azure Bot API Source
class AzureBotAPI {
  // Connection endpoint
  final String connectionEndpoint =
      "https://hackfest-qnamaker.azurewebsites.net/qnamaker/knowledgebases/cb1e8f86-2270-4c9d-bdde-b8bb6f305ebe/generateAnswer";
  final String endPointKey = "09492432-c2dd-4031-b9db-730f4daac64b";

  // Returns answers corresponding to the user queries
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
