import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/SearchRepository/search_model.dart';
import 'package:airwaycompanion/Logic/Bloc/NavigationScreenBloc/navigation_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Navigation/Events/navigation_screen_events.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen.dart';
import 'package:airwaycompanion/Modules/Navigation/Screens/navigation_screen_states.dart';
import 'package:airwaycompanion/Modules/Navigation/Widgets/custom_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    return BlocBuilder<NavigationScreenBloc, NavigationScreenState>(
        builder: (context, state) {
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
          state.searchResultList.isEmpty ? Container() : _getItemsList()
        ],
      );
    });
  }

  _getOptionsList() {
    return GroupButton(
      isRadio: false,
      spacing: 10,
      onSelected: (index, isSelected) async {
        if (isSelected) {
          context
              .read<NavigationScreenBloc>()
              .add(AmenitiesSearchButtonPressed(index: index));

          iconIndex = index;
        }
      },
      groupingType: GroupingType.wrap,
      buttons: context.read<NavigationScreenBloc>().state.buttons,
    );
  }

  _getItemsList() {
    final ScrollController _listViewScrollController = ScrollController();
    return ListView.builder(
      shrinkWrap: true,
      controller: _listViewScrollController,
      itemCount:
          context.read<NavigationScreenBloc>().state.searchResultList.length,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (ctx, index) {
        var searchResultList =
            context.read<NavigationScreenBloc>().state.searchResultList;
        return ListTile(
          leading:
              Icon(context.read<NavigationScreenBloc>().state.icons[iconIndex]),
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

class QuickSelect extends StatefulWidget {
  const QuickSelect({Key? key}) : super(key: key);

  @override
  _QuickSelectState createState() => _QuickSelectState();
}

class _QuickSelectState extends State<QuickSelect> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: context.read<NavigationScreenBloc>().state.buttons.length,
      itemBuilder: (ctx, int index) {
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
                    context
                        .read<NavigationScreenBloc>()
                        .add(AmenitiesSearchButtonPressed(index: index));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        context.read<NavigationScreenBloc>().state.icons[index],
                        color: Colors.black,
                      ),
                      Text(
                        context
                            .read<NavigationScreenBloc>()
                            .state
                            .buttons[index],
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
