import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
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
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      elevation: 5,
      child: Container(
        height: 450,
        width: 280,
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
              const SizedBox(
                height: 5,
              ),
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
              const SizedBox(
                height: 1,
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 80,
                  // color: Colors.blue,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Hi Ninad07, I am your personal digital assistant for your journey\n How can I help you?",
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontFamily: GoogleFonts.lato().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 60),
                      ),
                    ],
                    repeatForever: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
