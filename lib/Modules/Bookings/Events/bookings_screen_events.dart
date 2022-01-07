abstract class BookingScreenEvent {}

class AzureDatabaseRetrieve extends BookingScreenEvent {
  bool isDataBeingUpdated;
  AzureDatabaseRetrieve({this.isDataBeingUpdated = false});
}

class UpdateTime extends BookingScreenEvent {}

class CancelTicket extends BookingScreenEvent {
  String tableName;
  CancelTicket({required this.tableName});
}
