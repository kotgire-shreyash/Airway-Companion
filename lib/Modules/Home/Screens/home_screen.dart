import 'dart:ui';

import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/HomeBloc/home_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Home/Events/home_screen_events.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen_states.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/flights_check_button.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/search_delegate.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/services_widget.dart';
import 'package:airwaycompanion/Modules/Profile/Screens/profile_screen.dart';
import 'package:airwaycompanion/Modules/Routes/screen_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final bottomBar;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalRouter _homeScreenPageRouter = GlobalRouter();

  @override
  Widget build(BuildContext buildContext) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ShowCaseWidget(
          builder: Builder(
              builder: (context) => HomeScreenBody(
                  chatbot: widget.chatbot, bottomBar: widget.bottomBar)),
        ),
        onGenerateRoute: _homeScreenPageRouter.onGenerateRoute,
      ),
    );
  }

  // System Back Navigation Method
  Future<bool> _onbackpressed() async {
    bool _toBeExitted = false;
    await showAnimatedDialog(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 500),
        barrierDismissible: true,
        animationType: DialogTransitionType.scale,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Text(
              'Are you sure ?',
              style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),
            ),
            content: Text(
              'You will be exiting the app',
              style: TextStyle(fontFamily: GoogleFonts.lato().fontFamily),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _toBeExitted = true;
                    SystemNavigator.pop();
                  },
                  child: const Text('Yes')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('No')),
            ],
          );
        });

    return _toBeExitted;
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final CustomBottomNavigationBar bottomBar;

  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final _latoFontFamily = GoogleFonts.lato().fontFamily;
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;

  final GlobalKey _searchKey = GlobalKey();
  final GlobalKey _flightsKey = GlobalKey();
  final GlobalKey _trackKey = GlobalKey();
  final GlobalKey _botKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
      if (state.isSearchBoxTextFieldEnabled) {
        context
            .read<HomeScreenBloc>()
            .add(SearchBoxTextFieldPressed(isSearchBoxTextFieldEnabled: false));
        showSearch(context: context, delegate: SearchBoxDelegate());
      }
    }, builder: (context, state) {
      return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: widget.bottomBar,
        endDrawer: _drawer(),
        floatingActionButton: Showcase(
            key: _botKey,
            description: "Tap to chat with your digital assistant!",
            descTextStyle: TextStyle(
                fontFamily:
                    GoogleFonts.lato(fontWeight: FontWeight.w800).fontFamily),
            child: widget.chatbot),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        resizeToAvoidBottomInset: false,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // IconButton(
                          //     onPressed: () {
                          //       _scaffoldKey.currentState!.openEndDrawer();
                          //     },
                          //     icon:
                          //         const Icon(Icons.menu, color: Colors.black)),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 150,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Text(
                                  "Hi ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.lato(
                                            fontWeight: FontWeight.bold)
                                        .fontFamily,
                                  ),
                                  textScaleFactor: 1.6,
                                ),
                                Text(
                                  context.read<LoginBloc>().state.username +
                                      "!",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800)
                                        .fontFamily,
                                  ),
                                  textScaleFactor: 1.6,
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              height: 50,
                              color: Colors.white,
                              alignment: Alignment.centerRight,
                              child: Center(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.info_outline,
                                    size: 28,
                                    color: Colors.grey.shade800,
                                  ),
                                  onPressed: () {
                                    ShowCaseWidget.of(context)!.startShowCase([
                                      _searchKey,
                                      _flightsKey,
                                      _trackKey,
                                      _botKey,
                                    ]);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.white,
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(
                              right: 25,
                            ),
                            child: Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.menu,
                                  size: 30,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Showcase(
                        key: _searchKey,
                        description: "Tap to search for the required widget",
                        child: Center(child: _searchWidget())),
                    const SizedBox(
                      height: 30,
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
                              GoogleFonts.lato(fontWeight: FontWeight.w500)
                                  .fontFamily,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ServicesWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                    _logo(200, MediaQuery.of(context).size.width - 200, 30, 23,
                        100, 100),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Screen Refresh Action
  void _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    _refreshController.refreshCompleted();
  }

  // Search Box for searching and navigating features in the app
  Widget _searchWidget() {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width - 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.elliptical(20, 20)),
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
                  fontSize: 13,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Airport Navigation?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Pre-Fly Guidelines?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Flight Booking?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                  fontFamily: _latoFontFamily,
                  fontWeight: FontWeight.bold,
                ),
                speed: const Duration(milliseconds: 60),
              ),
              TypewriterAnimatedText(
                "Personal Assistance?",
                textStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
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

// Drawer
  Widget _drawer() {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 100,
        child: Drawer(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width - 100,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
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
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/user.jpg",
                                  fit: BoxFit.cover,
                                  height: 70,
                                  width: 70,
                                )),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 23),
                              alignment: Alignment.centerRight,
                              // height: 35,
                              child: Text(
                                context.read<LoginBloc>().state.username,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.w900)
                                      .fontFamily,
                                  fontSize: 25,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 23),
                              alignment: Alignment.centerRight,
                              height: 25,
                              child: Text(
                                context.read<LoginBloc>().state.mail,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.w800)
                                      .fontFamily,
                                  fontSize: 15,
                                  color: Colors.grey.shade200,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _drawerListTile("Profile", CupertinoIcons.person, () {
                        Navigator.pushNamed(context, 'profile');
                      }),
                      _drawerListTile(
                          "Check List", CupertinoIcons.checkmark_alt_circle,
                          () {
                        Navigator.pushNamed(context, "checklistPage");
                      }),
                      _drawerListTile("Navigation", CupertinoIcons.map, () {
                        Navigator.pushNamed(context, "navigation");
                      }),
                      _drawerListTile("Track", Icons.track_changes_sharp, () {
                        Navigator.pushNamed(context, "timeline");
                      }),
                      _drawerListTile("Guidelines", CupertinoIcons.book, () {
                        Navigator.pushNamed(context, "guidelines");
                      }),
                    ],
                  ),
                ),
                _logo(150, 100, 25, 18, 80, 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // App logo Showcase
  Widget _logo(double height, double width, double fontSize1, double fontSize2,
      double imageHeight, double imageWidth) {
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: height,
            width: width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Airway",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: fontSize1,
                      fontFamily: GoogleFonts.lato(fontWeight: FontWeight.bold)
                          .fontFamily,
                    ),
                  ),
                  Text(
                    "Companion",
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: fontSize2,
                      fontFamily: GoogleFonts.lato(fontWeight: FontWeight.bold)
                          .fontFamily,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
              height: imageHeight,
              width: imageWidth,
              child: Image.asset("assets/images/logo.jpg"))
        ],
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

  // Flight-Booking verification card
  Widget _flightsCheckNotifier() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 250,
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
              height: 120,
              width: 200,
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
                  fontSize: 21,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Showcase(
                key: _flightsKey,
                description: "Tap to view and book available flights!",
                descTextStyle: TextStyle(
                    fontFamily: GoogleFonts.lato(fontWeight: FontWeight.w800)
                        .fontFamily),
                child: const FlightsCheckNotifierButton()),
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
        height: 160,
        width: MediaQuery.of(context).size.width,
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
                height: 140,
                width: MediaQuery.of(context).size.width / 2.6,
                child: SvgPicture.asset(
                  "assets/images/timeline_2.svg",
                  color: Colors.white,
                  fit: BoxFit.contain,
                  height: 140,
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
                              fontSize: 16,
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
                              fontSize: 24,
                            ),
                          )),
                        ),
                        SizedBox(
                            height: 60,
                            child: Center(
                              child: Showcase(
                                key: _trackKey,
                                description:
                                    "Tap to track progress on your next flight!",
                                descTextStyle: TextStyle(
                                    fontFamily: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800)
                                        .fontFamily),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "timeline");
                                  },
                                  child: Text("Catch up!",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: GoogleFonts.lato(
                                                fontWeight: FontWeight.w900)
                                            .fontFamily,
                                        fontSize: 13,
                                      )),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 5,
                                  ),
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
}
