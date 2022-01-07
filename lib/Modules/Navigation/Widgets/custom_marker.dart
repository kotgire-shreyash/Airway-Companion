import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CustomMarker extends Marker {
  CustomMarker({
    required LatLng point,
    Color color = Colors.blue,
  }) : super(
          width: 80.0,
          height: 80.0,
          point: point,
          builder: (ctx) => IconButton(
            onPressed: () {
              NavigationScreen.of(ctx)!.drawPolyline(point);
            },
            icon: Icon(
              Icons.location_on,
              color: color,
              size: 40,
            ),
          ),
        );
}
