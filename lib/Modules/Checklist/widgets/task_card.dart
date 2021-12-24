import 'package:airwaycompanion/Modules/Checklist/Screens/taskcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatefulWidget {
  TaskCard({required this.taskClassObject});
  final TaskClass taskClassObject;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    final _latoBoldFontFamily =
        GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
    return Container(
      width: 280,
      margin: const EdgeInsets.only(top: 12),
      child: InkWell(
        onLongPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => TaskCardScreen(
                taskClassObject: widget.taskClassObject,
              ),
            ),
          );
        },
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
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.taskClassObject.todolist.length,
                  itemBuilder: (context, int index) {
                    bool _ischecked = false;
                    return CheckboxListTile(
                      // key: ,
                      value: _ischecked,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _ischecked = !_ischecked;
                        });
                      },
                      title: Text(widget.taskClassObject.todolist[index]),
                      controlAffinity: ListTileControlAffinity.leading,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskClass {
  TaskClass({required this.title, required this.todolist, this.iconData});
  final title;
  final todolist;
  final iconData;
}
