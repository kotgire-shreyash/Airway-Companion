import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
<<<<<<< HEAD

=======
>>>>>>> master
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                widget.taskClassObject.title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    // fontFamily: _latoBoldFontFamily,
                    fontWeight: FontWeight.w900),
                textScaleFactor: 1.6,
              ),
              // if clicked on text then it will convert to text field
              TextField()
            ],
          )
        ],
      )),
    );
  }
}

//
// create a column 
// in which row will have icon + title of taskcard  
// on clicking icon will be updated using icon picker
// on clicking title it will be converted to text field
// also todo also have option to be updated
// after that list of todo's will be displayed
// an action button to add a todo in list
//