import 'dart:convert';

import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListScreenBloc
    extends Bloc<CheckListScreenEvent, CheckListScreenState> {
  CheckListScreenBloc() : super(CheckListScreenState()) {
    on<AddCard>(_onAddCardEvent);
    on<CheckBoxPressed>(_onCheckBoxPressedEvent);
    on<DeleteCard>(_onDeleteCardEvent);
    on<AzureTableCardAddition>(_onAzureTableCardAdditionEvent);
    on<AddFieldsEvent>(_onAddFieldsEvent);
  }

  void _onAddCardEvent(AddCard event, Emitter<CheckListScreenState> emit) {
    print("NO ISSUES");
    emit(state.copyWith(taskWidgets: state.taskWidgets + [event.newTaskCard]));
  }

  void _onAddFieldsEvent(
      AddFieldsEvent event, Emitter<CheckListScreenState> emit) {
    emit(state.copyWith(
        fieldsList: state.fieldsList +
            [
              Container(
                height: 50,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(top: 15, left: 10),
                        width: 250,
                        height: 50,
                        child: Text(
                          event.fieldTitle,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]));
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

// AZURE DATABASE
// ##########################################################################################################################
  void _onAzureTableCardAdditionEvent(
      AzureTableCardAddition event, Emitter<CheckListScreenState> emit) async {
    state.uploadCheckListCardData(event.checkListCardMap);
    var result = await state.getAzureCardTable();
    var jsonData = await jsonDecode(result);
    print(jsonData.runtimeType);

    _onAddCardEvent(
        AddCard(
          newTaskCard: Dismissible(
            key: UniqueKey(),
            child: TaskCard(
              cardIndex: jsonData['cardIndex'],
              taskClassObject: TaskClass(
                isChecked: jsonData["isChecked"],
                title: jsonData["title"],
                iconData: Icons.task_rounded,
                todolist: [
                  [jsonData["a"], false],
                  [jsonData["b"], false],
                  [jsonData["a"], false],
                  [jsonData["b"], false],
                  [jsonData["a"], false],
                ],
              ),
            ),
            onDismissed: (direction) {},
          ),
        ),
        emit);
  }
}


// ##########################################################################################################################
