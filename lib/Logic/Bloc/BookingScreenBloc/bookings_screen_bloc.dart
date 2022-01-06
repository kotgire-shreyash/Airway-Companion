import 'dart:convert';

import 'package:airwaycompanion/Modules/Bookings/Events/bookings_screen_events.dart';
import 'package:airwaycompanion/Modules/Bookings/Screens/bookings_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingScreenBloc extends Bloc<BookingScreenEvent, BookingScreenState> {
  BookingScreenBloc() : super(BookingScreenState()) {
    on<AzureDatabaseRetrieve>(_retrieveDataFromAzureDatabase);
  }

  _retrieveDataFromAzureDatabase(
      AzureDatabaseRetrieve event, Emitter<BookingScreenState> emit) async {
    emit(state.copyWith(isDataBeingUpdated: true));
    List<String?> retrievedListFromAzureStorage =
        await state.azureStorage.getTables();
    var bookedTicketsList = [];
    for (String? table in retrievedListFromAzureStorage) {
      try {
        var result = await state.getAzureDatabaseTable(table ?? "");
        Map jsonData = await jsonDecode(result);
        bookedTicketsList.add(jsonData);
      } catch (e) {
        rethrow;
      }
    }

    emit(state.copyWith(
        bookedTicketsList: bookedTicketsList, isDataBeingUpdated: false));
  }
}
