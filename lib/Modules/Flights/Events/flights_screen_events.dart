abstract class FlightScreenEvent {}

class FlightAPICalled extends FlightScreenEvent {
  bool isFlightAPICalled;
  FlightAPICalled({this.isFlightAPICalled = false});
}

class FlightTicketBooking extends FlightScreenEvent {
  Map<String, dynamic> dataMap;
  FlightTicketBooking({required this.dataMap});
}
