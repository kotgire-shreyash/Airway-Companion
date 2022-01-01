import 'package:airwaycompanion/Data/Repositories/AzureTranslatorRepository/azure_translator_repository.dart';
import 'package:airwaycompanion/Modules/Guidelines/Events/guideline_events.dart';
import 'package:airwaycompanion/Modules/Guidelines/Screens/guideline_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuidelineScreenBloc
    extends Bloc<GuidelineScreenEvent, GuidelineScreenState> {
  final AzureTranslatorRepository _azureTranslatorRepository =
      AzureTranslatorRepository();

  GuidelineScreenBloc() : super(GuidelineScreenState()) {
    on<TranslateEvent>(_onTranslateEvent);
  }

  void _onTranslateEvent(
      TranslateEvent event, Emitter<GuidelineScreenState> emit) async {
    emit(state.copyWith(isBeingTranslated: true));

    var translatedList = await _azureTranslatorRepository.getTranslatedList(
        state.prevLanguage, event.to, event.content);

    emit(state.copyWith(
        guidelineCardList: translatedList,
        isBeingTranslated: false,
        prevLanguage: event.to));
  }
}
