import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/taskcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatefulWidget {
  TaskCard({required this.taskClassObject, required this.cardIndex});
  final TaskClass taskClassObject;
  int cardIndex;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final _latoBoldFontFamily =
        GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 280,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
            ListView.builder(
                shrinkWrap: true,
                itemCount: widget.taskClassObject.todolist.length,
                itemBuilder: (context, int index) {
                  return BlocBuilder<CheckListScreenBloc, CheckListScreenState>(
                    builder: (context, state) {
                      return CheckboxListTile(
                        value: state.taskWidgets[widget.cardIndex]
                            .taskClassObject.todolist[index][1],
                        activeColor: Colors.red,
                        onChanged: (value) {
                          context.read<CheckListScreenBloc>().add(
                                CheckBoxPressed(
                                  isCheckBoxPressed: !state.isChecked,
                                  index: index,
                                  cardIndex: widget.cardIndex,
                                ),
                              );
                        },
                        title: Text(widget.taskClassObject.todolist[index][0]),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  );
                }),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

class TaskClass {
  TaskClass(
      {required this.title,
      required this.todolist,
      this.iconData,
      this.isChecked = false});
  final title;
  final todolist;
  final iconData;
  bool isChecked;
}
