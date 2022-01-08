import 'package:azstore/azstore.dart';

class BookingScreenState {
  final azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=acflightbookingservice;AccountKey=Vw3i+ZWx+bIdxKOK7dBm6FMrxZ/YiCsAjFydC/5gwkhwnZM7VzffXPbG+TKyM2EpGJuuQbeAJwkUFDI1wzBmwA==;EndpointSuffix=core.windows.net");
  List bookedTicketsList;
  bool isDataBeingUpdated;
  var time;

  BookingScreenState({
    this.bookedTicketsList = const [],
    this.isDataBeingUpdated = false,
    this.time,
  });

  BookingScreenState copyWith(
      {var bookedTicketsList, var isDataBeingUpdated, var time}) {
    return BookingScreenState(
      bookedTicketsList: bookedTicketsList ?? this.bookedTicketsList,
      isDataBeingUpdated: isDataBeingUpdated ?? this.isDataBeingUpdated,
      time: time ?? this.time,
    );
  }

  getAzureDatabaseTable(String tableName) async {
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
