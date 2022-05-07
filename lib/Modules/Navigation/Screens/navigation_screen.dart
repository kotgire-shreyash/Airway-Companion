import 'package:airwaycompanion/Data/Repositories/RoutesRepository/route_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Logic/Bloc/NavigationScreenBloc/navigation_screen_bloc.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/Navigation/Events/navigation_screen_events.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/explore_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

import 'navigation_screen_states.dart';

final List<Marker> markers = [];

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key, required this.bottomBar}) : super(key: key);
  final bottomBar;

  @override
  _NavigationScreenState createState() => _NavigationScreenState();

  static _NavigationScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_NavigationScreenState>();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final MapController _mapController = MapController();
  final _origin = LatLng(13.199165, 77.707984);

  @override
  void initState() {
    CustomBottomNavigationBar.index = 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NavigationScreenBloc, NavigationScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: widget.bottomBar,
            body: Stack(
              children: [
                SlidingUpPanel(
                  panelBuilder: (sc) => ExploreWidget(
                    scrollController: sc,
                  ),
                  color: Colors.white,
                  minHeight: 80,
                  body: mapWidget(),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  backdropEnabled: false,
                ),
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
                          bottom: MediaQuery.of(context).size.height - 230,
                          left: 5,
                          right: 5),
                      child: const QuickSelect()),
                ),
              ],
            ),
          );
        });
  }

  Widget mapWidget() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        onMapCreated: (mapController) {
          context.read<NavigationScreenBloc>().add(AddMarker());
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
            'subscriptionKey': '00KZPaf_h8qKYC4kyvauh4XAJ5GxGQlX4zxMhGMAeG4',
            'tilesetId': 'microsoft.base.road'
          },
          tileProvider: const NonCachingNetworkTileProvider(),
          errorImage: const Image(
            image: AssetImage("assets/GIF/map_loading.gif"),
            fit: BoxFit.cover,
            height: 30,
            width: 30,
          ).image,
        ),
        // For building Polylines
        PolylineLayerOptions(
          polylines: [
            Polyline(
              points: context.read<NavigationScreenBloc>().state.points,
              strokeWidth: 4.0,
              isDotted: true,
              colorsStop: [5, 10],
              color: Colors.blue,
            ),
          ],
        ),
        MarkerLayerOptions(
          markers: context.read<NavigationScreenBloc>().state.markers,
        ),
      ],
    );
  }

  void drawPolyline(destination) async {
    Routes _routes = Routes(origin: _origin, destination: destination);
    context.read<NavigationScreenBloc>().add(
          DrawPolylines(routes: _routes),
        );
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
                    suffixIcon: context
                            .read<NavigationScreenBloc>()
                            .state
                            .isRequestBeingProcessed
                        ? Container(
                            margin: const EdgeInsets.all(15),
                            height: 5,
                            width: 5,
                            child: CircularProgressIndicator(
                              color: Colors.grey.shade600,
                              strokeWidth: 2,
                            ))
                        : const Icon(
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
