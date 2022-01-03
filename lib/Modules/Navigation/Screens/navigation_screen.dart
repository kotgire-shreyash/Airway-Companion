// ignore_for_file: prefer_const_constructors

import 'package:airwaycompanion/Data/Repositories/RoutesRepository/route_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/explore_widget.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();

  static _NavigationScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_NavigationScreenState>();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final MapController _mapController = MapController();
  //final _intialPostion = LatLng(13.199165, 77.707984);
  final List<Marker> _markers = [];
  var _origin = LatLng(13.199165, 77.707984);
  var points = <LatLng>[];

  set result(List<SearchModel> searchResultList) {
    setState(() {
      _markers.clear();
      for (var item in searchResultList) {
        _markers.add(CustomMarker(point: _origin, color: Colors.red));
        _markers
            .add(CustomMarker(point: LatLng(item.Latitude, item.Longitude)));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MapWidget(),
          ),
          ExploreWidget(),
          serchBar(),
        ],
      ),
    );
  }

  FlutterMap MapWidget() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapCreated: (mapController) {
          _markers.add(
              CustomMarker(point: _origin, color: Colors.redAccent.shade700));
        },
        center: _origin, zoom: 10, //range in 0 to 21
        // onTap: _addmarker,
        plugins: [
          VectorMapTilesPlugin(),
        ],
      ),
      layers: [
        TileLayerOptions(
          minZoom: 2,
          maxZoom: 22,
          errorTileCallback: (tile, error) => print(error),
          urlTemplate:
              // "https://atlas.microsoft.com/map/tile/png?api-version=1&layer=hybrid&style=main&tileSize=512&view=Auto&zoom={z}&x={x}&y={y}&subscription-key={subscriptionKey}",
              "https://atlas.microsoft.com/map/tile?subscription-key={subscriptionKey}&api-version=2.1&tileSize=512&tilesetId={tilesetId}&zoom={z}&x={x}&y={y}",
          additionalOptions: {
            'subscriptionKey': 'OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI',
            'tilesetId': 'microsoft.base.road'
          },
          tileProvider: const NonCachingNetworkTileProvider(),
          //errorImage: image to be displayed when map not loaded
        ),
        // For building Polylines
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: points,
              strokeWidth: 4.0,
              isDotted: true,
              colorsStop: [5, 10],
              color: Colors.blue.shade700,
            ),
          ],
        ),
        MarkerLayerOptions(
          markers: _markers,
        ),
      ],
    );
  }

  // void _addmarker(tapposition, point) {
  //   if (_origin == null || (_origin != null && _destination != null)) {
  //     setState(() {
  //       points.clear();
  //       _markers.clear();
  //       _origin = point;
  //       _destination = null;
  //       _markers.add(CustomMarker(point: point, color: Colors.red));
  //     });
  //   } else {
  //     setState(() {
  //       _destination = point;
  //       _markers.add(CustomMarker(point: point, color: Colors.green));
  //       // drawPolyline();
  //     });
  //   }
  // }

  void drawPolyline(destination) async {
    Routes _Routes = Routes(origin: _origin, destination: destination);
    points = await _Routes.getRouteDetails();
  }

  Widget serchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 34.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(16.0),
            hintText: "Looking for something ?",
            prefixIcon: Icon(Icons.search_outlined),
          ),
        ),
      ),
    );
  }
}
