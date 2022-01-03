// ignore_for_file: prefer_const_constructors, deprecated_member_use

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

var azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=airwaycompanionblob;AccountKey=z8NIVphTTdxv7ja06UvpU7Gyhyms4UWdVozkV/5kxvL61wxlEIE0VyVq2Fr8p3CPRwHLG/lX5/i3TLTrG0/+0A==;EndpointSuffix=core.windows.net");
TextEditingController TableName = new TextEditingController();
// ignore: non_constant_identifier_names
var Entity=[];

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
  static int cardIndex = 0;
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
  // TextEditingController TableName = new TextEditingController();
  // TextEditingController EntityName = new TextEditingController();

  @override
  void initState() {
    super.initState();
    super.initState();
    _nameController =  TextEditingController();
    // EntityName=TextEditingController();
    TableName=TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  // late TextEditingController EntityName;
  late TextEditingController TableName;
  // ignore: unused_field
  static List<String> documentList = [""];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
                          // var tableName = "";
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 16,
                                child: Container(
                                  child: ListView(
                                    shrinkWrap: true,
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Center(child: Text('Add Documents')),
                                      SizedBox(height: 20),


                                      // TextField(
                                      //   controller: TableName,
                                      //   maxLines: 1,
                                      //   style: TextStyle(fontSize: 17),
                                      //   textAlignVertical:
                                      //       TextAlignVertical.center,
                                      //   decoration: InputDecoration(
                                      //     filled: true,
                                      //     prefixIcon: Icon(
                                      //         Icons.document_scanner,
                                      //         color: Theme.of(context)
                                      //             .iconTheme
                                      //             .color),
                                      //     border: OutlineInputBorder(
                                      //         borderSide: BorderSide.none,
                                      //         borderRadius: BorderRadius.all(
                                      //             Radius.circular(30))),
                                      //     fillColor: Theme.of(context)
                                      //         .inputDecorationTheme
                                      //         .fillColor,
                                      //     contentPadding: EdgeInsets.zero,
                                      //     hintText: 'Document Type',
                                      //   ),
                                      //   // ignore: avoid_print
                                      // ),




                                      Container(
                                        child: Form(
                                          key: _formKey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // name textfield
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 32.0),
                                                  child: TextFormField(
                                                    // controller: _nameController,
                                                    controller: TableName,
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            'Enter Document Type'),
                                                    validator: (v) {
                                                      if (v!.trim().isEmpty)
                                                        // ignore: curly_braces_in_flow_control_structures
                                                        return 'Please enter something';
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Add Documents',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 16),
                                                ),
                                                ..._getDocuments(TableName),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    azureStorage.createTable(TableName.text);
                                                    var len=Entity.length;
                                                    // Map<String,dynamic>mp={};
                                                    for(var i=0;i<len;i++)
                                                    {
                                                      Map<String, dynamic> dataMap={"name":Entity[i].toString()};
                                                      // ignore: non_constant_identifier_names
                                                      String? PartitionKey=Entity[i];
                                                      String? dcnum=(i+1).toString();
                                                      azureStorage.putTableRow(tableName: TableName.text,partitionKey:PartitionKey,rowKey: dcnum,bodyMap: dataMap);
                                                      // azureStorage.putTableRow(tableName: TableName.text,partitionKey:PartitionKey,rowKey: dcnum,bodyMap: dataMap);
                                                      print(Entity[i]);
                                                      // print(' ');
                                                    }
                                                    
                                                    // for(var i=0;i<len;i++)
                                                    // {
                                                    //   print('object');
                                                    //   Map<String, dynamic> dataMap={"name":Entity[i].toString()};
                                                    //   // ignore: non_constant_identifier_names
                                                    //   String? PartitionKey=Entity[i];
                                                    //   String? dcnum=(i+1).toString();
                                                    //   azureStorage.putTableRow(tableName: TableName.text,partitionKey:PartitionKey,rowKey: dcnum,bodyMap: dataMap);
                                                    //   // azureStorage.putTableRow(tableName: TableName.text,partitionKey:PartitionKey,rowKey: dcnum,bodyMap: dataMap);
                                                    //   print(Entity[i]);
                                                    //   // print(' ');
                                                    // }

                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                    }
                                                  },
                                                  child: Text('Save'),
                                                  color: Colors.green,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),



                                      
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                          // var _uniqueKey = UniqueKey();

                          // Map<String, dynamic> dataMap = {
                          //   "cardIndex": state.taskWidgets.length,
                          //   "isChecked": false,
                          //   "title": "something",
                          //   "a": "aadhar",
                          //   "b": "pancard",
                          // };

                          // context.read<CheckListScreenBloc>().add(
                          //       AzureTableCardAddition(
                          //         checkListCardMap: dataMap,
                          //       ),
                          //     );

                          // print(TableName.text);
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

 // get documents text-fields
  List<Widget> _getDocuments(TextEditingController _name){
    print(_name.text);
    azureStorage.createTable(_name.text);
    List<Widget> documentsTextFields = [];
    for(int i=0; i<documentList.length; i++){
      documentsTextFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            children: [
              Expanded(child: DocumentTextFields(i)),
              SizedBox(width: 16,),
              // we need add button at last friends row
              _addRemoveButton(i == documentList.length-1, i),
            ],
          ),
        )
      );
    }
    return documentsTextFields;
  }

  /// add / remove button
  Widget _addRemoveButton(bool add, int index){
    return InkWell(
      onTap: (){
        if(add){
          // add new text-fields at the top of all friends textfields
          documentList.insert(0, "");
        }
        else documentList.removeAt(index);
        setState((){});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon((add) ? Icons.add : Icons.remove, color: Colors.white,),
      ),
    );
  }


}

class DocumentTextFields extends StatefulWidget {
  final int index;
  DocumentTextFields(this.index);
  @override
  _DocumentTextFieldsState createState() => _DocumentTextFieldsState();
}

class _DocumentTextFieldsState extends State<DocumentTextFields> {
  late TextEditingController _nameController;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _nameController.text = _CheckListScreenState.documentList[widget.index];
    });

    return TextFormField(
      controller: _nameController,
      // controller: EntityName,
      onChanged: (v) => _CheckListScreenState.documentList[widget.index] = v,
      decoration: InputDecoration(
        hintText: 'Enter Document Name'
      ),
      validator: (v){
        if(v!.trim().isEmpty) return 'Please enter something';
        else{
          print(_nameController.text);
          // azureStorage.putTableRow(tableName: TableName.text,);
          Entity.add(_nameController.text);
        }
        return null;
      },
    );
    // ignore: dead_code
    
  }
}
