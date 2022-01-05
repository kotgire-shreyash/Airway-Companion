// ignore_for_file: prefer_const_constructors

import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/Timeline/widgets/timeline_card.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:airwaycompanion/Modules/Timeline/widgets/structure_class.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeLineScreen extends StatefulWidget {
  const TimeLineScreen(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final bottomBar;
  @override
  _TimeLineScreenState createState() => _TimeLineScreenState();
}

class _TimeLineScreenState extends State<TimeLineScreen> {
  @override
  void initState() {
    CustomBottomNavigationBar.index = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: widget.chatbot,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: widget.bottomBar,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 300,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              margin: const EdgeInsets.only(top: 80, left: 50, right: 50),
              color: Colors.white,
              height: 350,
              width: 200,
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/timeline_illustration.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(
                height: 110,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Track your journey with us!",
                        textStyle: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 25,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w900)
                                    .fontFamily,
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
              flex: 10,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: stepObjects.length,
                  itemBuilder: (context, index) {
                    final stepObject = stepObjects[index];
                    return Center(
                      child: SizedBox(
                        width: 360.0,
                        child: Card(
                          margin: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child:
                                    TimeLineCardHeader(stepObject: stepObject),
                              ),
                              const Divider(height: 1.0),
                              TimeLineCardBody(stages: stepObject.stages),
                              const Divider(height: 1.0),
                              const Padding(
                                padding: EdgeInsets.all(20.0),
                                child: TimeLineCardFooter(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final stepObjects = <StepInfo>[
  StepInfo(
    name: 'CHECK IN',
    date: DateTime.now(),
    stages: [
      Stage(
        title: 'Check IN',
        subStages: [
          SubStage('8:15am', 'Traveler arrived for check In'),
          SubStage('8:25am', 'Verification of E ticket'),
          SubStage('8:30am', 'Vaccination and RTPCR report'),
          SubStage('8:35am', 'Checked In Successfully'),
          SubStage('8:40am', 'Issue of Boarding Pass'),
        ],
      ),
      Stage(),
    ],
  )
];
