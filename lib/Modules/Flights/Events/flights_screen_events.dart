abstract class FlightScreenEvent {}

class FlightAPICalled extends FlightScreenEvent {
  bool isFlightAPICalled;
  FlightAPICalled({this.isFlightAPICalled = false});
}
