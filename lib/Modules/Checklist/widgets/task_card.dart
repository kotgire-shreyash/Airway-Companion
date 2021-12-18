import 'package:airwaycompanion/Modules/Checklist/Screens/taskcard_screen.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_class.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskCard extends StatelessWidget {
  TaskCard({required this.taskClassObject});
  final taskClass taskClassObject;

  @override
  Widget build(BuildContext context) {
    final _latoBoldFontFamily =
        GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
    return InkWell(
      onLongPress: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => TaskCardScreen(
        //       taskClassObject: taskClassObject,
        //     ),
        //   ),
        // );
      },
      child: Container(
        width: 280,
        margin: EdgeInsets.only(top: 12),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 18, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      taskClassObject.iconData,
                      color: Colors.cyan,
                      size: 40,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      taskClassObject.title,
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
                  itemCount: taskClassObject.todolist.length,
                  itemBuilder: (context, int index) {
                    return ToDoTile(
                      title: taskClassObject.todolist[index],
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
