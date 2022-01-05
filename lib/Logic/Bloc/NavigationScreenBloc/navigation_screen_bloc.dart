import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Modules/Navigation/Events/navigation_screen_events.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen_states.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NavigationScreenBloc
    extends Bloc<NavigationScreenEvent, NavigationScreenState> {
  NavigationScreenBloc() : super(NavigationScreenState()) {
    on<AmenitiesSearchButtonPressed>(_onAmenitiesSearchButtonPressedEvent);
    on<AddMarker>(_onAddMarkerEvent);
    on<DrawPolylines>(_onDrawPolylines);
  }

  void _onAmenitiesSearchButtonPressedEvent(AmenitiesSearchButtonPressed event,
      Emitter<NavigationScreenState> emit) async {
    emit(state
        .copyWith(points: const <LatLng>[], isRequestBeingProcessed: true));
    List<SearchModel> _searchResultList =
        await state.search.searchNearby(searchdata: state.buttons[event.index]);

    List<Marker> markers = [];
    markers.add(CustomMarker(
      point: state.origin,
      color: Colors.red,
    ));
    for (var item in _searchResultList) {
      markers.add(CustomMarker(point: LatLng(item.latitude, item.longitude)));
    }

    emit(state.copyWith(
      searchResultList: _searchResultList,
      markers: markers,
      isRequestBeingProcessed: false,
    ));
  }

  void _onAddMarkerEvent(AddMarker event, Emitter<NavigationScreenState> emit) {
    List<Marker> markers = [
      CustomMarker(point: state.origin, color: Colors.red)
    ];
    emit(state.copyWith(markers: markers));
  }

  void _onDrawPolylines(
      DrawPolylines event, Emitter<NavigationScreenState> emit) async {
    emit(state.copyWith(isRequestBeingProcessed: true));
    List<LatLng> points = await event.routes.getRouteDetails();
    emit(state.copyWith(points: points, isRequestBeingProcessed: false));
  }
}
