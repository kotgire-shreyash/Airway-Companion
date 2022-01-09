import 'dart:convert';

import 'package:airwaycompanion/Data/Repositories/AzureTranslatorRepository/azure_translator_data_provider.dart';

// Azure Translator Repository
class AzureTranslatorRepository {
  final AzureTranslatorAPI _azureTranslatorAPI = AzureTranslatorAPI();

  // Translates the text according in the requested language
  Future translate(String from, String to, var content) async {
    var rawAzureTranslatorResponse = await _azureTranslatorAPI
        .getAzureTranslatorResponseEncoded(from, to, content);
    var azureTranslatorResponseJSON =
        await jsonDecode(rawAzureTranslatorResponse.body);

    return azureTranslatorResponseJSON;
  }

  // Receives translated text
  Future getTranslatedList(String from, String to, var content) async {
    List<Map<String, String>> translatedList = [];

    for (var body in content) {
      var _translatedContent = await translate(from, to, body);
      Map<String, String> _translatedGuidelinesMap = {
        "image": body['image'],
        "title": _translatedContent[0]['translations'][0]['text'],
        "collapsedBody": _translatedContent[1]['translations'][0]['text'],
        "body": _translatedContent[2]['translations'][0]['text'],
      };
      translatedList.add(_translatedGuidelinesMap);
    }

    return translatedList;
  }
}
