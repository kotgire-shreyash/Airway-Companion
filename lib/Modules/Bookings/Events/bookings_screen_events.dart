abstract class BookingScreenEvent {}

class AzureDatabaseRetrieve extends BookingScreenEvent {
  bool isDataBeingUpdated;
  AzureDatabaseRetrieve({this.isDataBeingUpdated = false});
}
