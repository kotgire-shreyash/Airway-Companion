import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({Key? key}) : super(key: key);

  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  static int cardIndex = 0;
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
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Container(
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
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          var _uniqueKey = UniqueKey();
                          context.read<CheckListScreenBloc>().add(
                                AddCard(
                                  newTaskCard: Dismissible(
                                    key: _uniqueKey,
                                    child: TaskCard(
                                      cardIndex: state.taskWidgets.length,
                                      taskClassObject: TaskClass(
                                        isChecked: false,
                                        title: "Something",
                                        iconData: Icons.task_rounded,
                                        todolist: [
                                          ['aadhar', false],
                                          ['pancard', false],
                                          ['passport', false],
                                          ['gate pass', false],
                                          ['vaccination Certificate', false],
                                        ],
                                      ),
                                    ),
                                    onDismissed: (direction) {
                                      context.read<CheckListScreenBloc>().add(
                                          DeleteCard(uniqueKey: _uniqueKey));
                                    },
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
                expandedHeight: 300,
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 80, left: 50, right: 50),
                  color: Colors.white,
                  height: 350,
                  width: 200,
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/tasks.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width / 1.2,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Complete the following tasks for hassle-free travel!",
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 15,
                            fontFamily: _latoBoldFontFamily,
                            fontWeight: FontWeight.w900),
                        textScaleFactor: 1.4,
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 8,
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ListView.builder(
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
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Flexible(
                  //   flex: 5,
                  //   child:
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  final List<Widget> taskList = [
    Dismissible(
      key: UniqueKey(),
      child: TaskCard(
        cardIndex: 0,
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
      onDismissed: (direction) {},
    ),
    Dismissible(
      key: UniqueKey(),
      child: TaskCard(
        cardIndex: 0,
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
      onDismissed: (direction) {},
    ),
    Dismissible(
      key: UniqueKey(),
      child: TaskCard(
        cardIndex: 0,
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
      onDismissed: (direction) {},
    ),
  ];
}
