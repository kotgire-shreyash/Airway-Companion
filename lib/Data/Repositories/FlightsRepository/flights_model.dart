class FlightModel {
  String flightDate;
  String flightStatus;

  String airlineName;
  String flightNumber;
  String flightIATACode, flightICAOCode;

  String arrivalAirport, departureAirport;
  String arrivalTerminal, departureTerminal;
  String arrivalDelay, departureDelay;
  String arrivalSchedule, departureSchedule;
  String arrivalGate, departureGate;

  FlightModel({
    this.flightDate = "",
    this.flightStatus = "",
    this.airlineName = "",
    this.flightNumber = "",
    this.flightICAOCode = "",
    this.flightIATACode = "",
    this.arrivalAirport = "",
    this.departureAirport = "",
    this.arrivalTerminal = "",
    this.departureTerminal = "",
    this.arrivalDelay = "",
    this.departureDelay = "",
    this.arrivalSchedule = "",
    this.departureSchedule = "",
    this.arrivalGate = "",
    this.departureGate = "",
  });
}
