import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/login_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_screen.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_screen.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen.dart';
import 'package:airwaycompanion/Modules/Flight_Detail/Flight_details.dart';
import 'package:airwaycompanion/Modules/Flights/Screens/available_flights_screen.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:airwaycompanion/Modules/Timeline/Screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalRouter {
  final ChatBot _chatBot = const ChatBot();

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
        return MaterialPageRoute(builder: (_) => HomeScreen(chatbot: _chatBot));

      case 'checklistPage':
        return MaterialPageRoute(
            builder: (_) => CheckListScreen(chatbot: _chatBot));

      case 'availableFlights':
        return MaterialPageRoute(
            builder: (_) => AvailableFlights(chatbot: _chatBot));

      case 'timeline':
        return MaterialPageRoute(
            builder: (_) => TimeLineScreen(chatbot: _chatBot));

      // case 'navigationPage':
      //   return MaterialPageRoute(builder: (_) => MapNavigation());

      default:
        //return MaterialPageRoute(builder: (_) => const LoginPageView());
        return MaterialPageRoute(builder: (_) => const LoginPageView());
    }
  }
}
