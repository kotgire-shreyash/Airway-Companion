import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_repository.dart';
import 'package:airwaycompanion/Modules/ChatBot/Events/chatbot_events.dart';
import 'package:airwaycompanion/Modules/ChatBot/States/chatbot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzureBotBloc extends Bloc<AzureBotEvent, AzureBotState> {
  final AzureBotRepository _azureBotRepository = AzureBotRepository();

  AzureBotBloc() : super(AzureBotState()) {
    on<MessageQueryRequestToAzure>(_onMessageQueryRequestToAzureEvent);
    on<ClearAzureQueryResponse>(_onClearAzureQueryResponseEvent);
    on<AddResponse>(_onAddResponseEvent);
  }

  void _onMessageQueryRequestToAzureEvent(
      MessageQueryRequestToAzure event, Emitter<AzureBotState> emit) async {
    emit(state.copyWith(
        azureBotQueryStatus: true, azureBotRepository: _azureBotRepository));
    var _azureBotQueryResponse =
        await state.azureBotRepository.communicate(event.question);
    emit(state.copyWith(
      azureBotQueryResponse: _azureBotQueryResponse,
      azureBotQueryStatus: false,
    ));

    // emit(state.copyWith(azureBotQueryStatus: false));
  }

  void _onClearAzureQueryResponseEvent(
      ClearAzureQueryResponse event, Emitter<AzureBotState> emit) {
    emit(state.copyWith(azureBotQueryResponse: ""));
  }

  void _onAddResponseEvent(AddResponse event, Emitter<AzureBotState> emit) {
    emit(state.copyWith(queryList: state.queryList + [event.responseWidget]));
  }
}
