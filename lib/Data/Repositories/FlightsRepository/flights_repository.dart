import 'dart:convert';

import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_model.dart';

class FlightRepository {
  final FlightAPI _flightAPI = FlightAPI();
  List<FlightModel> flightList = [];

  Future getFlightList() async {
    var rawFlightData = await _flightAPI.getFlightDataEncoded();
    var jsonDecoded = await jsonDecode(rawFlightData.body);

    try {
      for (var item in jsonDecoded['data']) {
        FlightModel flightModel = FlightModel(
          flightDate: item['flight_date'],
          flightStatus: item['flight_status'],
          airlineName: item['airline']['name'],
          flightNumber: item['flight']['number'],
          flightICAOCode: item['flight']['icao'],
          flightIATACode: item['flight']['iata'],
          arrivalAirport: item['arrival']['airport'],
          departureAirport: item['departure']['airport'],
          arrivalTerminal: item['arrival']['terminal'],
          departureTerminal: item['departure']['terminal'],
          arrivalDelay: item['arrival']['delay'],
          departureDelay: item['departure']['delay'],
          arrivalSchedule: item['arrival']['schedule'],
          departureSchedule: item['departure']['schedule'],
          arrivalGate: item['arrival']['gate'],
          departureGate: item['departure']['gate'],
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
