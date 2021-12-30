import 'package:airwaycompanion/Data/Repositories/AzureBotRepository/azure_bot_repository.dart';
import 'package:airwaycompanion/Logic/Bloc/AzureBotBloc/azure_bot_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Events/chatbot_events.dart';
import 'package:airwaycompanion/Modules/ChatBot/States/chatbot_state.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Azure Bot
class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final List<Widget> queryList = [];
  final ScrollController _scrollController = ScrollController();
  String question = "";

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.redAccent.shade200,
          shape: BoxShape.circle,
        ),
        child: CustomPopupMenu(
          verticalMargin: 0,
          arrowColor: Colors.redAccent.shade200,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.redAccent.shade200, shape: BoxShape.circle),
            child: Center(
              child: SizedBox(
                height: 45,
                width: 45,
                child: SvgPicture.asset(
                  "assets/images/chatbot_4.svg",
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          menuBuilder: () {
            return _botInterface();
          },
          pressType: PressType.singleClick,
        ),
      ),
    );
  }

  Widget _botInterface() {
    return BlocBuilder<AzureBotBloc, AzureBotState>(builder: (context, state) {
      return Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        elevation: 5,
        child: Container(
          height: 520,
          width: 320,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      height: 80,
                      width: 100,
                      // color: Colors.yellow,
                      child: SvgPicture.asset(
                        "assets/images/chatbot_4.svg",
                        fit: BoxFit.contain,
                        color: Colors.redAccent,
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Center(
                        child: Text(
                          "Bot ",
                          style: TextStyle(
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w900)
                                    .fontFamily,
                            color: Colors.grey.shade400,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                      child: Center(
                        child: Text(
                          "Assistant",
                          style: TextStyle(
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w900)
                                    .fontFamily,
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  // color: Colors.blue,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Hi Ninad07, I am your personal digital assistant for your journey\n How can I help you?",
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 60),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder<String>(
                  builder: (context, question) {
                    String message = state.azureBotQueryResponse;

                    if (message != "") {
                      try {
                        context.read<AzureBotBloc>().add(AddResponse(
                                responseWidget: Container(
                              constraints: const BoxConstraints(
                                minHeight: 60,
                                minWidth: 180,
                                maxWidth: 220,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight: Radius.circular(18),
                                      bottomRight: Radius.circular(18),
                                      bottomLeft: Radius.circular(4))),
                              margin: const EdgeInsets.only(
                                  right: 120, left: 10, bottom: 10),
                              alignment: Alignment.center,
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                child: state.azureBotQueryStatus
                                    ? LoadingAnimationWidget.staggeredDotWave(
                                        color: Colors.black, size: 35)
                                    : Text(
                                        message,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ),
                            )));
                      } catch (e) {
                        rethrow;
                      }
                    }

                    context.read<AzureBotBloc>().add(ClearAzureQueryResponse());
                    return Container(
                      width: 300,
                      height: 290,
                      color: Colors.white,
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: _scrollController,
                          child: Column(
                            children: state.queryList,
                          )),
                    );
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                _messageBox(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _messageBox() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 300,
      height: 50,
      margin: const EdgeInsets.only(left: 4, top: 5, bottom: 5),
      decoration: const BoxDecoration(
          // color: Colors.red,
          ),
      child: Row(
        children: [
          Container(
            width: 230,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(35)),
            alignment: Alignment.centerLeft,
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Colors.grey.shade800, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Send a query...',
                hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                    fontFamily: GoogleFonts.lato().fontFamily),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 2.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 1.5)),
              ),
              onChanged: (value) {
                question = value;
              },
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () async {
                print(question);
                if (question != "") {
                  context.read<AzureBotBloc>().add(AddResponse(
                          responseWidget: Container(
                        constraints: const BoxConstraints(
                          minHeight: 60,
                          minWidth: 180,
                          maxWidth: 220,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.redAccent.shade200,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(4))),
                        margin: const EdgeInsets.only(
                            left: 120, right: 10, bottom: 10),
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Text(
                            question,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: GoogleFonts.lato().fontFamily,
                            ),
                          ),
                        ),
                      )));

                  context.read<AzureBotBloc>().add(
                        MessageQueryRequestToAzure(question: question),
                      );

                  question = "";
                  await _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                }
              },
              child: const Center(
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              style: TextButton.styleFrom(
                minimumSize: const Size(50, 50),
                backgroundColor: Colors.redAccent,
                shape: const CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
