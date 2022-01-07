import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_screen.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSplashScreen(
        splash: const Splash(),
        splashIconSize: double.infinity,
        nextScreen: const LoginPageView(),
        splashTransition: SplashTransition.fadeTransition,
        animationDuration: const Duration(seconds: 1),
        duration: 5000,
        pageTransitionType: PageTransitionType.rightToLeftWithFade,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: AnimationConfiguration.synchronized(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.8,
            ),
            FadeInAnimation(
              curve: Curves.easeOut,
              duration: const Duration(seconds: 2),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  "assets/images/logo.jpg",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SlideAnimation(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 1),
              child: SizedBox(
                child: Center(
                  child: Text(
                    "Airway",
                    style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 40,
                      letterSpacing: 7,
                      fontWeight: FontWeight.w900,
                      fontFamily: GoogleFonts.lato(fontWeight: FontWeight.bold)
                          .fontFamily,
                    ),
                    textScaleFactor: 1.2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            SlideAnimation(
              curve: Curves.easeInOut,
              duration: const Duration(seconds: 2),
              child: SizedBox(
                child: Center(
                  child: Text(
                    "Companion",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      letterSpacing: 7,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.lato().fontFamily,
                    ),
                    textScaleFactor: 1.0,
                  ),
                ),
              ),
            ),
            FadeInAnimation(
              curve: Curves.easeInExpo,
              duration: const Duration(seconds: 4),
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20, top: 180),
                child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
