import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_repository.dart';
import 'package:flutter/material.dart';

class AzureBotState {
  var azureBotRepository;
  bool azureBotQueryStatus;
  String azureBotQueryResponse;
  List<Widget> queryList;

  AzureBotState({
    this.azureBotRepository,
    this.azureBotQueryResponse = "",
    this.azureBotQueryStatus = false,
    this.queryList = const [],
  });

  AzureBotState copyWith({
    var azureBotRepository,
    var azureBotQueryResponse,
    var azureBotQueryStatus,
    var queryList,
  }) {
    return AzureBotState(
      azureBotRepository: azureBotRepository ?? this.azureBotRepository,
      azureBotQueryResponse: azureBotQueryResponse ?? "",
      azureBotQueryStatus: azureBotQueryStatus ?? this.azureBotQueryStatus,
      queryList: queryList ?? this.queryList,
    );
  }
}
