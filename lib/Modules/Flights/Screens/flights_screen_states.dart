import 'package:azstore/azstore.dart';

class FlightScreenState {
  final azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=acflightbookingservice;AccountKey=Vw3i+ZWx+bIdxKOK7dBm6FMrxZ/YiCsAjFydC/5gwkhwnZM7VzffXPbG+TKyM2EpGJuuQbeAJwkUFDI1wzBmwA==;EndpointSuffix=core.windows.net");
  bool isFlightAPICalled;
  bool isFlightAPIDataLoading;
  bool isTicketBeingBooked;
  var flightsRepo;

  FlightScreenState({
    this.isFlightAPICalled = false,
    this.isFlightAPIDataLoading = false,
    this.isTicketBeingBooked = false,
    this.flightsRepo,
  });

  FlightScreenState copyWith(
      {var isFlightAPICalled,
      var isFlightAPIDataLoading,
      var flightsRepo,
      var isTicketBeingBooked}) {
    return FlightScreenState(
      isFlightAPICalled: isFlightAPICalled ?? this.isFlightAPICalled,
      isFlightAPIDataLoading:
          isFlightAPIDataLoading ?? this.isFlightAPIDataLoading,
      flightsRepo: flightsRepo ?? this.flightsRepo,
      isTicketBeingBooked: isTicketBeingBooked ?? this.isTicketBeingBooked,
    );
  }

  // Azure Database Manipulations
  Future<void> uploadTicketDetails(Map<String, dynamic> dataMap) async {
    try {
      await azureStorage.createTable(dataMap["head"]);
      var _rowKey = "${dataMap["head"]}row123";
      var _partitionKey = "${dataMap["head"]}partition123";
      await azureStorage.putTableRow(
        tableName: dataMap["head"],
        partitionKey: _partitionKey,
        rowKey: _rowKey,
        bodyMap: dataMap,
      );
    } catch (e) {
      rethrow;
    }
  }

  getAzureCardTable(String tableName) async {
    var tableData = await azureStorage.getTableRow(
      tableName: tableName,
      partitionKey: "${tableName}partition123",
      rowKey: "${tableName}row123",
    );

    return tableData;
  }

  deleteTable(String tableName) async {
    try {
      await azureStorage.deleteTable(tableName);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
