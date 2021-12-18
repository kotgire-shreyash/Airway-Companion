import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/task_data.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({Key? key}) : super(key: key);

  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;

  @override
  void initState() {
    // TODO: implement initState
    _getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20),
                  child: Text(
                    "Hi Shreyash ",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        //color: Colors.grey.shade600,
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: _latoBoldFontFamily,
                        fontWeight: FontWeight.w900),
                    textScaleFactor: 1.6,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                      onPressed: () {
                        _addCard();
                        setState(() {
                          _todoWidgets.last;
                        });
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 40,
                      )),
                ),
              ],
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "Complete the following ",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    fontFamily: _latoBoldFontFamily,
                    fontWeight: FontWeight.w900),
                textScaleFactor: 1.4,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                "tasks for hasslefree travel ",
                style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 15,
                    fontFamily: _latoBoldFontFamily,
                    fontWeight: FontWeight.w900),
                textScaleFactor: 1.4,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: _todoWidgets,
            ),
          ],
        ),
      )),
    );
  }

  // widget List of todowidgets to be displayed on checklist Screen
  final List<Widget> _todoWidgets = <Widget>[];

  //TO add task card in widget list
  _addCard() {
    _todoWidgets.add(
      TaskCard(
        taskClassObject: taskClass(
          title: 'Temp CARD',
          todolist: ['one', 'two'],
        ),
      ),
    );
  }

  // This will add initial task cards to widget list
  _getItems() {
    for (var item in taskList) {
      _todoWidgets.add(
        Dismissible(
          key: Key(item.title),
          child: TaskCard(
            taskClassObject: item,
          ),
        ),
      );
    }
  }
}
