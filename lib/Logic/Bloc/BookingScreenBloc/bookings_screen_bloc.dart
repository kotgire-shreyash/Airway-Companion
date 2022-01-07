import 'dart:convert';

import 'package:airwaycompanion/Modules/Bookings/Events/bookings_screen_events.dart';
import 'package:airwaycompanion/Modules/Bookings/Screens/bookings_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookingScreenBloc extends Bloc<BookingScreenEvent, BookingScreenState> {
  BookingScreenBloc() : super(BookingScreenState()) {
    on<AzureDatabaseRetrieve>(_retrieveDataFromAzureDatabase);
    on<UpdateTime>(_onUpdateTime);
    on<CancelTicket>(_onCancelTicketEvent);
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

  void _onUpdateTime(UpdateTime event, Emitter<BookingScreenState> emit) {
    final DateTime now = DateTime.now();
    final String formattedDateTime = DateFormat('hh:mm:ss').format(now);
    emit(state.copyWith(time: formattedDateTime));
  }

  void _onCancelTicketEvent(
      CancelTicket event, Emitter<BookingScreenState> emit) async {
    emit(state.copyWith(isDataBeingUpdated: true));
    await state.deleteTable(event.tableName);
    await _retrieveDataFromAzureDatabase(AzureDatabaseRetrieve(), emit);
    emit(state.copyWith(isDataBeingUpdated: false));
  }
}
