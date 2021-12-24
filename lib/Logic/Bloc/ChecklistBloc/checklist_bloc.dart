import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListScreenBloc
    extends Bloc<CheckListScreenEvent, CheckListScreenState> {
  CheckListScreenBloc() : super(CheckListScreenState()) {
    on<AddCard>(_onAddCardEvent);
  }

  void _onAddCardEvent(AddCard event, Emitter<CheckListScreenState> emit) {
    emit(state.copyWith(taskWidgets: state.taskWidgets + [event.newTaskCard]));
  }
}
