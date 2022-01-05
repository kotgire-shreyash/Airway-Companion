import 'package:airwaycompanion/Logic/Bloc/ChecklistBloc/checklist_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen_states.dart';
import 'package:airwaycompanion/Modules/Checklist/widgets/task_card.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:azstore/azstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckListScreen extends StatefulWidget {
  const CheckListScreen(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final CustomBottomNavigationBar bottomBar;
  @override
  _CheckListScreenState createState() => _CheckListScreenState();
}

class _CheckListScreenState extends State<CheckListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
  final TextEditingController _mainTitleTextController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  var fieldTitle, mainTitle;
  final _fieldsList = [];

  @override
  void initState() {
    CustomBottomNavigationBar.index = -1;
    if (context.read<CheckListScreenBloc>().state.taskWidgets.isEmpty) {
      context
          .read<CheckListScreenBloc>()
          .add(AzureDataRetrieveEvent(isDataBeingUpdated: true));
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // To perform on refresh
  void _onRefresh() {
    context
        .read<CheckListScreenBloc>()
        .add(AzureDataRetrieveEvent(isDataBeingUpdated: true));
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
          bottomNavigationBar: widget.bottomBar,
          body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.only(left: 5),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () async {
                          if (!state.isDataBeingUpdated) {
                            await _dialogPopUp();
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 28,
                        )),
                  ),
                ],
                expandedHeight: 220,
                flexibleSpace: Container(
                  margin: const EdgeInsets.only(top: 80, left: 50, right: 50),
                  color: Colors.white,
                  height: 220,
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
                    flex: 2,
                    child: Container(
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
                                  fontSize: 18,
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
                    child:
                        !state.isDataBeingUpdated && state.taskWidgets.isEmpty
                            ? Center(
                                child: SizedBox(
                                    height: 300,
                                    child: Center(
                                        child: Text(
                                      "Nothing to display",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily),
                                    ))),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: state.isDataBeingUpdated
                                    ? 10
                                    : state.taskWidgets.length,
                                itemBuilder: (context, int index) {
                                  return BlocBuilder<CheckListScreenBloc,
                                      CheckListScreenState>(
                                    builder: (context, state) {
                                      return state.isDataBeingUpdated
                                          ? SizedBox(
                                              height: 250,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  50,
                                              child: Center(
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: LoadingAnimationWidget
                                                      .staggeredDotWave(
                                                          color: Colors.black,
                                                          size: 30),
                                                ),
                                              ),
                                            )
                                          : Dismissible(
                                              key: Key(state.taskWidgets[index]
                                                  .taskClassObject.title),
                                              child: state.taskWidgets[index],
                                              onDismissed: (direction) {
                                                context
                                                    .read<CheckListScreenBloc>()
                                                    .add(DeleteCard(
                                                        title: state
                                                            .taskWidgets[index]
                                                            .taskClassObject
                                                            .title));
                                              },
                                            );
                                    },
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Popup Widget
  _dialogPopUp() {
    return showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<CheckListScreenBloc, CheckListScreenState>(
            builder: (context, state) {
          return state.isDataBeingUpdated
              ? const Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      )),
                )
              : Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 16,
                  child: SizedBox(
                    height: 350,
                    width: 300,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Center(
                              child: Text(
                            'Create a checklist',
                            style: TextStyle(
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.bold)
                                      .fontFamily,
                              fontSize: 18,
                            ),
                          )),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      // name textfield
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 32.0),
                                        child: TextFormField(
                                          controller: _mainTitleTextController,
                                          decoration: const InputDecoration(
                                              hintText: 'Title'),
                                          onChanged: (value) {
                                            mainTitle = value;
                                          },
                                          validator: (v) {
                                            if (v!.trim().isEmpty) {
                                              return 'Please enter something';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Add fields',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      )
                                    ] +
                                    context
                                        .read<CheckListScreenBloc>()
                                        .state
                                        .fieldsList +
                                    [
                                      _textInputFieldWidget(),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (mainTitle != null &&
                                              mainTitle != "") {
                                            Map<String, dynamic> dataMap = {
                                              "title":
                                                  mainTitle.replaceAll(" ", ""),
                                            };

                                            int index = 0;
                                            for (var field
                                                in state.fieldsNameList) {
                                              dataMap["field$index"] = field;
                                              index++;
                                            }

                                            context
                                                .read<CheckListScreenBloc>()
                                                .add(AzureTableCardAddition(
                                                  checkListCardMap: dataMap,
                                                ));

                                            _mainTitleTextController.clear();
                                          }

                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          }
                                        },
                                        child: const Text('Save'),
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        });
      },
    );
  }

  Widget _textInputFieldWidget() {
    return SizedBox(
      height: 50,
      width: 300,
      child: Row(
        children: [
          Flexible(
            child: SizedBox(
              width: 250,
              height: 50,
              child: TextFormField(
                onChanged: (value) {
                  fieldTitle = value;
                },
                decoration: const InputDecoration(hintText: 'Enter Field'),
              ),
            ),
          ),
          SizedBox(
            child: InkWell(
              onTap: () {
                if (fieldTitle != null && fieldTitle != "") {
                  context.read<CheckListScreenBloc>().add(
                        AddFieldsEvent(
                          fieldTitle: fieldTitle,
                        ),
                      );

                  fieldTitle = null;
                }
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
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
