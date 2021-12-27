import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListScreenBloc
    extends Bloc<CheckListScreenEvent, CheckListScreenState> {
  CheckListScreenBloc() : super(CheckListScreenState()) {
    on<AddCard>(_onAddCardEvent);
    on<CheckBoxPressed>(_onCheckBoxPressedEvent);
    on<DeleteCard>(_onDeleteCardEvent);
  }

  void _onAddCardEvent(AddCard event, Emitter<CheckListScreenState> emit) {
    emit(state.copyWith(taskWidgets: state.taskWidgets + [event.newTaskCard]));
  }

  void _onDeleteCardEvent(
      DeleteCard event, Emitter<CheckListScreenState> emit) {
    print(state.taskWidgets.length);
    state.taskWidgets.removeWhere((element) => element.key == event.uniqueKey);
    print(state.taskWidgets.length);
    emit(state.copyWith(taskWidgets: state.taskWidgets));
  }

  void _onCheckBoxPressedEvent(
      CheckBoxPressed event, Emitter<CheckListScreenState> emit) {
    state.taskWidgets[event.cardIndex].child.taskClassObject
            .todolist[event.index][1] =
        !state.taskWidgets[event.cardIndex].child.taskClassObject
            .todolist[event.index][1];

    emit(state.copyWith(taskWidgets: state.taskWidgets));
  }
}
