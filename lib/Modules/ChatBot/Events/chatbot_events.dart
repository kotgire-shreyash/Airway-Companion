abstract class AzureBotEvent {}

class MessageQueryRequestToAzure extends AzureBotEvent {
  String question;
  MessageQueryRequestToAzure({required this.question});
}

class ClearAzureQueryResponse extends AzureBotEvent {}

class AddResponse extends AzureBotEvent {
  var responseWidget;
  AddResponse({required this.responseWidget});
}
