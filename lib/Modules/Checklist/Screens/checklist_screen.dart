import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckListScreenBloc, CheckListScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: SafeArea(
              child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 35,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          context.read<CheckListScreenBloc>().add(
                                AddCard(
                                  newTaskCard: TaskCard(
                                    cardIndex: state.taskWidgets.length,
                                    taskClassObject: TaskClass(
                                      isChecked: false,
                                      title: "Something",
                                      todolist: [
                                        ['aadhar', false],
                                        ['pancard', false],
                                        ['passport', false],
                                        ['gate pass', false],
                                        ['vaccination Certificate', false],
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
              Flexible(
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.taskWidgets.length,
                    itemBuilder: (context, int index) {
                      return BlocBuilder<CheckListScreenBloc,
                          CheckListScreenState>(
                        builder: (context, state) {
                          return state.taskWidgets[index];
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          )),
        );
      },
    );
  }

  _getItems() {
    for (var item in taskList) {
      // _todoWidgets.add(
      //   Dismissible(
      //     key: Key(item.title),
      //     child: TaskCard(
      //       taskClassObject: item,
      //     ),
      //   ),
      // );
    }
  }

  final List<TaskClass> taskList = [
    TaskClass(
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
    TaskClass(
      title: 'Utilities',
      todolist: [
        'Charger',
        'Powerbank',
        'Headphones',
      ],
      iconData: Icons.cable_sharp,
    ),
    TaskClass(
      title: 'Covid Necessary',
      todolist: [
        'Mask',
        'Hand Sanitizer',
        'RTPCR Report',
      ],
      iconData: Icons.coronavirus_outlined,
    ),
  ];
}
