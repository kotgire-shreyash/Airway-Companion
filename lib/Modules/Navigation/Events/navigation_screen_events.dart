import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';

abstract class NavigationScreenEvent {}

class AmenitiesSearchButtonPressed extends NavigationScreenEvent {
  int index;
  AmenitiesSearchButtonPressed({required this.index});
}

class AddMarker extends NavigationScreenEvent {}

class DrawPolylines extends NavigationScreenEvent {
  var routes;
  DrawPolylines({this.routes});
}
