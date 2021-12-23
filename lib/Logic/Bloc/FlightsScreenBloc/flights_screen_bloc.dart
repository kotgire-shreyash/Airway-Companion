import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_repository.dart';
import 'package:airwaycompanion/Modules/Flights/Events/flights_screen_events.dart';
import 'package:airwaycompanion/Modules/Flights/Screens/flights_screen_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightScreenBloc extends Bloc<FlightScreenEvent, FlightScreenState> {
  final FlightRepository _flightDataRepo = FlightRepository();
  FlightScreenBloc() : super(FlightScreenState()) {
    on<FlightAPICalled>(_onFlightAPICalledEvent);
  }

  void _onFlightAPICalledEvent(
      FlightAPICalled event, Emitter<FlightScreenState> emit) async {
    emit(state.copyWith(
        isFlightAPIDataLoading: true, flightsRepo: FlightRepository()));
    await state.flightsRepo.getFlightList();
    emit(state.copyWith(
        isFlightAPICalled: event.isFlightAPICalled,
        isFlightAPIDataLoading: false));
  }
}
