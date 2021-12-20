import 'package:airwaycompanion/Modules/Flights/Events/flights_screen_events.dart';
import 'package:airwaycompanion/Modules/Flights/Screens/flights_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightScreenBloc extends Bloc<FlightScreenEvent, FlightScreenState> {
  FlightScreenBloc() : super(FlightScreenState()) {}
}
