import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';

class CheckListScreenState {
  var taskWidgets;

  // bool isChecked;

  CheckListScreenState({
    this.taskWidgets = const [],
  });

  CheckListScreenState copyWith({var taskWidgets}) {
    return CheckListScreenState(
      taskWidgets: taskWidgets ?? this.taskWidgets,
    );
  }

  final _initialTaskWidgets = [
    TaskCard(
      taskClassObject: TaskClass(
        title: 'Documents',
        todolist: [
          'aadhar',
          'pancard',
          'passport',
          'gate pass',
          'vaccination Certificate',
        ],
        iconData: Icons.document_scanner,
      ),
    ),
    TaskCard(
      taskClassObject: TaskClass(
        title: 'Utilities',
        todolist: [
          'Charger',
          'Powerbank',
          'Headphones',
        ],
        iconData: Icons.cable_sharp,
      ),
    ),
    TaskCard(
      taskClassObject: TaskClass(
        title: 'Covid Necessary',
        todolist: [
          'Mask',
          'Hand Sanitizer',
          'RTPCR Report',
        ],
        iconData: Icons.coronavirus_outlined,
      ),
    ),
  ];
}
