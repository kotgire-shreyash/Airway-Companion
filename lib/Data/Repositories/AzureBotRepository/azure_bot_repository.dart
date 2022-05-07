import 'dart:convert';

import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_data_provider.dart';

// Azure Bot Repository
class AzureBotRepository {
  final AzureBotAPI _azureBotAPI = AzureBotAPI();

  // Query requests through this function
  Future communicate(String question) async {
    var rawAzureBotResponse =
        await _azureBotAPI.getAzureBotQueryResponse(question);
    var azureBotResponseJSON = await jsonDecode(rawAzureBotResponse.body);

    print("################## $azureBotResponseJSON");

    return azureBotResponseJSON['answers'][0]['answer'];
  }
}
