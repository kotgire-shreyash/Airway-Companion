import 'package:azstore/azstore.dart';

class BookingScreenState {
  final azureStorage = AzureStorage.parse(
      "DefaultEndpointsProtocol=https;AccountName=acflightbookings;AccountKey=CX4yeg2NXi3W0LbtFk1RvpcqlHJ717sfhHqibjMVOOGlYYCVw0rgcMH4UJI8mVyIp361ivherFOr8mmWw75g9w==;EndpointSuffix=core.windows.net");
  List bookedTicketsList;
  bool isDataBeingUpdated;

  BookingScreenState({
    this.bookedTicketsList = const [],
    this.isDataBeingUpdated = false,
  });

  BookingScreenState copyWith({var bookedTicketsList, var isDataBeingUpdated}) {
    return BookingScreenState(
      bookedTicketsList: bookedTicketsList ?? this.bookedTicketsList,
      isDataBeingUpdated: isDataBeingUpdated ?? this.isDataBeingUpdated,
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
