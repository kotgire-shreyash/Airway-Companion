import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBoxDelegate extends SearchDelegate<Widget> {
  final _appFeatureWidgets = [
    "Available Flights",
    "To-do List",
    "Map Navigation",
    "Guidelines",
    "Track",
  ];

  final _featureNavigationCorrespondence = [
    "availableFlights",
    "checkist",
    "checklist",
    "checklist",
    "timeline",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, const SizedBox());
      },
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final _suggestedItems = query.isEmpty
        ? []
        : _appFeatureWidgets
            .where((element) => element.toLowerCase().startsWith(query))
            .toList();

    return ListView.builder(
        itemCount: query.isEmpty || _appFeatureWidgets.isEmpty ? 0 : 5,
        itemBuilder: (context, index) {
          var _text = "";
          var _leadingIcon, _trailingIcon;
          try {
            _text = _suggestedItems[index];
            _leadingIcon = Icon(Icons.widgets,
                color:
                    index % 2 == 0 ? Colors.blue.shade600 : Colors.redAccent);
            _trailingIcon = const Icon(Icons.open_in_new, color: Colors.black);
          } catch (e) {
            _leadingIcon = null;
            _trailingIcon = null;
          }
          return ListTile(
            trailing: _trailingIcon,
            leading: _leadingIcon,
            title: Text(
              _text,
              style: TextStyle(
                fontFamily:
                    GoogleFonts.lato(fontWeight: FontWeight.w900).fontFamily,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                  context, _featureNavigationCorrespondence[index]);
            },
          );
        });
  }
}
