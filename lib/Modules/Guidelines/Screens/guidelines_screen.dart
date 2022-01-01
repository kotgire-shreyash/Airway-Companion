import 'package:airwaycompanion/Data/Repositories/AzureTranslatorRepository/azure_translator_repository.dart';
import 'package:airwaycompanion/Logic/Bloc/GuidelineScreenBloc/guideline_screen_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/Guidelines/Events/guideline_events.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'guideline_states.dart';

class GuidelineScreen extends StatefulWidget {
  const GuidelineScreen(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final CustomBottomNavigationBar bottomBar;

  @override
  _GuidelineScreenState createState() => _GuidelineScreenState();
}

class _GuidelineScreenState extends State<GuidelineScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuidelineScreenBloc, GuidelineScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: widget.chatbot,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: widget.bottomBar,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              actions: [
                IconButton(
                  onPressed: () async {
                    // Translate the entire guidelines
                    context.read<GuidelineScreenBloc>().add(TranslateEvent(
                          to: "it",
                          content: state.guidelineCardList,
                        ));
                  },
                  icon: Icon(Icons.translate, color: Colors.black),
                ),
              ],
            ),
            body: ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.black,
                useInkWell: true,
              ),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.guidelineCardList.length,
                itemBuilder: (context, int index) {
                  return GuideCard(
                    imageData: state.guidelineCardList[index]['image'],
                    title: state.guidelineCardList[index]['title'],
                    collapsedBody: state.guidelineCardList[index]
                        ['collapsedBody'],
                    body: state.guidelineCardList[index]['body'],
                  );
                },
              ),
            ),
          );
        });
  }
}

Widget _constantLoadingAnimation() {
  return LoadingAnimationWidget.staggeredDotWave(color: Colors.black, size: 25);
}

class GuideCard extends StatelessWidget {
  GuideCard(
      {required this.imageData,
      required this.title,
      required this.collapsedBody,
      required this.body});
  final imageData;
  final title;
  final body, collapsedBody;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: AssetImage("assets/images/$imageData"),
                ),
              ),
            ),
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      context
                              .read<GuidelineScreenBloc>()
                              .state
                              .isBeingTranslated
                          ? ""
                          : title,
                      style: TextStyle(
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.bold)
                                  .fontFamily),
                    )),
                collapsed:
                    context.read<GuidelineScreenBloc>().state.isBeingTranslated
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: _constantLoadingAnimation())
                        : Text(
                            collapsedBody,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                expanded:
                    context.read<GuidelineScreenBloc>().state.isBeingTranslated
                        ? SizedBox(
                            height: 200,
                            child: Center(child: _constantLoadingAnimation()))
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              body,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
