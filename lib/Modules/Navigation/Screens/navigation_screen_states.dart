import 'package:airwaycompanion/Data/Repositories/RoutesRepository/route_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class NavigationScreenState {
  List<Marker> markers = [];
  List<LatLng> points = [];
  List<SearchModel> searchResultList = [];
  final List<String> buttons = [
    'Hotels',
    'Restaurant',
    'ATM',
    'Cafe',
    'pharmacy',
    'hospital',
    'Books',
    'Taxi',
  ];
  final List icons = [
    Icons.hotel,
    Icons.restaurant,
    Icons.atm,
    Icons.local_cafe,
    Icons.medical_services,
    Icons.local_hospital,
    Icons.library_books,
    Icons.local_taxi,
  ];

  final origin = LatLng(13.199165, 77.707984);
  final Search search = Search();
  bool isRequestBeingProcessed;

  NavigationScreenState({
    this.markers = const [],
    this.searchResultList = const [],
    this.points = const [],
    this.isRequestBeingProcessed = false,
  });

  NavigationScreenState copyWith(
      {var searchResultList,
      var markers,
      var points,
      var isRequestBeingProcessed}) {
    return NavigationScreenState(
      searchResultList: searchResultList ?? this.searchResultList,
      markers: markers ?? this.markers,
      points: points ?? this.points,
      isRequestBeingProcessed:
          isRequestBeingProcessed ?? this.isRequestBeingProcessed,
    );
  }
}
