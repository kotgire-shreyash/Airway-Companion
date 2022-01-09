import 'dart:convert';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_model.dart';

// Flight Screen Repository
class FlightRepository {
  final FlightAPI _flightAPI = FlightAPI();
  List<FlightModel> flightList = [];

  // Receives flight data from the API
  Future getFlightList() async {
    var rawFlightData = await _flightAPI.getFlightDataEncoded();
    var flightDataJsonDecoded = await jsonDecode(rawFlightData.body);

    try {
      for (var item in flightDataJsonDecoded['data']) {
        FlightModel flightModel = FlightModel(
          flightDate: item['flight_date'] ?? "Null",
          flightStatus: item['flight_status'] ?? "Null",
          flightIATA: item['flight']['iata'] ?? "Null",
          airlineName: item['airline']['name'] ?? "Null",
          flightNumber: item['flight']['number'] ?? "Null",
          arrivalICAOCode: item['arrival']['icao'] ?? "Null",
          arrivalIATACode: item['arrival']['iata'] ?? "Null",
          departureIATACode: item['departure']['iata'] ?? "Null",
          departureICAOCode: item['departure']['icao'] ?? "Null",
          arrivalAirport: item['arrival']['airport'] ?? "Null",
          departureAirport: item['departure']['airport'] ?? "Null",
          arrivalTerminal: item['arrival']['terminal'] ?? "Null",
          departureTerminal: item['departure']['terminal'] ?? "Null",
          arrivalDelay: item['arrival']['delay'] ?? 0,
          departureDelay: item['departure']['delay'] ?? 0,
          arrivalSchedule: item['arrival']['scheduled'] ?? "Null",
          departureSchedule: item['departure']['scheduled'] ?? "Null",
          arrivalGate: item['arrival']['gate'] ?? "Null",
          departureGate: item['departure']['gate'] ?? "Null",
        );

        flightList.add(flightModel);
      }
    } catch (e) {
      rethrow;
    }
  }

  FlightModel getFlightDataModel(int index) {
    return flightList[index];
  }
}
