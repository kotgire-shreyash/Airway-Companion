import 'package:airwaycompanion/Logic/Bloc/AuthenticationBloc/signup_bloc.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/LoginScreen/login_screen.dart';
import 'package:airwaycompanion/Modules/Authentication/Screens/SignUpScreen/signup_screen.dart';
import 'package:airwaycompanion/Modules/Checklist/Screens/checklist_screen.dart';
import 'package:airwaycompanion/Modules/Flight_Detail/Flight_details.dart';
import 'package:airwaycompanion/Modules/Flights/Screens/available_flights_screen.dart';
import 'package:airwaycompanion/Modules/Home/Screens/home_screen.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:airwaycompanion/Modules/Timeline/Screens/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalRouter {
  final FlightScreenBloc _flightScreenBloc = FlightScreenBloc();

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginPageView());
      case 'signup':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => SignupBloc(),
                  child: const SignUpPageView(),
                ));
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case 'checklist':
        return MaterialPageRoute(builder: (_) => const CheckListScreen());

      case 'checklistPage':
        return MaterialPageRoute(builder: (_) => const CheckListScreen());

      case 'availableFlights':
        return MaterialPageRoute(builder: (_) => const AvailableFlights());

      case 'timeline':
        return MaterialPageRoute(builder: (_) => const TimeLineScreen());

      default:
        //return MaterialPageRoute(builder: (_) => const LoginPageView());
        //  return MaterialPageRoute(builder: (_) => const LoginPageView());
        return MaterialPageRoute(builder: (_) => const NavigationScreen());
      // return MaterialPageRoute(builder: (_) => HomePage());
    }
  }
}
