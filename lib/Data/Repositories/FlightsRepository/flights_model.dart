// Flights Data Model
class FlightModel {
  String flightDate;
  String flightStatus;
  String flightIATA;

  String airlineName;
  String flightNumber;
  String arrivalIATACode, arrivalICAOCode;
  String departureIATACode, departureICAOCode;

  String arrivalAirport, departureAirport;
  String arrivalTerminal, departureTerminal;
  int arrivalDelay, departureDelay;
  String arrivalSchedule, departureSchedule;
  String arrivalGate, departureGate;

  FlightModel({
    this.flightDate = "",
    this.flightStatus = "",
    this.flightIATA = "",
    this.airlineName = "",
    this.flightNumber = "",
    this.arrivalICAOCode = "",
    this.arrivalIATACode = "",
    this.departureICAOCode = "",
    this.departureIATACode = "",
    this.arrivalAirport = "",
    this.departureAirport = "",
    this.arrivalTerminal = "",
    this.departureTerminal = "",
    this.arrivalDelay = 0,
    this.departureDelay = 0,
    this.arrivalSchedule = "",
    this.departureSchedule = "",
    this.arrivalGate = "",
    this.departureGate = "",
  });
}
