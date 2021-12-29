abstract class AzureBotEvent {}

class MessageQueryRequestToAzure extends AzureBotEvent {
  String question;
  MessageQueryRequestToAzure({required this.question});
}

class ClearAzureQueryResponse extends AzureBotEvent {}
