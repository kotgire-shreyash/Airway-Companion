// ignore_for_file: unused_field

import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key? key}) : super(key: key);

  @override
  _ExploreWidgetState createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  final _latoBoldFontFamily =
      GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily;
  final Search _search = Search();
  List<SearchModel> searchResultList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 450),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.white),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15),
            child: Text(
              "Explore",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 15,
                  fontFamily: _latoBoldFontFamily,
                  fontWeight: FontWeight.w900),
              textScaleFactor: 1.6,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          optionslist(),
          SizedBox(
            height: 10,
          ),
          searchResultList.isEmpty ? Container() : itemlist()
        ],
      ),
    );
  }

  optionslist() {
    List<String> _buttons = [
      'Hotels',
      'Restaurant',
      'ATM',
      'Cafe',
      'pharmacy',
      'hospital',
      'Books',
      'Taxi',
    ];
    return GroupButton(
      isRadio: false,
      spacing: 10,
      onSelected: (index, isSelected) async {
        if (isSelected) {
          searchResultList.clear();
          searchResultList =
              await _search.searchNearby(searchdata: _buttons[index]);
        } else {
          searchResultList.clear();
          NavigationScreen.of(context)!.points.clear();
        }
        NavigationScreen.of(context)!.result = searchResultList;
      },
      groupingType: GroupingType.wrap,
      buttons: _buttons,
    );
  }

  itemlist() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchResultList.length,
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.restaurant),
          title: Text(searchResultList[index].Name),
          subtitle: Text(searchResultList[index].Address),
          trailing: Text(
            '${searchResultList[index].distance.toStringAsFixed(2)}m',
            style: TextStyle(color: Colors.blue),
          ),
          isThreeLine: true,
        );
      },
    );
  }
}
