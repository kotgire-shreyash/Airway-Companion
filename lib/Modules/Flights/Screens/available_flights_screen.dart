import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_repository.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Flights/Events/flights_screen_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:airwaycompanion/Modules/General Widgets/Bottom Navigation Bar/bottom_navigation_bar.dart'
    as bottomBar;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'flights_screen_states.dart';

class AvailableFlights extends StatefulWidget {
  const AvailableFlights({Key? key}) : super(key: key);

  @override
  _AvailableFlightsState createState() => _AvailableFlightsState();
}

class _AvailableFlightsState extends State<AvailableFlights> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    if (!context.read<FlightScreenBloc>().state.isFlightAPICalled) {
      context
          .read<FlightScreenBloc>()
          .add(FlightAPICalled(isFlightAPICalled: true));
    }

    super.initState();
  }

  void _onRefresh() {
    context
        .read<FlightScreenBloc>()
        .add(FlightAPICalled(isFlightAPICalled: true));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FlightScreenBloc, FlightScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            physics: const BouncingScrollPhysics(),
            cacheExtent: 50,
            header: WaterDropMaterialHeader(
              distance: 50,
              backgroundColor: Colors.grey.shade200,
              color: Colors.black,
            ),
            onRefresh: _onRefresh,
            child: Scaffold(
              backgroundColor: Colors.grey.shade100,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.deepPurpleAccent.shade200,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              body: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2.6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade200,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Search Flights",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            height: MediaQuery.of(context).size.height / 3.5,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "source",
                                      hintStyle: TextStyle(
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily,
                                          fontSize: 13),
                                      icon: Icon(
                                        FontAwesomeIcons.sourcetree,
                                        color: Colors.grey.shade600,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "destination",
                                      hintStyle: TextStyle(
                                          fontFamily:
                                              GoogleFonts.lato().fontFamily,
                                          fontSize: 13),
                                      icon: Icon(
                                        CupertinoIcons.airplane,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Search",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: GoogleFonts.lato(
                                                  fontWeight: FontWeight.bold)
                                              .fontFamily,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Colors.deepPurpleAccent.shade200,
                                        minimumSize: const Size(130, 40),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: !state.isFlightAPICalled
                            ? 5
                            : state.flightsRepo.flightList.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, int index) {
                          return Card(
                            elevation: 10,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Container(
                              height: 300,
                              width: 180,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: state.isFlightAPIDataLoading
                                  ? Center(
                                      child: SizedBox(
                                        height: 50,
                                        width: 50,
                                        child: LoadingAnimationWidget
                                            .staggeredDotWave(
                                                color: Colors.black, size: 50),
                                      ),
                                    )
                                  : _flightDetailsCard(index),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _flightDetailsCard(int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                child: Text(
                  context
                      .read<FlightScreenBloc>()
                      .state
                      .flightsRepo
                      .getFlightDataModel(index)
                      .arrivalAirport,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: GoogleFonts.lato(fontWeight: FontWeight.w900)
                        .fontFamily,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
