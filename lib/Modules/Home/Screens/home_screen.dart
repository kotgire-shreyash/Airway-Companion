import 'dart:ui';

import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/HomeBloc/home_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Home/Events/home_screen_events.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen_states.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/drawer_widget.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/flights_check_button.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/search_delegate.dart';
import 'package:airwaycompanion/Modules/Routes/screen_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart'
    as bottomBar;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalRouter _homeScreenPageRouter = GlobalRouter();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _latoFontFamily = GoogleFonts.lato().fontFamily;
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;

  @override
  Widget build(BuildContext buildContext) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state.isSearchBoxTextFieldEnabled) {
          context.read<HomeScreenBloc>().add(
              SearchBoxTextFieldPressed(isSearchBoxTextFieldEnabled: false));
          showSearch(context: context, delegate: SearchBoxDelegate());
        } else if (state.isChecklistTilePressed) {
          context
              .read<HomeScreenBloc>()
              .add(CheckListTilePressed(isChecklistTilePressed: false));
          Navigator.pushNamed(context, "checklistPage");
        } else if (state.isNavigationTilePressed) {
          context
              .read<HomeScreenBloc>()
              .add(NavigationTilePressed(isNavigationTilePressed: false));
          Navigator.pushNamed(context, "navigationPage");
        } else if (state.isTimeLineButtonPressed) {
          context
              .read<HomeScreenBloc>()
              .add(TimeLineButtonPressed(isTimeLineButtonPressed: false));
          Navigator.pushNamed(context, "timeline");
        }
      },
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _home(context),
          onGenerateRoute: _homeScreenPageRouter.onGenerateRoute,
        );
      },
    );
  }

  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

  // Home Page Layout
  Widget _home(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const bottomBar.BottomNavigationBar(),
      endDrawer: _drawer(),
      body: SafeArea(
        child: SmartRefresher(
          controller: _refreshController,
          physics: const BouncingScrollPhysics(),
          cacheExtent: 50,
          header: WaterDropMaterialHeader(
            distance: 50,
            backgroundColor: Colors.grey.shade200,
            color: Colors.black87,
          ),
          onRefresh: _onRefresh,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30, left: 1),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          height: 50,
                          width: MediaQuery.of(context).size.width - 110,
                          // color: Colors.blue,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  "Hi ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 15,
                                      fontFamily: _latoBoldFontFamily,
                                      fontWeight: FontWeight.w700),
                                  textScaleFactor: 1.6,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  // context.read<LoginBloc>().state.username
                                  "Ninad07",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: _latoBoldFontFamily,
                                      fontWeight: FontWeight.w900),
                                  textScaleFactor: 1.6,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 10),
                            child: IconButton(
                              icon: Icon(
                                Icons.search,
                                size: 35,
                                color: context
                                        .read<HomeScreenBloc>()
                                        .state
                                        .isSearchIconPressed
                                    ? Colors.grey.shade600
                                    : Colors.black,
                              ),
                              onPressed: () {
                                context.read<HomeScreenBloc>().add(
                                    SearchIconPressed(
                                        isSearchIconPressed: context
                                                .read<HomeScreenBloc>()
                                                .state
                                                .isSearchIconPressed
                                            ? false
                                            : true));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:
                        context.read<HomeScreenBloc>().state.isSearchIconPressed
                            ? 15
                            : 0,
                  ),
                  context.read<HomeScreenBloc>().state.isSearchIconPressed
                      ? AnimationConfiguration.synchronized(
                          child: ScaleAnimation(child: _searchWidget()),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  _flightsCheckNotifier(),
                  const SizedBox(
                    height: 10,
                  ),
                  _timeLineNotifierCard(),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Services For You",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily:
                            GoogleFonts.lato(fontWeight: FontWeight.w400)
                                .fontFamily,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _servicesWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: const ChatBot(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      resizeToAvoidBottomInset: false,
    );
  }

  // Search Box
  Widget _searchWidget() {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.elliptical(30, 30)),
        border: Border.all(
          width: 0.8,
          color: Colors.grey.shade700,
        ),
      ),
      child: InkWell(
        child: Center(
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                "What are you searching for?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Airport Navigation?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Pre-Fly Guidelines?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
            ],
            repeatForever: true,
            pause: const Duration(seconds: 2),
            stopPauseOnTap: true,
            onTap: () {
              context.read<HomeScreenBloc>().add(
                  SearchBoxTextFieldPressed(isSearchBoxTextFieldEnabled: true));
            },
          ),
        ),

        // Second onTap necessary for when the space other than the animated text is tapped
        onTap: () {
          context.read<HomeScreenBloc>().add(
              SearchBoxTextFieldPressed(isSearchBoxTextFieldEnabled: true));
        },
      ),
    );
  }

  // Flight-Booking verification card
  Widget _flightsCheckNotifier() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade700,
              Colors.blue.shade500,
              Colors.blue.shade500,
              Colors.blue.shade700,
            ],
            stops: const [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 140,
              width: 220,
              child: SvgPicture.asset(
                "assets/images/airplane4.svg",
                fit: BoxFit.scaleDown,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                "Available Flights",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 35)
                      .fontFamily,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const FlightsCheckNotifierButton(),
          ],
        ),
      ),
    );
  }

  Widget _timeLineNotifierCard() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 10,
      color: Colors.yellow.shade600,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        // margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow.shade700,
              Colors.yellow.shade600,
              Colors.yellow.shade600,
              Colors.yellow.shade700,
            ],
            stops: const [
              0.1,
              0.4,
              0.6,
              0.9,
            ],
          ),
        ),
        child: Row(
          children: [
            Flexible(
              child: Container(
                margin: const EdgeInsets.all(5),
                height: 200,
                width: MediaQuery.of(context).size.width / 2.6,
                child: SvgPicture.asset(
                  "assets/images/timeline_2.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Flexible(
              child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width / 2.2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            "Track Your",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w500)
                                      .fontFamily,
                              fontSize: 20,
                            ),
                          )),
                        ),
                        Container(
                          child: Center(
                              child: Text(
                            "Journey",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 32,
                            ),
                          )),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                            height: 60,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<HomeScreenBloc>().add(
                                        TimeLineButtonPressed(
                                            isTimeLineButtonPressed: true),
                                      );
                                },
                                child: Text("Catch up!",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: GoogleFonts.lato(
                                              fontWeight: FontWeight.w900)
                                          .fontFamily,
                                    )),
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 5,
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer
  Widget _drawer() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                color: Colors.blue.shade500,
                height: 220,
                child: Column(
                  children: [
                    Container(
                      height: 130,
                      width: MediaQuery.of(context).size.width - 100,
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 23),
                      alignment: Alignment.centerRight,
                      // height: 35,
                      child: Text(
                        "Ninad07",
                        style: TextStyle(
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w900)
                                  .fontFamily,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 23),
                      alignment: Alignment.centerRight,
                      height: 25,
                      child: Text(
                        "demouser123@gmail.com",
                        style: TextStyle(
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w800)
                                  .fontFamily,
                          fontSize: 15,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _drawerListTile("Profile", CupertinoIcons.person, () => null),
              _drawerListTile("Check List", CupertinoIcons.checkmark_alt_circle,
                  () {
                context
                    .read<HomeScreenBloc>()
                    .add(CheckListTilePressed(isChecklistTilePressed: true));
              }),
              _drawerListTile("Navigation", FontAwesomeIcons.globe, () {
                // context
                //     .read<HomeScreenBloc>()
                //     .add(NavigationTilePressed(isNavigationTilePressed: true));
              }),
              _drawerListTile("Settings", CupertinoIcons.settings, () {
                Navigator.pushNamed(context, "timeline");
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Drawer Tile
  Widget _drawerListTile(String title, IconData icon, Function() onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: GoogleFonts.lato(fontWeight: FontWeight.w800).fontFamily,
          fontSize: 15,
        ),
      ),
      onTap: onTap,
    );
  }

  // Services Widget
  Widget _servicesWidget() {
    return Center(
        child: Column(
      children: [
        _serviceRowLayout(
          _serviceCard(
              Colors.deepPurpleAccent.shade400, Colors.yellow.shade600),
          _serviceCard(Colors.yellow.shade600, Colors.yellow.shade600),
        ),
        const SizedBox(height: 15),
        _serviceRowLayout(
          _serviceCard(Colors.yellow.shade600, Colors.yellow.shade600),
          _serviceCard(Colors.yellow.shade600, Colors.yellow.shade600),
        ),
        const SizedBox(height: 15),
        Center(
            child: _serviceCard(
                Colors.deepPurpleAccent.shade400, Colors.yellow.shade600)),
        const SizedBox(height: 15),
      ],
    ));
  }

  // Services Layout
  Widget _serviceRowLayout(Widget serviceCard1, Widget serviceCard2) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          serviceCard1,
          const SizedBox(width: 15),
          serviceCard2,
        ],
      ),
    );
  }

  // Service card
  Widget _serviceCard(Color color1, Color color2) {
    return Card(
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 2.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
