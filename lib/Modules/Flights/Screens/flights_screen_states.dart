class FlightScreenState {
  // var flightsList;
  bool isFlightAPICalled;
  bool isFlightAPIDataLoading;
  var flightsRepo;

  FlightScreenState({
    this.isFlightAPICalled = false,
    this.isFlightAPIDataLoading = false,
    // this.flightsList,
    this.flightsRepo,
  });

  FlightScreenState copyWith(
      {var isFlightAPICalled, var isFlightAPIDataLoading, var flightsRepo}) {
    return FlightScreenState(
      isFlightAPICalled: isFlightAPICalled ?? this.isFlightAPICalled,
      isFlightAPIDataLoading:
          isFlightAPIDataLoading ?? this.isFlightAPIDataLoading,
      flightsRepo: flightsRepo ?? this.flightsRepo,
    );
  }
}
