import 'dart:convert';

import 'package:http/http.dart' as http;

class AzureTranslatorAPI {
  final String connectionAPIString =
      "https://api.cognitive.microsofttranslator.com";

  final String endpointKey = "884053c42d82417aa9a4a244dfa99744";

  // Receives content as a map of guidelines
  Future<http.Response> getAzureTranslatorResponseEncoded(
      String from, String to, var content) async {
    List body = [
      {"Text": content['title']},
      {"Text": content['collapsedBody']},
      {"Text": content['body']}
    ];

    try {
      return await http.post(
        Uri.parse(connectionAPIString +
            "/translate?api-version=3.0&from=$from&to=$to"),
        headers: <String, String>{
          "Ocp-Apim-Subscription-Key": endpointKey,
          "Content-Type": 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body),
      );
    } catch (e) {
      rethrow;
    }
  }
}