import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              width: MediaQuery.of(context).size.width,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    widget.taskClassObject.iconData,
                    color: Colors.blue,
                    size: 30,
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
                    textScaleFactor: 1.15,
                    overflow: TextOverflow.clip,
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                    ),
                  )
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
                                  index: index,
                                  cardIndex: widget.cardIndex,
                                ),
                              );
                        },
                        title: Text(state.taskWidgets[widget.cardIndex]
                            .taskClassObject.todolist[index][0]),
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
  var title;
  var todolist;
  var iconData;
  bool isChecked;
}
