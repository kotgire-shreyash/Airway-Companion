import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:latlong2/latlong.dart';

final List<String> _buttons = [
  'Hotels',
  'Restaurant',
  'ATM',
  'Cafe',
  'pharmacy',
  'hospital',
  'Books',
  'Taxi',
];

final List _icons = [
  Icons.hotel,
  Icons.restaurant,
  Icons.atm,
  Icons.local_cafe,
  Icons.medical_services,
  Icons.local_hospital,
  Icons.library_books,
  Icons.local_taxi,
];

List<SearchModel> searchResultList = [];
final Search _search = Search();

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  int iconIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          "Explore nearby",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 15,
              fontFamily: GoogleFonts.lato().fontFamily,
              fontWeight: FontWeight.bold),
          textScaleFactor: 1.5,
        ),
        const SizedBox(
          height: 10,
        ),
        _getOptionsList(),
        const SizedBox(
          height: 10,
        ),
        searchResultList.isEmpty ? Container() : _getItemsList()
      ],
    );
  }

  _getOptionsList() {
    return GroupButton(
      isRadio: false,
      spacing: 10,
      onSelected: (index, isSelected) async {
        searchResultList.clear();
        NavigationScreen.of(context)!.points.clear();
        if (isSelected) {
          searchResultList.clear();
          searchResultList =
              await _search.searchNearby(searchdata: _buttons[index]);
          iconIndex = index;
        }
        NavigationScreen.of(context)!.result = searchResultList;
      },
      groupingType: GroupingType.wrap,
      buttons: _buttons,
    );
  }

  _getItemsList() {
    final ScrollController _listViewScrollController = ScrollController();
    return ListView.builder(
      shrinkWrap: true,
      controller: _listViewScrollController,
      itemCount: searchResultList.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(_icons[iconIndex]),
          title: Text(searchResultList[index].name),
          subtitle: Text(searchResultList[index].address),
          trailing: Text(
            '${searchResultList[index].distance.toStringAsFixed(2)}m',
            style: const TextStyle(color: Colors.blue),
          ),
          isThreeLine: true,
        );
      },
    );
  }
}

class QuickSelect extends StatelessWidget {
  const QuickSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: _buttons.length,
      itemBuilder: (context, int index) {
        return Row(
          children: [
            Card(
              elevation: 5,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.elliptical(25, 25))),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.elliptical(25, 25))),
                height: 50,
                width: 135,
                child: FloatingActionButton(
                  heroTag: "$index",
                  elevation: 0,
                  backgroundColor: Colors.white,
                  isExtended: true,
                  onPressed: () async {
                    searchResultList.clear();
                    searchResultList =
                        await _search.searchNearby(searchdata: _buttons[index]);
                    markers.clear();
                    for (var item in searchResultList) {
                      markers.add(CustomMarker(
                          point: LatLng(13.199165, 77.707984),
                          color: Colors.red));
                      markers.add(CustomMarker(
                          point: LatLng(item.latitude, item.longitude)));
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        _icons[index],
                        color: Colors.black,
                      ),
                      Text(
                        _buttons[index],
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            )
          ],
        );
      },
    );
  }
}
