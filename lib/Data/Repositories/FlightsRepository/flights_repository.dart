import 'dart:collection';
import 'dart:convert';

import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_model.dart';

class FlightRepository {
  final FlightAPI _flightAPI = FlightAPI();
  List<FlightModel> flightList = [];

  Future getFlightList() async {
    var rawFlightData = await _flightAPI.getFlightDataEncoded();
    var flightDataJsonDecoded = await jsonDecode(rawFlightData.body);

    print("Here");
    print(flightDataJsonDecoded);
    try {
      for (var item in flightDataJsonDecoded['data']) {
        FlightModel flightModel = FlightModel(
          flightDate: item['flight_date'] ?? "Null",
          flightStatus: item['flight_status'] ?? "Null",
          airlineName: item['airline']['name'] ?? "Null",
          flightNumber: item['flight']['number'] ?? "Null",
          flightICAOCode: item['flight']['icao'] ?? "Null",
          flightIATACode: item['flight']['iata'] ?? "Null",
          arrivalAirport: item['arrival']['airport'] ?? "Null",
          departureAirport: item['departure']['airport'] ?? "Null",
          arrivalTerminal: item['arrival']['terminal'] ?? "Null",
          departureTerminal: item['departure']['terminal'] ?? "Null",
          arrivalDelay: item['arrival']['delay'].toString(),
          departureDelay: item['departure']['delay'].toString(),
          arrivalSchedule: item['arrival']['schedule'] ?? "Null",
          departureSchedule: item['departure']['schedule'] ?? "Null",
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
