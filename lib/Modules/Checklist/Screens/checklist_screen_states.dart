import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_class.dart';
import 'package:flutter/material.dart';

class CheckListScreenState {
  List<Widget> todoWidgets = <Widget>[
    TaskCard(
      taskClassObject: TaskClass(
        title: 'Temp CARD',
        todolist: ['one', 'two'],
      ),
    ),
  ];
  var taskCard;
  // bool isChecked;

  CheckListScreenState({
    this.taskCard,
  });

  CheckListScreenState copyWith({var taskCard}) {
    if (taskCard != null) {
      todoWidgets.add(taskCard);
      print(todoWidgets.length);
    }

    return CheckListScreenState(
      taskCard: taskCard ?? this.taskCard,
    );
  }
}
