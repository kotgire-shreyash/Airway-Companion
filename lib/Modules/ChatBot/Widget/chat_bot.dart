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
              const SizedBox(
                height: 10,
              ),
              Flexible(
                flex: 4,
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 500,
                    color: Colors.grey.shade200,
                  ),
                ),
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
  }

  Widget _messageBox() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: 280,
      height: 50,
      margin: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
      decoration: const BoxDecoration(
          // color: Colors.red,
          ),
      child: Row(
        children: [
          Container(
            width: 210,
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(35)),
            alignment: Alignment.centerLeft,
            child: TextField(
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Colors.grey.shade800, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Send a query...',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide:
                        BorderSide(color: Colors.grey.shade200, width: 2.5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide:
                        BorderSide(color: Colors.grey.shade100, width: 1.5)),
              ),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            width: 0,
          ),
          Flexible(
            child: ElevatedButton(
              onPressed: () {},
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

/*
    Container(
      color: Colors.white,
      // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height - 165),
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15, left: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(35)),
              alignment: Alignment.centerLeft,
              // width: deviceWidth * 0.75,
              // height: 55,
              child: TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(
                    color: Colors.grey.shade800, fontWeight: FontWeight.bold),
                // controller: msgtextcontroller,
                decoration: InputDecoration(
                  hintText: 'Send a message...',
                  hintStyle:
                      TextStyle(color: Colors.grey.shade400, fontSize: 14),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide:
                          BorderSide(color: Colors.grey.shade200, width: 2.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide:
                          BorderSide(color: Colors.grey.shade100, width: 1.5)),
                ),
                onChanged: (value) {},
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              margin: EdgeInsets.only(right: 10, left: 2, bottom: 20),
              child: FloatingActionButton(
                elevation: 2,
                //hoverColor: color[shade],
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(left: 5, top: 0),
                    decoration: BoxDecoration(
                        color: Colors.blue, shape: BoxShape.circle),
                    child: const Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                onPressed: () async {},
                // backgroundColor: color[shade],
              ),
            )
          ],
        ),
      ),
    );*/
  }
}
