import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';

class TaskCardScreen extends StatefulWidget {
  const TaskCardScreen({required this.taskClassObject});
  final TaskClass taskClassObject;

  @override
  _TaskCardScreenState createState() => _TaskCardScreenState();
}

class _TaskCardScreenState extends State<TaskCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.red,
            height: 50,
          ),
        ],
      )),
    );
  }
}
