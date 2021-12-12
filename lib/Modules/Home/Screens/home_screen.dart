import 'package:airwaycompanion/Logic/Bloc/HomeBloc/home_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Home/Events/home_screen_events.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen_states.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/booking_verification_button.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/chat_bot.dart';
import 'package:airwaycompanion/Modules/Routes/screen_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:airwaycompanion/Modules/Home/Widgets/bottom_navigation_bar.dart'
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
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state.isSearchBoxTextFieldEnabled && !state.isSearchIconPressed) {
          context.read<HomeScreenBloc>().add(
              SearchBoxTextFieldPressed(isSearchBoxTextFieldEnabled: false));
        }
      },
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _home(),
          onGenerateRoute: _homeScreenPageRouter.onGenerateRoute,
        );
      },
    );
  }

  // Home Page Layout
  Widget _home() {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomBar.bottomNavigationBar(),
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
          // onRefresh: _onRefresh,
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
                  _flightBookingVerificationCard(),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ChatBot(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Search Box
  Widget _searchWidget() {
    return context.read<HomeScreenBloc>().state.isSearchBoxTextFieldEnabled
        ? Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.elliptical(30, 30)),
              border: Border.all(
                width: 0.8,
                color: Colors.grey.shade700,
              ),
            ),
            child: TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              autocorrect: false,
              decoration: InputDecoration(
                hintText: "Explore",
                hintStyle: TextStyle(
                    color: Colors.grey.shade300, fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.only(
                  top: 1,
                  bottom: 1,
                  left: 20,
                  right: 20,
                ),

                // icon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                    width: 3,
                  ),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(30, 30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade800,
                    width: 1.6,
                  ),
                  borderRadius:
                      const BorderRadius.all(Radius.elliptical(30, 30)),
                ),
                fillColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
              ),
              cursorColor: Colors.grey.shade600,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.visible,
                color: Colors.grey.shade900,
              ),
            ))
        :
        // Animated Search Text Guide
        Container(
            height: 50,
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
                        SearchBoxTextFieldPressed(
                            isSearchBoxTextFieldEnabled: true));
                  },
                ),
              ),

              // Second onTap necessary for when the space other than the animated text is tapped
              onTap: () {
                context.read<HomeScreenBloc>().add(SearchBoxTextFieldPressed(
                    isSearchBoxTextFieldEnabled: true));
              },
            ),
          );
  }

  // Flight-Booking verification card
  Widget _flightBookingVerificationCard() {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        height: 280,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white, //Colors.blue.shade700,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 140,
              width: 250,
              // color: Colors.blue,
              child: SvgPicture.asset(
                "assets/images/flight_booking_grey.svg",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              child: Text(
                "Booking Verification",
                style: TextStyle(
                  color: Colors.black,
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
            const VerificationButton(),
          ],
        ),
      ),
    );
  }
}
