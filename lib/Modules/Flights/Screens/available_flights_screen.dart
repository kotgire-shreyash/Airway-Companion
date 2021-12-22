import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_repository.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Flights/Events/flights_screen_events.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
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
                backgroundColor: Colors.blue.shade500,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              body: CustomScrollView(
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverSafeArea(
                    sliver: SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: MediaQuery.of(context).size.height / 2.6,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      flexibleSpace: Container(
                        height: MediaQuery.of(context).size.height / 2.6,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          // color: Colors.deepPurpleAccent.shade200,
                          color: Colors.blue.shade500,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Search Flights",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.w900)
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
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
                                            color: Colors.grey.shade900,
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
                                            color: Colors.grey.shade900,
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
                                                      fontWeight:
                                                          FontWeight.w900)
                                                  .fontFamily,
                                            ),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
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
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Card(
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Container(
                            height: 330,
                            width: 200,
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
                      childCount: !state.isFlightAPICalled
                          ? 5
                          : state.flightsRepo.flightList.length,
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
    var dataModel = context
        .read<FlightScreenBloc>()
        .state
        .flightsRepo
        .getFlightDataModel(index);

    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        context
                            .read<FlightScreenBloc>()
                            .state
                            .flightsRepo
                            .getFlightDataModel(index)
                            .departureIATACode,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w900)
                                  .fontFamily,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: SizedBox(
                        width: 80,
                        height: 15,
                        child: Center(
                          child: Text(
                            dataModel.departureAirport,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Icon(
                CupertinoIcons.airplane,
                size: 35,
                color: Colors.blue.shade500,
              ),
              const SizedBox(
                width: 20,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        context
                            .read<FlightScreenBloc>()
                            .state
                            .flightsRepo
                            .getFlightDataModel(index)
                            .arrivalIATACode,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w900)
                                  .fontFamily,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Flexible(
                      child: Container(
                        width: 80,
                        height: 15,
                        child: Center(
                          child: Text(
                            context
                                .read<FlightScreenBloc>()
                                .state
                                .flightsRepo
                                .getFlightDataModel(index)
                                .arrivalAirport,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            // height: 25,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scheduled",
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.bold)
                                    .fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                            child: Text(
                              dataModel.departureSchedule,
                              style: TextStyle(
                                color: Colors.redAccent.shade200,
                                fontFamily: GoogleFonts.lato(
                                        fontWeight: FontWeight.w900)
                                    .fontFamily,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scheduled",
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.bold)
                                    .fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: FittedBox(
                            child: Text(
                              dataModel.arrivalSchedule,
                              style: TextStyle(
                                color: Colors.redAccent.shade200,
                                fontFamily: GoogleFonts.lato(
                                        fontWeight: FontWeight.w900)
                                    .fontFamily,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Terminal",
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.bold)
                                    .fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            dataModel.departureTerminal,
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Terminal",
                          style: TextStyle(
                            color: Colors.grey.shade900,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.bold)
                                    .fontFamily,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            dataModel.arrivalTerminal,
                            style: TextStyle(
                              color: Colors.green,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width / 2 - 120,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent.shade100,
                              border: Border.all(color: Colors.grey),
                            ),

                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                "Delay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width / 2 - 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                "${dataModel.departureDelay}",
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2 - 30,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width / 2 - 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                "${dataModel.arrivalDelay}",
                                style: TextStyle(
                                  color: Colors.grey.shade900,
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width / 2 - 120,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent.shade100,
                              border: Border.all(color: Colors.grey),
                            ),

                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Text(
                                "Delay",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: GoogleFonts.lato(
                                          fontWeight: FontWeight.bold)
                                      .fontFamily,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Flexible(
          child: Container(
            margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
            // color: Colors.blue,
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              children: [
                const SizedBox(width: 10),
                SizedBox(
                  child: FittedBox(
                    child: Text(
                      dataModel.flightIATA,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontFamily:
                            GoogleFonts.lato(fontWeight: FontWeight.w900)
                                .fontFamily,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text("More info",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w800)
                                    .fontFamily)),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.yellow.shade600,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Center(
                    child: Text(
                      "Book",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w800)
                                  .fontFamily),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}




/* 
Column(
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
                                        color: Colors.grey.shade900,
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
                                        color: Colors.grey.shade900,
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
                                                  fontWeight: FontWeight.w900)
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
                                horizontal: 15, vertical: 10),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Container(
                              height: 330,
                              width: 200,
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

*/