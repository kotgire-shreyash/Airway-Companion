import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/taskcard_screen.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_class.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatefulWidget {
  TaskCard({required this.taskClassObject});
  final TaskClass taskClassObject;

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final _latoBoldFontFamily =
        GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
    return InkWell(
      onLongPress: () {},
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(top: 12),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 18, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      widget.taskClassObject.iconData,
                      color: Colors.cyan,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.taskClassObject.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: _latoBoldFontFamily,
                          fontWeight: FontWeight.w900),
                      textScaleFactor: 1.6,
                    ),
                  ],
                ),
              ),
              BlocBuilder<CheckListScreenBloc, CheckListScreenState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.taskClassObject.todolist.length,
                    itemBuilder: (context, int index) {
                      return ToDoTile(
                        title: widget.taskClassObject.todolist[index],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
