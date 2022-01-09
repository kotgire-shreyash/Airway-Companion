import 'dart:convert';

import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckListScreenBloc
    extends Bloc<CheckListScreenEvent, CheckListScreenState> {
  CheckListScreenBloc() : super(CheckListScreenState()) {
    on<CheckBoxPressed>(_onCheckBoxPressedEvent);
    on<DeleteCard>(_onDeleteCardEvent);
    on<AzureTableCardAddition>(_onAzureTableCardAdditionEvent);
    on<AddFieldsEvent>(_onAddFieldsEvent);
    on<AzureDataRetrieveEvent>(_onRetrieveCardsFromAzureDatabase);
  }

  void _onAddFieldsEvent(
      AddFieldsEvent event, Emitter<CheckListScreenState> emit) {
    emit(state.copyWith(
      fieldsList: state.fieldsList +
          [
            _fieldRowWidget(event.fieldTitle),
          ],
      fieldsNameList: state.fieldsNameList + ["${event.fieldTitle}"],
    ));
  }

  _onDeleteCardEvent(
      DeleteCard event, Emitter<CheckListScreenState> emit) async {
    await state.deleteTable(event.title);
    await _onRetrieveCardsFromAzureDatabase(AzureDataRetrieveEvent(), emit);
  }

  void _onCheckBoxPressedEvent(
      CheckBoxPressed event, Emitter<CheckListScreenState> emit) {
    state.taskWidgets[event.cardIndex].taskClassObject.todolist[event.index]
            [1] =
        !state.taskWidgets[event.cardIndex].taskClassObject
            .todolist[event.index][1];

    emit(state.copyWith(taskWidgets: state.taskWidgets));
  }

// AZURE DATABASE
  void _onAzureTableCardAdditionEvent(
      AzureTableCardAddition event, Emitter<CheckListScreenState> emit) async {
    emit(state.copyWith(isDataBeingUpdated: true));
    try {
      await state.uploadCheckListCardData(event.checkListCardMap);
      await _onRetrieveCardsFromAzureDatabase(AzureDataRetrieveEvent(), emit);
    } catch (e) {
      emit(state.copyWith(isDataBeingUpdated: false));
      rethrow;
    }
    emit(state.copyWith(
        isDataBeingUpdated: false,
        fieldsList: const <Widget>[],
        fieldsNameList: const <String>[]));
  }

  _onRetrieveCardsFromAzureDatabase(
      AzureDataRetrieveEvent event, Emitter<CheckListScreenState> emit) async {
    emit(state.copyWith(isDataBeingUpdated: true));
    List<String?> retrievedListFromAzureStorage =
        await state.azureStorage.getTables();
    var taskCardList = [];
    int index = 0;
    for (String? table in retrievedListFromAzureStorage) {
      try {
        var result = await state.getAzureCardTable(table ?? "");
        Map jsonData = await jsonDecode(result);
        var fieldsList = [];

        for (var field in jsonData.keys) {
          if (field != "PartitionKey" &&
              field != "RowKey" &&
              field != "Timestamp" &&
              field != "isChecked" &&
              field != "title") {
            fieldsList.add([jsonData[field], false]);
          }
        }

        taskCardList.add(
          TaskCard(
              taskClassObject: TaskClass(
                title: jsonData["title"],
                todolist: fieldsList,
              ),
              cardIndex: index++),
        );
      } catch (e) {
        rethrow;
      }
    }

    emit(state.copyWith(
      taskWidgets: taskCardList,
      isDataBeingUpdated: false,
    ));
  }

  Widget _fieldRowWidget(String title) {
    return SizedBox(
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
                title,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 15),
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
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
