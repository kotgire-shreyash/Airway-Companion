import 'package:airwaycompanion/Data/Repositories/RoutesRepository/route_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/explore_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
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
  final List<Marker> _markers = [];
  final _origin = LatLng(13.199165, 77.707984);
  var points = <LatLng>[];

  set result(List<SearchModel> searchResultList) {
    setState(() {
      _markers.clear();
      for (var item in searchResultList) {
        _markers.add(CustomMarker(point: _origin, color: Colors.red));
        _markers
            .add(CustomMarker(point: LatLng(item.latitude, item.longitude)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            panelBuilder: (sc) => ExploreWidget(
              scrollController: sc,
            ),
            minHeight: 80,
            body: mapWidget(),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            backdropEnabled: false,
          ),
          // SafeArea(
          //   child: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(
          //       Icons.arrow_back,
          //       color: Colors.black,
          //       size: 28,
          //     ),
          //   ),
          // ),
          SafeArea(
            child: Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(left: 10, right: 10),
                child: _searchBar()),
          ),
          SafeArea(
            child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(
                    top: 60,
                    bottom: MediaQuery.of(context).size.height - 150,
                    left: 5,
                    right: 5),
                child: const QuickSelect()),
          ),
        ],
      ),
    );
  }

  Widget mapWidget() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapCreated: (mapController) {
          _markers.add(
              CustomMarker(point: _origin, color: Colors.redAccent.shade700));
        },
        center: _origin,
        zoom: 10,
        plugins: [
          VectorMapTilesPlugin(),
        ],
        minZoom: 5.0,
        maxZoom: 30.0,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      layers: [
        TileLayerOptions(
          minZoom: 2,
          maxZoom: 22,
          errorTileCallback: (tile, error) => print(error),
          urlTemplate:
              "https://atlas.microsoft.com/map/tile?subscription-key={subscriptionKey}&api-version=2.1&tileSize=512&tilesetId={tilesetId}&zoom={z}&x={x}&y={y}",
          additionalOptions: {
            'subscriptionKey': 'OmHax9byGsCpudWRxU0lYnTgw81r6Eq9nlCqRk3EnGI',
            'tilesetId': 'microsoft.base.road'
          },
          tileProvider: const NonCachingNetworkTileProvider(),
          errorImage: const Image(
            image: AssetImage("assets/GIF/mao_loading.gif"),
            fit: BoxFit.scaleDown,
          ).image,
          // errorImage: AssetImage("assets/GIF/map_loading.gif"),
          // errorImage: GIF
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

  void drawPolyline(destination) async {
    Routes _routes = Routes(origin: _origin, destination: destination);
    points = await _routes.getRouteDetails();
  }

  Widget _searchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 50,
        width: 350,
        child: Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
            ),
            Flexible(
              child: SizedBox(
                height: 50,
                width: 280,
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,

                    contentPadding: const EdgeInsets.all(16.0),
                    hintText: "Looking for something ?",
                    hintStyle: TextStyle(
                        fontFamily: GoogleFonts.lato().fontFamily,
                        fontSize: 15),

                    // prefixIcon: const Icon(Icons.arrow_back),
                    suffixIcon: const Icon(
                      Icons.search_outlined,
                      size: 25,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// https://meet.google.com/tfe-uihw-nke