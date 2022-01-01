import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  MapController _mapController = MapController();
  final _intialPostion = LatLng(13.199165, 77.707984);
  var _origin;
  var _destination;
  var points = <LatLng>[];

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: FlutterMap(
            options: MapOptions(
              onMapCreated: (mapController) => _mapController = mapController,
              center: _intialPostion,
              zoom: 18, //range in 0 to 21
              onTap: _addmarker,
              allowPanning: true,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    // "https://atlas.microsoft.com/map/tile/png?api-version=2.1&layer=basic&style=main&tileSize=256&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
                    "https://atlas.microsoft.com/map/tile?subscription-key={subscriptionKey}&api-version=2.1&tilesetId={tilesetId}&zoom={z}&x={x}&y={y}",
                additionalOptions: {
                  'subscriptionKey':
                      'OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI',
                  'tilesetId': 'microsoft.imagery'
                },
                tileProvider: const NonCachingNetworkTileProvider(),
              ),
              PolylineLayerOptions(
                // rebuild: ,
                polylines: [
                  Polyline(
                    points: points,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  ),
                ],
                //polylineCulling: true,
              ),
              MarkerLayerOptions(
                markers: [
                  if (_origin != null) _origin,
                  if (_destination != null) _destination
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void _addmarker(tapposition, point) {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        );
        points.clear();
      });
      _destination = null;
    } else {
      setState(() {
        _destination = Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.green,
            size: 40,
          ),
        );
        drawPolyline();
        points.isEmpty;
      });
    }
  }

  drawPolyline() async {
    var originLat = _origin.point.latitude;
    var originLong = _origin.point.longitude;
    var destinationLat = _destination.point.latitude;
    var destinationLong = _destination.point.longitude;
    var url = Uri.parse(
        'https://atlas.microsoft.com/route/directions/json?subscription-key=OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI&api-version=1.0&query=$originLat,$originLong:$destinationLat,$destinationLong');
    final response = await http.get(url);
    var responsedata = json.decode(response.body);
    for (var item in responsedata['routes'][0]['legs'][0]['points']) {
      points.add(LatLng(item['latitude'], item['longitude']));
    }
  }
}
