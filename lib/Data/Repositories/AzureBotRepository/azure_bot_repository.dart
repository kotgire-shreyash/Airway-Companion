import 'dart:convert';

import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_data_provider.dart';

class AzureBotRepository {
  final AzureBotAPI _azureBotAPI = AzureBotAPI();

  Future communicate(String question) async {
    var rawAzureBotResponse =
        await _azureBotAPI.getAzureBotQueryResponse(question);
    var azureBotResponseJSON = await jsonDecode(rawAzureBotResponse.body);

    // print(azureBotResponseJSON['answers'][0]['answer']);
    return azureBotResponseJSON['answers'][0]['answer'];
  }
}
