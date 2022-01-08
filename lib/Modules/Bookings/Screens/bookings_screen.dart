import 'package:airwaycompanion/Logic/Bloc/BookingScreenBloc/bookings_screen_bloc.dart';
import 'package:airwaycompanion/Modules/Bookings/Events/bookings_screen_events.dart';
import 'package:airwaycompanion/Modules/Bookings/Screens/bookings_screen_state.dart';
import 'package:airwaycompanion/Modules/ChatBot/Widget/chat_bot.dart';
import 'package:airwaycompanion/Modules/Checklist/Events/checklist_screen_event.dart';
import 'package:airwaycompanion/Modules/General%20Widgets/Bottom%20Navigation%20Bar/bottom_navigation_bar.dart';
import 'package:airwaycompanion/Modules/Notifications/notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen(
      {Key? key, required this.chatbot, required this.bottomBar})
      : super(key: key);
  final ChatBot chatbot;
  final bottomBar;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    if (context.read<BookingScreenBloc>().state.bookedTicketsList.isEmpty) {
      context
          .read<BookingScreenBloc>()
          .add(AzureDatabaseRetrieve(isDataBeingUpdated: true));
    }

    context.read<BookingScreenBloc>().add(UpdateTime());

    super.initState();
  }

  _onRefresh() async {
    context
        .read<BookingScreenBloc>()
        .add(AzureDatabaseRetrieve(isDataBeingUpdated: true));
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.bottomBar,
      floatingActionButton: widget.chatbot,
      body: SafeArea(
        child: SmartRefresher(
            // physics: const BouncingScrollPhysics(),
            header: WaterDropMaterialHeader(
              distance: 50,
              backgroundColor: Colors.grey.shade200,
              color: Colors.black87,
            ),
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: _body()),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<BookingScreenBloc, BookingScreenState>(
      builder: (context, state) {
        return ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: Colors.black,
            useInkWell: true,
            iconSize: 25,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade300,
            child: Stack(
              children: [
                SlidingUpPanel(
                  controller: PanelController(),
                  panelBuilder: (scrollController) {
                    return context
                            .read<BookingScreenBloc>()
                            .state
                            .isDataBeingUpdated
                        ? Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: LoadingAnimationWidget.staggeredDotWave(
                                  color: Colors.black, size: 30),
                            ),
                          )
                        : SizedBox(
                            child: ListView.builder(
                                controller: scrollController,
                                physics: const BouncingScrollPhysics(),
                                itemCount: context
                                    .read<BookingScreenBloc>()
                                    .state
                                    .bookedTicketsList
                                    .length,
                                itemBuilder: (context, int index) {
                                  Map ticket = context
                                      .read<BookingScreenBloc>()
                                      .state
                                      .bookedTicketsList[index];

                                  return TicketCard(ticket: ticket);
                                }),
                          );
                  },
                  minHeight: MediaQuery.of(context).size.height / 1.4,
                  maxHeight: MediaQuery.of(context).size.height / 1.3,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                SafeArea(
                  child: Container(
                      alignment: Alignment.topCenter,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 70),
                      child: Column(
                        children: [
                          Container(
                            width: 320,
                            height: 25,
                            margin: const EdgeInsets.only(left: 10),
                            child: const Text(
                              "Your Bookings",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          ),
                          _searchBar(),
                        ],
                      )),
                ),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.only(left: 10),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 28,
                          )),
                      IconButton(
                        onPressed: () {
                          CreateBasicNotification(
                              title:
                                  'Leave For Airport ${Emojis.transport_motor_scooter}',
                              body:
                                  'Reach Airport before 2 hours of departure');
                        },
                        padding: EdgeInsets.only(right: 20),
                        icon: const Icon(
                          Icons.notification_add,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _searchBar() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 50,
        width: 320,
        child: Row(
          children: [
            const SizedBox(
              height: 50,
              width: 50,
              child: Icon(Icons.menu),
            ),
            Flexible(
              child: SizedBox(
                height: 50,
                width: 280,
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,

                    contentPadding: const EdgeInsets.all(16.0),
                    hintText: "search",
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

class TicketCard extends StatelessWidget {
  TicketCard({required this.ticket});
  final Map ticket;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingScreenBloc, BookingScreenState>(
      builder: (bloccontext, state) {
        return ExpandableNotifier(
            child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  child: Column(
                    children: [
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
                                      ticket["departureIATACode"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: GoogleFonts.lato(
                                                fontWeight: FontWeight.w900)
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
                                          ticket["departureAirport"],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w900)
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
                                      ticket["arrivalIATACode"],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: GoogleFonts.lato(
                                                fontWeight: FontWeight.w900)
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
                                          ticket["arrivalAirport"],
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontFamily: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w900)
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
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        // height: 25,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 30,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Scheduled",
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontFamily: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold)
                                            .fontFamily,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: FittedBox(
                                        child: Text(
                                          ticket["departureSchedule"],
                                          style: TextStyle(
                                            color: Colors.green,
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
                                width:
                                    MediaQuery.of(context).size.width / 2 - 30,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Scheduled",
                                      style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontFamily: GoogleFonts.lato(
                                                fontWeight: FontWeight.bold)
                                            .fontFamily,
                                        fontSize: 11,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: FittedBox(
                                        child: Text(
                                          ticket["arrivalSchedule"],
                                          style: TextStyle(
                                            color: Colors.green,
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
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BlocBuilder<BookingScreenBloc, BookingScreenState>(
                              builder: (currContext, state) {
                            currContext
                                .read<BookingScreenBloc>()
                                .add(UpdateTime());
                            return Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Text(
                                currContext
                                    .read<BookingScreenBloc>()
                                    .state
                                    .time,
                                style: const TextStyle(
                                  color: Colors.amber,
                                  fontSize: 22,
                                ),
                              ),
                            );
                          }),
                          Container(
                            alignment: Alignment.centerRight,
                            margin: const EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              onPressed: () async {
                                await showAnimatedDialog(
                                    curve: Curves.fastOutSlowIn,
                                    duration: const Duration(milliseconds: 200),
                                    barrierDismissible: true,
                                    animationType: DialogTransitionType.scale,
                                    context: context,
                                    builder: (BuildContext currcontext) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        title: Text(
                                          'Are you sure you want to cancel?',
                                          style: TextStyle(
                                              fontFamily: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.bold)
                                                  .fontFamily,
                                              fontSize: 16),
                                        ),
                                        content: Text(
                                          'Changes will not be reverted',
                                          style: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.lato().fontFamily,
                                              fontSize: 13),
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                              onPressed: () {
                                                context
                                                    .read<BookingScreenBloc>()
                                                    .add(CancelTicket(
                                                        tableName:
                                                            "${ticket["arrivalIATACode"]}${ticket["departureIATACode"]}"));

                                                Navigator.of(currcontext)
                                                    .pop(false);
                                              },
                                              child: const Text('Yes')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(currcontext)
                                                    .pop(false);
                                              },
                                              child: const Text('No')),
                                        ],
                                      );
                                    });
                              },
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: GoogleFonts.lato(
                                            fontWeight: FontWeight.w800)
                                        .fontFamily,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                fixedSize: const Size.fromWidth(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                      iconColor: Colors.black,
                      hasIcon: true,
                    ),
                    header: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Text(
                        "More details",
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    collapsed: const SizedBox(),
                    expanded: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        height: 250,
                        child: Center(
                          child: ListView.builder(
                              itemCount: ticket.length - 3,
                              itemBuilder: (context, int index) {
                                return SizedBox(
                                  height: 25,
                                  width: 100,
                                  child: Row(
                                    children: [
                                      Container(
                                          child: Text(ticket.entries
                                                  .elementAt(index + 3)
                                                  .key +
                                              " : ")),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            ticket.entries
                                                .elementAt(index + 3)
                                                .value,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.blue.shade700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
