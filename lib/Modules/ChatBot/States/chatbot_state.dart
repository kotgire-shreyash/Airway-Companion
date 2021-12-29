import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_repository.dart';

class AzureBotState {
  var azureBotRepository;
  bool azureBotQueryStatus;
  String azureBotQueryResponse;

  AzureBotState({
    this.azureBotRepository,
    this.azureBotQueryResponse = "",
    this.azureBotQueryStatus = false,
  });

  AzureBotState copyWith({
    var azureBotRepository,
    var azureBotQueryResponse,
    var azureBotQueryStatus,
  }) {
    return AzureBotState(
      azureBotRepository: azureBotRepository ?? this.azureBotRepository,
      azureBotQueryResponse: azureBotQueryResponse ?? "",
      azureBotQueryStatus: azureBotQueryStatus ?? this.azureBotQueryStatus,
    );
  }
}
