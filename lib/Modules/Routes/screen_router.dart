import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/BookingScreenBloc/bookings_screen_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/GuidelineScreenBloc/guideline_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_screen.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_screen.dart';
import 'package:airwaycompanion/Modules/Bookings/Screens/bookings_screen.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen.dart';
import 'package:airwaycompanion/Modules/Flights/Screens/available_flights_screen.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/Guidelines/Screens/guidelines_screen.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:airwaycompanion/Modules/Splash/splash_screen.dart';
import 'package:airwaycompanion/Modules/Profile/Screens/profile_screen.dart';
import 'package:airwaycompanion/Modules/Timeline/Screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalRouter {
  final ChatBot _chatBot = const ChatBot();
  final CustomBottomNavigationBar _bottomBar =
      const CustomBottomNavigationBar();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case 'login':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginBloc(),
                  child: const LoginPageView(),
                ));
      case 'signup':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignupBloc(),
                  child: const SignUpPageView(),
                ));
      case 'home':
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(chatbot: _chatBot, bottomBar: _bottomBar));

      case 'checklistPage':
        return MaterialPageRoute(
            builder: (_) =>
                CheckListScreen(chatbot: _chatBot, bottomBar: _bottomBar));

      case 'availableFlights':
        return MaterialPageRoute(
            builder: (_) =>
                AvailableFlights(chatbot: _chatBot, bottomBar: _bottomBar));

      case 'bookings':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => BookingScreenBloc(),
                child:
                    BookingScreen(chatbot: _chatBot, bottomBar: _bottomBar)));

      case 'timeline':
        return MaterialPageRoute(
            builder: (_) =>
                TimeLineScreen(chatbot: _chatBot, bottomBar: _bottomBar));

      case 'navigation':
        return MaterialPageRoute(
            builder: (_) => NavigationScreen(
                  bottomBar: _bottomBar,
                ));
      case 'profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case 'guidelines':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => GuidelineScreenBloc(),
            child: GuidelineScreen(chatbot: _chatBot, bottomBar: _bottomBar),
          ),
        );

      case 'splash':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      default:
        //return MaterialPageRoute(builder: (_) => const LoginPageView());
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(chatbot: _chatBot, bottomBar: _bottomBar));
    }
  }
}
