import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen({Key? key, required this.chatbot}) : super(key: key);
  final ChatBot chatbot;
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
          floatingActionButton: widget.chatbot,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                        onPressed: () async {
                          var _uniqueKey = UniqueKey();

                          Map<String, dynamic> dataMap = {
                            "cardIndex": state.taskWidgets.length,
                            "isChecked": false,
                            "title": "something",
                            "a": "aadhar",
                            "b": "pancard",
                          };

                          context.read<CheckListScreenBloc>().add(
                                AzureTableCardAddition(
                                  checkListCardMap: dataMap,
                                ),
                              );

                          // var result = await state.getAzureCardTable();
                          // print(result);
                          // context.read<CheckListScreenBloc>().add(
                          //       AddCard(
                          //         newTaskCard: Dismissible(
                          //           key: _uniqueKey,
                          //           child: TaskCard(
                          //             cardIndex: result['cardIndex'],
                          //             taskClassObject: TaskClass(
                          //               isChecked: result["isChecked"],
                          //               title: result["title"],
                          //               iconData: Icons.task_rounded,
                          //               todolist: [
                          //                 [result["a"], false],
                          //                 [result["b"], false],
                          //                 [result["a"], false],
                          //                 [result["b"], false],
                          //                 [result["a"], false],
                          //               ],
                          //             ),
                          //           ),
                          //           onDismissed: (direction) {
                          //             context.read<CheckListScreenBloc>().add(
                          //                 DeleteCard(uniqueKey: _uniqueKey));
                          //           },
                          //         ),
                          //       ),
                          //     );
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
                      // height: 80,
                      width: MediaQuery.of(context).size.width / 1.2,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 20),
                      child: Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "Complete the following tasks for hassle-free travel!",
                              textStyle: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 20,
                                  fontFamily: _latoBoldFontFamily,
                                  fontWeight: FontWeight.w900),
                              speed: const Duration(milliseconds: 60),
                            )
                          ],
                          repeatForever: true,
                          pause: const Duration(seconds: 2),
                          stopPauseOnTap: false,
                        ),
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 8,
                    child: SizedBox(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Center(
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
