import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_data_provider.dart';
import 'package:airwaycompanion/Data/Repositories/FlightsRepository/flights_repository.dart';
import 'package:airwaycompanion/Logic/Bloc/FlightsScreenBloc/flights_screen_bloc.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Flights/Events/flights_screen_events.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/custom_colors.dart';
import 'package:expandable/expandable.dart';
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
  const AvailableFlights(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final bottomBar;

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
    context.read<FlightScreenBloc>().add(FlightAPICalled(
          isFlightAPICalled: true,
        ));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    // Set bottom bar index
    CustomBottomNavigationBar.index = 1;

    return BlocConsumer<FlightScreenBloc, FlightScreenState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: SmartRefresher(
            controller: _refreshController,
            cacheExtent: 50,
            header: WaterDropMaterialHeader(
              distance: 50,
              backgroundColor: Colors.grey.shade200,
              color: Colors.black,
            ),
            onRefresh: _onRefresh,
            child: Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: widget.chatbot,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              bottomNavigationBar: widget.bottomBar,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.blue.shade700,
                leading: IconButton(
                    onPressed: () {
                      CustomBottomNavigationBar.index = 0;

                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.blue.shade700,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 25),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Search Flights",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: GoogleFonts.lato(
                                        fontWeight: FontWeight.w800)
                                    .fontFamily,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              height: MediaQuery.of(context).size.height / 4.7,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "source",
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                            fontSize: 12),
                                        icon: Icon(
                                          FontAwesomeIcons.sourcetree,
                                          color: Colors.grey.shade900,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "destination",
                                        hintStyle: TextStyle(
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                            fontSize: 12),
                                        icon: Icon(
                                          CupertinoIcons.airplane,
                                          color: Colors.grey.shade900,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: Card(
                                        elevation: 5,
                                        color: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5),
                                          ),
                                        ),
                                        child: Container(
                                          height: 25,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.blue.shade500,
                                                Colors.blue.shade400,
                                                Colors.blue.shade400,
                                                Colors.blue.shade500,
                                              ],
                                              stops: const [
                                                0.1,
                                                0.3,
                                                0.7,
                                                0.9,
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            child: Text(
                                              "Search",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontFamily: GoogleFonts.lato(
                                                          fontWeight:
                                                              FontWeight.w900)
                                                      .fontFamily),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(90, 25),
                                              primary: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              elevation: 5,
                                            ),
                                            onPressed: () {},
                                          ),
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
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Available Flights",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w500)
                                  .fontFamily,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Flexible(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.builder(
                          itemCount: !state.isFlightAPICalled
                              ? 5
                              : state.flightsRepo.flightList.length,
                          shrinkWrap: true,
                          primary: false,
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
                                height: 250,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: state.isFlightAPIDataLoading
                                    ? Center(
                                        child: SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: LoadingAnimationWidget
                                              .staggeredDotWave(
                                                  color: Colors.black,
                                                  size: 30),
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
      children: <Widget>[
            const SizedBox(
              height: 20,
            ),
          ] +
          _widgets(dataModel, index) +
          [
            Container(
              margin: const EdgeInsets.only(top: 15, left: 10, right: 10),
              // color: Colors.blue,

              width: MediaQuery.of(context).size.width,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  SizedBox(
                    child: FittedBox(
                      child: Text(
                        dataModel.flightIATA,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontFamily:
                              GoogleFonts.lato(fontWeight: FontWeight.w900)
                                  .fontFamily,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black45,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext context, Animation animation,
                            Animation secondaryAnimation) {
                          return SafeArea(
                            child: SingleChildScrollView(
                              child: Center(
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey.shade100,
                                  child: Center(
                                    child: Column(
                                        // children: _widgets(dataModel, index),
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Text("More info",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w800)
                                    .fontFamily,
                            fontSize: 12,
                          )),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.yellow.shade700,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    child: ElevatedButton(
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "Book",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w800)
                                      .fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return _modalBottomSheet(
                                  context, dataModel, index);
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
    );
  }

  Widget _modalBottomSheet(BuildContext context, var dataModel, int index) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    CupertinoIcons.airplane,
                    color: Colors.yellow.shade600,
                    size: 30,
                  ),
                  const Center(
                    child: Text(
                        " - - - - - - - - - - - - - - - - - - - - - - - - - - - "),
                  ),
                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            dataModel.departureIATACode,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            dataModel.departureAirport,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.blue,
                              overflow: TextOverflow.ellipsis,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: Text(
                            dataModel.arrivalIATACode,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            dataModel.arrivalAirport,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.blue,
                              overflow: TextOverflow.ellipsis,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              // height: 200,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            "IATA",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        )),
                  ),
                  Flexible(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            dataModel.flightIATA,
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              // height: 200,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            "Airlines",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                              fontSize: 12,
                            ),
                          ),
                        )),
                  ),
                  Flexible(
                    child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 30,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            dataModel.airlineName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
                                      .fontFamily,
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Flexible(
                child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: SizedBox(
                    width: 150,
                    child: Text(
                      "\$ ${((index + 1) * 200) % 5000} USD",
                      style: TextStyle(
                        color: Colors.yellow.shade800,
                        fontFamily: GoogleFonts.lato(
                          fontWeight: FontWeight.w900,
                        ).fontFamily,
                        fontSize: 20,
                      ),
                    ),
                  )),
                  BlocBuilder<FlightScreenBloc, FlightScreenState>(
                      builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        Map<String, dynamic> dataMap = {
                          "head":
                              "${dataModel.arrivalIATACode}${dataModel.departureIATACode}",
                          "arrivalDelay": "${dataModel.arrivalDelay}",
                          "departureDelay": "${dataModel.departureDelay}",
                          "arrivalAirport": "${dataModel.arrivalAirport}",
                          "departureAirport": "${dataModel.departureAirport}",
                          "arrivalIATACode": "${dataModel.arrivalIATACode}",
                          "departureIATACode": "${dataModel.departureIATACode}",
                          "arrivalSchedule": "${dataModel.arrivalSchedule}",
                          "departureSchedule": "${dataModel.departureSchedule}",
                          "airlineName": "${dataModel.airlineName}",
                        };

                        context
                            .read<FlightScreenBloc>()
                            .add(FlightTicketBooking(dataMap: dataMap));
                      },
                      child: Center(
                        child: context
                                .read<FlightScreenBloc>()
                                .state
                                .isTicketBeingBooked
                            ? Container(
                                // margin: const EdgeInsets.all(20),
                                height: 20,
                                width: 20,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : FittedBox(
                                child: Text(
                                  "Book",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: GoogleFonts.lato(
                                              fontWeight: FontWeight.w800)
                                          .fontFamily),
                                ),
                              ),
                      ),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(90, 20),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> _widgets(var dataModel, int index) {
    return <Widget>[
      SizedBox(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      dataModel.departureIATACode,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily:
                            GoogleFonts.lato(fontWeight: FontWeight.w900)
                                .fontFamily,
                        fontSize: 25,
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
                            color: Colors.blue,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w900)
                                    .fontFamily,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Icon(
              CupertinoIcons.airplane,
              size: 30,
              color: Colors.blue.shade500,
            ),
            const SizedBox(
              width: 30,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      dataModel.arrivalIATACode,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily:
                            GoogleFonts.lato(fontWeight: FontWeight.w900)
                                .fontFamily,
                        fontSize: 25,
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
                          dataModel.arrivalAirport,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily:
                                GoogleFonts.lato(fontWeight: FontWeight.w900)
                                    .fontFamily,
                            fontSize: 10,
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
                  height: 35,
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
                          fontSize: 11,
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
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
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
                  height: 35,
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
                          fontSize: 11,
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
                              fontFamily:
                                  GoogleFonts.lato(fontWeight: FontWeight.w900)
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
                  height: 35,
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
                          fontSize: 11,
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
                            fontSize: 10,
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
                  height: 35,
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
                          fontSize: 11,
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
                            fontSize: 10,
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
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 30,
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          height: 25,
                          width: MediaQuery.of(context).size.width / 2 - 120,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade700,
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
                                fontSize: 11,
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
                                fontSize: 11,
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
                  height: 30,
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
                                fontSize: 11,
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
                            color: Colors.blue.shade700,
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
                                fontSize: 11,
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
    ];
  }
}
